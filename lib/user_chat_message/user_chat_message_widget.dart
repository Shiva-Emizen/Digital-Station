import 'package:dio/dio.dart';
import 'package:permission_handler/permission_handler.dart';

import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'user_chat_message_model.dart';
export 'user_chat_message_model.dart';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class UserChatMessageWidget extends StatefulWidget {
  const UserChatMessageWidget({
    super.key,
    this.chatId,
    this.name,
    this.userId,
    this.id,
    this.profileURL,
    this.lastMessage,
    required this.userType,
  });

  final String? chatId;
  final String? name;
  final String? userId;
  final String? id;
  final String? profileURL;
  final DateTime? lastMessage;
  final String? userType;

  static String routeName = 'UserChatMessage';
  static String routePath = '/userChatMessage';

  @override
  State<UserChatMessageWidget> createState() => _UserChatMessageWidgetState();
}

class _UserChatMessageWidgetState extends State<UserChatMessageWidget>
    with WidgetsBindingObserver {
  Map<String, bool> _downloadingFiles = {};
  Map<String, double> _downloadProgress = {};
  Map<String, String> _downloadedFiles = {}; // URL -> local file path
  late UserChatMessageModel _model;
  bool _isSending = false;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  File? _selectedFile;
  String? _selectedFileName;
  String? _attachmentUrl;
  bool _isUploading = false;
  double _uploadProgress = 0.0;

  Future<void> _downloadFileWithProgress(String url, String fileName) async {
    try {
      setState(() {
        _downloadingFiles[url] = true;
        _downloadProgress[url] = 0.0;
      });

      // Use app documents directory (no permissions required)
      final appDir = await getApplicationDocumentsDirectory();
      final downloadDir = Directory('${appDir.path}/Downloads');

      if (!await downloadDir.exists()) {
        await downloadDir.create(recursive: true);
      }

      // Download file with progress tracking
      final dio = Dio();
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final fileExtension = fileName.contains('.') ? fileName.split('.').last : 'file';
      final uniqueFileName = 'download_${timestamp}.${fileExtension}';
      final filePath = '${downloadDir.path}/${uniqueFileName}';

      await dio.download(
        url,
        filePath,
        onReceiveProgress: (received, total) {
          if (total != -1) {
            setState(() {
              _downloadProgress[url] = received / total;
            });
          }
        },
      );

      setState(() {
        _downloadingFiles[url] = false;
        _downloadProgress.remove(url);
        _downloadedFiles[url] = filePath; // Store the downloaded file path
      });

      // Auto-open file after download
      _openDownloadedFile(filePath);

    } catch (e) {
      setState(() {
        _downloadingFiles[url] = false;
        _downloadProgress.remove(url);
      });
      print('Download error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Download failed: ${e.toString()}')),
      );
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    if (widget.chatId != null) {
      switch (state) {
        case AppLifecycleState.resumed:
          // App is in foreground
          FirebaseFirestore.instance
              .collection('chats')
              .doc(widget.chatId)
              .set({
            'isOnline': true,
            'lastSeen': FieldValue.serverTimestamp(),
            '${widget.userType}_online': true,
          }, SetOptions(merge: true));
          break;
        case AppLifecycleState.paused:
        case AppLifecycleState.inactive:
        case AppLifecycleState.detached:
          // App is in background or closed
          FirebaseFirestore.instance
              .collection('chats')
              .doc(widget.chatId)
              .set({
            'isOnline': false,
            'lastSeen': FieldValue.serverTimestamp(),
            '${widget.userType}_online': false,
          }, SetOptions(merge: true));
          break;
        default:
          break;
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => UserChatMessageModel());
    _model.textController ??= TextEditingController();
    _model.textFieldFocusNode ??= FocusNode();

    // Set current user as online
    if (widget.chatId != null) {
      FirebaseFirestore.instance.collection('chats').doc(widget.chatId).set({
        'isOnline': true,
        'lastSeen': FieldValue.serverTimestamp(),
        '${widget.userType}_online': true,
      }, SetOptions(merge: true));
    }

    // Listen to app lifecycle changes
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    // Set user as offline when leaving chat
    if (widget.chatId != null) {
      FirebaseFirestore.instance.collection('chats').doc(widget.chatId).set({
        'isOnline': false,
        'lastSeen': FieldValue.serverTimestamp(),
        '${widget.userType}_online': false,
      }, SetOptions(merge: true));
    }

    WidgetsBinding.instance.removeObserver(this);
    _model.dispose();
    super.dispose();
  }

  Future<void> _pickAttachment() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null && result.files.single.path != null) {
      setState(() {
        _selectedFile = File(result.files.single.path!);
        _selectedFileName = result.files.single.name;
      });
    }
  }

  Future<String?> _uploadAttachment(File file, String fileName) async {
    try {
      setState(() {
        _isUploading = true;
        _uploadProgress = 0.0;
      });
      final ref =
          FirebaseStorage.instance.ref().child('chat_attachments/$fileName');
      final uploadTask = ref.putFile(file);

      uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
        setState(() {
          _uploadProgress = snapshot.bytesTransferred /
              (snapshot.totalBytes == 0 ? 1 : snapshot.totalBytes);
        });
      });

      final snapshot = await uploadTask;
      final url = await snapshot.ref.getDownloadURL();
      setState(() {
        _isUploading = false;
        _uploadProgress = 0.0;
      });
      return url;
    } catch (e) {
      setState(() {
        _isUploading = false;
        _uploadProgress = 0.0;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Attachment upload failed: $e')),
      );
      return null;
    }
  }

  Widget _buildAttachmentPreview() {
    if (_selectedFile == null) return SizedBox.shrink();
    final isImage = _selectedFileName != null &&
        (_selectedFileName!.endsWith('.jpg') ||
            _selectedFileName!.endsWith('.jpeg') ||
            _selectedFileName!.endsWith('.png') ||
            _selectedFileName!.endsWith('.gif'));
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          isImage
              ? Image.file(
                  _selectedFile!,
                  width: 40,
                  height: 40,
                  fit: BoxFit.cover,
                )
              : Icon(Icons.insert_drive_file,
                  size: 40, color: Color(0xFF6E2A87)),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              _selectedFileName ?? '',
              style: TextStyle(color: Color(0xFF6E2A87)),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          IconButton(
            icon: Icon(Icons.close, color: Colors.red),
            onPressed: _isUploading
                ? null
                : () {
                    setState(() {
                      _selectedFile = null;
                      _selectedFileName = null;
                    });
                  },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<ChatsRecord>>(
      stream: queryChatsRecord(
        queryBuilder: (chatsRecord) => chatsRecord.where(
          'chat_id',
          isEqualTo: widget.chatId,
          isNull: (widget.chatId) == null,
        ),
        singleRecord: true,
      ),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
            body: Center(
              child: SizedBox(
                width: 50.0,
                height: 50.0,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Color(0xFF6E2A87),
                  ),
                ),
              ),
            ),
          );
        }
        List<ChatsRecord> userChatMessageChatsRecordList = snapshot.data!;
        if (snapshot.data!.isEmpty) {
          return Container();
        }
        final userChatMessageChatsRecord =
            userChatMessageChatsRecordList.isNotEmpty
                ? userChatMessageChatsRecordList.first
                : null;

        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
            appBar: AppBar(
              backgroundColor: Color(0xFF6E2A87),
              automaticallyImplyLeading: false,
              leading: Padding(
                padding: EdgeInsets.all(12.0),
                child: FlutterFlowIconButton(
                  borderRadius: 8.0,
                  buttonSize: 30.0,
                  fillColor: Colors.white,
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: Color(0xFF333333),
                    size: 15.0,
                  ),
                  onPressed: () async {
                    context.safePop();
                  },
                ),
              ),
              title: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    width: 40.0,
                    height: 40.0,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: widget.profileURL != null &&
                            widget.profileURL!.isNotEmpty
                        ? Image.network(
                            widget.profileURL!,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                decoration: BoxDecoration(
                                  color: Color(0xFF6E2A87),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.person,
                                  color: Colors.white,
                                  size: 24,
                                ),
                              );
                            },
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: CircularProgressIndicator(
                                    value: loadingProgress.expectedTotalBytes !=
                                            null
                                        ? loadingProgress
                                                .cumulativeBytesLoaded /
                                            loadingProgress.expectedTotalBytes!
                                        : null,
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Color(0xFF6E2A87)),
                                  ),
                                ),
                              );
                            },
                          )
                        : Container(
                            decoration: BoxDecoration(
                              color: Color(0xFF6E2A87),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.person,
                              color: Colors.white,
                              size: 24,
                            ),
                          ),
                  ),
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 12.0, 0.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: MediaQuery.sizeOf(context).width * 0.5,
                          decoration: BoxDecoration(),
                          child: Text(
                            valueOrDefault<String>(
                              widget.name,
                              'User',
                            ),
                            style: FlutterFlowTheme.of(context)
                                .titleMedium
                                .override(
                                  font: GoogleFonts.interTight(
                                    fontWeight: FontWeight.w600,
                                  ),
                                  color: FlutterFlowTheme.of(context)
                                      .primaryBackground,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                        ),
                        // Fixed Online/Offline status
                        StreamBuilder<DocumentSnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('chats')
                              .doc(widget.chatId)
                              .snapshots(),
                          builder: (context, chatSnapshot) {
                            if (!chatSnapshot.hasData) {
                              return Row(
                                children: [
                                  Container(
                                    width: 8,
                                    height: 8,
                                    decoration: BoxDecoration(
                                      color: Colors.grey,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    'Offline',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              );
                            }

                            final chatData = chatSnapshot.data?.data()
                                as Map<String, dynamic>?;
                            final isOnline = chatData?['isOnline'] == true;
                            final lastSeen =
                                chatData?['lastSeen'] as Timestamp?;

                            return Row(
                              children: [
                                Container(
                                  width: 8,
                                  height: 8,
                                  decoration: BoxDecoration(
                                    color:
                                        isOnline ? Colors.green : Colors.grey,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                SizedBox(width: 4),
                                Text(
                                  isOnline
                                      ? 'Active now'
                                      : lastSeen != null
                                          ? 'Last seen ${_formatLastSeen(lastSeen.toDate())}'
                                          : 'Offline',
                                  style: TextStyle(
                                    color:
                                        isOnline ? Colors.green : Colors.grey,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              actions: [],
              centerTitle: false,
              elevation: 0.0,
            ),
            body: SafeArea(
              top: true,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      controller: _model.columnController,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                16.0, 16.0, 16.0, 16.0),
                            child: StreamBuilder<List<ChatMessagesRecord>>(
                              stream: queryChatMessagesRecord(
                                parent: userChatMessageChatsRecord?.reference,
                                queryBuilder: (chatMessagesRecord) =>
                                    chatMessagesRecord.orderBy('timeStamp',
                                        descending: true),
                              ),
                              builder: (context, snapshot) {
                                if (!snapshot.hasData) {
                                  return Center(
                                    child: SizedBox(
                                      width: 50.0,
                                      height: 50.0,
                                      child: CircularProgressIndicator(
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                          Color(0xFF6E2A87),
                                        ),
                                      ),
                                    ),
                                  );
                                }
                                List<ChatMessagesRecord>
                                    listViewChatMessagesRecordList =
                                    snapshot.data!;

                                return ListView.builder(
                                  padding: EdgeInsets.zero,
                                  reverse: true,
                                  primary: false,
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  itemCount:
                                      listViewChatMessagesRecordList.length,
                                  itemBuilder: (context, listViewIndex) {
                                    final listViewChatMessagesRecord =
                                        listViewChatMessagesRecordList[
                                            listViewIndex];

                                    // Determine if current message is from the current user
                                    final isCurrentUserMessage =
                                        (widget.userType == 'freelancer' &&
                                                listViewChatMessagesRecord
                                                        .senderType ==
                                                    'freelancer') ||
                                            (widget.userType == 'client' &&
                                                listViewChatMessagesRecord
                                                        .senderType ==
                                                    'client');

                                    final showDateHeader =
                                        _shouldShowDateHeader(listViewIndex,
                                            listViewChatMessagesRecordList);

                                    return Column(
                                      key: ValueKey(listViewChatMessagesRecord
                                          .reference.id),
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        // Date Header
                                        if (showDateHeader &&
                                            listViewChatMessagesRecord
                                                    .timeStamp !=
                                                null)
                                          Container(
                                            margin: EdgeInsets.symmetric(
                                                vertical: 16.0),
                                            child: Center(
                                              child: Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 12.0,
                                                    vertical: 6.0),
                                                decoration: BoxDecoration(
                                                  color: Colors.grey[300],
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12.0),
                                                ),
                                                child: Text(
                                                  _formatMessageDate(
                                                      listViewChatMessagesRecord
                                                          .timeStamp!),
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodySmall
                                                      .override(
                                                        fontFamily:
                                                            'primaryFont',
                                                        color: Colors.grey[600],
                                                        fontSize: 12.0,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        letterSpacing: 0.0,
                                                      ),
                                                ),
                                              ),
                                            ),
                                          ),

                                        // Message bubble
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 0.0, 0.0, 8.0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                isCurrentUserMessage
                                                    ? MainAxisAlignment.end
                                                    : MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Flexible(
                                                child: Container(
                                                  constraints: BoxConstraints(
                                                    maxWidth:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.7,
                                                  ),
                                                  margin: isCurrentUserMessage
                                                      ? EdgeInsets.only(
                                                          left: 50.0,
                                                          right: 12.0)
                                                      : EdgeInsets.only(
                                                          left: 12.0,
                                                          right: 50.0),
                                                  decoration: BoxDecoration(
                                                    color: isCurrentUserMessage
                                                        ? Color(0xFF6E2A87)
                                                        : Color(0xFFD4D0F3),
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(16.0),
                                                      topRight:
                                                          Radius.circular(16.0),
                                                      bottomLeft: Radius.circular(
                                                          isCurrentUserMessage
                                                              ? 16.0
                                                              : 4.0),
                                                      bottomRight:
                                                          Radius.circular(
                                                              isCurrentUserMessage
                                                                  ? 4.0
                                                                  : 16.0),
                                                    ),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.all(12.0),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        if (listViewChatMessagesRecord
                                                            .message.isNotEmpty)
                                                          Text(
                                                            listViewChatMessagesRecord
                                                                .message,
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'primaryFont',
                                                                  color: isCurrentUserMessage
                                                                      ? Colors
                                                                          .white
                                                                      : FlutterFlowTheme.of(
                                                                              context)
                                                                          .primaryText,
                                                                  letterSpacing:
                                                                      0.0,
                                                                ),
                                                          ),
                                                        if (listViewChatMessagesRecord
                                                            .hasAttachmentUrl())
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    top: 8.0),
                                                            child: _buildAttachmentWidget(
                                                                listViewChatMessagesRecord,
                                                                isCurrentUserMessage),
                                                          ),
                                                        if (listViewChatMessagesRecord
                                                                .timeStamp !=
                                                            null)
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    top: 4.0),
                                                            child: Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              mainAxisAlignment:
                                                                  isCurrentUserMessage
                                                                      ? MainAxisAlignment
                                                                          .end
                                                                      : MainAxisAlignment
                                                                          .start,
                                                              children: [
                                                                Text(
                                                                  dateTimeFormat(
                                                                    "jm",
                                                                    listViewChatMessagesRecord
                                                                        .timeStamp!,
                                                                    locale: FFLocalizations.of(
                                                                            context)
                                                                        .languageCode,
                                                                  ),
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodySmall
                                                                      .override(
                                                                        fontFamily:
                                                                            'primaryFont',
                                                                        color: isCurrentUserMessage
                                                                            ? Colors.white.withOpacity(0.8)
                                                                            : FlutterFlowTheme.of(context).secondaryText,
                                                                        fontSize:
                                                                            10.0,
                                                                        letterSpacing:
                                                                            0.0,
                                                                      ),
                                                                ),
                                                                if (isCurrentUserMessage) ...[
                                                                  SizedBox(
                                                                      width:
                                                                          4.0),
                                                                  Icon(
                                                                    Icons
                                                                        .done_all,
                                                                    color: Colors
                                                                        .white
                                                                        .withOpacity(
                                                                            0.6),
                                                                    size: 14.0,
                                                                  ),
                                                                ],
                                                              ],
                                                            ),
                                                          ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                  controller: _model.listViewController,
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: AlignmentDirectional(0.0, 1.0),
                    child: Material(
                      color: Colors.transparent,
                      elevation: 10.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0.0),
                      ),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(0.0),
                          border: Border.all(
                            color: Colors.white,
                            width: 1.0,
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              16.0, 16.0, 16.0, 16.0),
                          child: Material(
                            color: Colors.transparent,
                            elevation: 2.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Color(0xFFDFE0DF),
                                borderRadius: BorderRadius.circular(12.0),
                                border: Border.all(
                                  color: Color(0xFFDFE0DF),
                                  width: 1.0,
                                ),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  _buildAttachmentPreview(),
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      IconButton(
                                        icon: Icon(Icons.attach_file,
                                            color: Color(0xFF6E2A87)),
                                        onPressed: _isUploading
                                            ? null
                                            : _pickAttachment,
                                      ),
                                      Expanded(
                                        child: Align(
                                          alignment:
                                              AlignmentDirectional(-1.0, 0.0),
                                          child: TextFormField(
                                            controller: _model.textController,
                                            focusNode:
                                                _model.textFieldFocusNode,
                                            autofocus: false,
                                            obscureText: false,
                                            decoration: InputDecoration(
                                              hintText: 'Type a message',
                                              hintStyle: FlutterFlowTheme.of(
                                                      context)
                                                  .bodyMedium
                                                  .override(
                                                    fontFamily: 'primaryFont',
                                                    color: Color(0xFF8C8C8C),
                                                  ),
                                              border: OutlineInputBorder(
                                                borderSide: BorderSide.none,
                                              ),
                                              // enabledBorder: OutlineInputBorder(
                                              //   borderSide: BorderSide(
                                              //     color: Color(0xFFDFE0DF),
                                              //     width: 1.0,
                                              //   ),
                                              //   borderRadius: BorderRadius.circular(12.0),
                                              // ),
                                              // focusedBorder: OutlineInputBorder(
                                              //   borderSide: BorderSide(
                                              //     color: Color(0xFF6E2A87),
                                              //     width: 1.0,
                                              //   ),
                                              //   borderRadius: BorderRadius.circular(12.0),
                                              // ),
                                              contentPadding:
                                                  EdgeInsetsDirectional
                                                      .fromSTEB(16.0, 16.0,
                                                          16.0, 16.0),
                                            ),
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily: 'primaryFont',
                                                  color: Color(0xFF8C8C8C),
                                                ),
                                            minLines: 1,
                                            validator: _model
                                                .textControllerValidator
                                                .asValidator(context),
                                            enabled: !_isUploading,
                                          ),
                                        ),
                                      ),
                                      _isUploading
                                          ? Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 16.0),
                                              child: Row(
                                                children: [
                                                  SizedBox(
                                                    width: 24,
                                                    height: 24,
                                                    child:
                                                        CircularProgressIndicator(
                                                      strokeWidth: 2,
                                                      value: _uploadProgress,
                                                      valueColor:
                                                          AlwaysStoppedAnimation<
                                                                  Color>(
                                                              Color(
                                                                  0xFF6E2A87)),
                                                    ),
                                                  ),
                                                  SizedBox(width: 8),
                                                  Text(
                                                    '${(_uploadProgress * 100).toStringAsFixed(0)}%',
                                                    style: TextStyle(
                                                        color:
                                                            Color(0xFF6E2A87)),
                                                  ),
                                                ],
                                              ),
                                            )
                                          : Align(
                                              alignment: AlignmentDirectional(
                                                  0.0, 0.0),
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        0.0, 0.0, 16.0, 0.0),
                                                child: InkWell(
                                                  splashColor:
                                                      Colors.transparent,
                                                  focusColor:
                                                      Colors.transparent,
                                                  hoverColor:
                                                      Colors.transparent,
                                                  highlightColor:
                                                      Colors.transparent,
                                                  onTap: () async {
                                                    // Prevent multiple sends
                                                    if (_isSending) return;

                                                    if (_model.textController.text != '' || _selectedFile != null) {
                                                      setState(() {
                                                        _isSending = true;
                                                      });

                                                      try {
                                                        String? attachmentUrl;
                                                        if (_selectedFile != null && _selectedFileName != null) {
                                                          attachmentUrl = await _uploadAttachment(_selectedFile!, _selectedFileName!);
                                                          if (attachmentUrl == null) {
                                                            setState(() {
                                                              _isSending = false;
                                                            });
                                                            return;
                                                          }
                                                        }

                                                        await ChatMessagesRecord.createDoc(userChatMessageChatsRecord!.reference).set({
                                                          ...createChatMessagesRecordData(
                                                            message: _model.textController.text,
                                                            senderType: widget.userType == 'freelancer' ? 'freelancer' : 'client',
                                                            senderId: widget.userId,
                                                            attachmentUrl: attachmentUrl,
                                                          ),
                                                          ...mapToFirestore({
                                                            'timeStamp': FieldValue.serverTimestamp(),
                                                          }),
                                                        });

                                                        await userChatMessageChatsRecord.reference.update({
                                                          ...createChatsRecordData(
                                                            lastMessage: _model.textController.text.isNotEmpty
                                                                ? _model.textController.text
                                                                : 'Attachment',
                                                          ),
                                                          ...mapToFirestore({
                                                            'timeStamp': FieldValue.serverTimestamp(),
                                                            'lastUpdated': FieldValue.serverTimestamp(),
                                                          }),
                                                        });

                                                        await Future.delayed(Duration(milliseconds: 10));
                                                        await _model.columnController?.animateTo(
                                                          _model.columnController!.position.maxScrollExtent,
                                                          duration: Duration(milliseconds: 20),
                                                          curve: Curves.ease,
                                                        );

                                                        safeSetState(() {
                                                          _model.textController?.clear();
                                                          _selectedFile = null;
                                                          _selectedFileName = null;
                                                        });

                                                      } catch (e) {
                                                        ScaffoldMessenger.of(context).showSnackBar(
                                                          SnackBar(
                                                            content: Text('Failed to send message: $e'),
                                                            backgroundColor: Colors.red,
                                                          ),
                                                        );
                                                      } finally {
                                                        setState(() {
                                                          _isSending = false;
                                                        });
                                                      }
                                                    } else {
                                                      ScaffoldMessenger.of(context).showSnackBar(
                                                        SnackBar(
                                                          content: Text(
                                                            'Please type something or select an attachment',
                                                            style: TextStyle(color: Colors.white),
                                                          ),
                                                          duration: Duration(milliseconds: 4000),
                                                          backgroundColor: Color(0xFF3D348B),
                                                        ),
                                                      );
                                                    }
                                                  },
                                                  child: _isSending
                                                      ? SizedBox(
                                                    width: 20,
                                                    height: 20,
                                                    child: CircularProgressIndicator(
                                                      strokeWidth: 2,
                                                      valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF6E2A87)),
                                                    ),
                                                  )
                                                      : Icon(
                                                    Icons.send,
                                                    color: Color(0xFF6E2A87),
                                                    size: 24.0,
                                                  ),
                                                ),
                                              ),
                                            ),
                                    ].divide(SizedBox(width: 12.0)),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  String _formatLastSeen(DateTime lastSeen) {
    final now = DateTime.now();
    final difference = now.difference(lastSeen);

    if (difference.inMinutes < 1) {
      return 'just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d ago';
    } else {
      return dateTimeFormat('MMM d', lastSeen);
    }
  }

  String _formatMessageDate(DateTime messageDate) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(Duration(days: 1));
    final messageDay =
        DateTime(messageDate.year, messageDate.month, messageDate.day);

    if (messageDay == today) {
      return 'Today';
    } else if (messageDay == yesterday) {
      return 'Yesterday';
    } else {
      return dateTimeFormat('MMM d, yyyy', messageDate);
    }
  }

  bool _shouldShowDateHeader(int index, List<ChatMessagesRecord> messages) {
    if (index == messages.length - 1)
      return true; // Show for the oldest message

    final currentMessage = messages[index];
    final nextMessage = messages[index + 1];

    if (currentMessage.timeStamp == null || nextMessage.timeStamp == null)
      return false;

    final currentDate = DateTime(
      currentMessage.timeStamp!.year,
      currentMessage.timeStamp!.month,
      currentMessage.timeStamp!.day,
    );

    final nextDate = DateTime(
      nextMessage.timeStamp!.year,
      nextMessage.timeStamp!.month,
      nextMessage.timeStamp!.day,
    );

    return currentDate != nextDate;
  }

  Widget _buildAttachmentWidget(ChatMessagesRecord message, bool isCurrentUser) {
    final isImage = message.attachmentUrl.endsWith('.jpg') ||
        message.attachmentUrl.endsWith('.png') ||
        message.attachmentUrl.endsWith('.jpeg') ||
        message.attachmentUrl.endsWith('.gif');

    final isVideo = message.attachmentUrl.endsWith('.mp4') ||
        message.attachmentUrl.endsWith('.mov') ||
        message.attachmentUrl.endsWith('.avi');

    final isDownloading = _downloadingFiles[message.attachmentUrl] ?? false;
    final progress = _downloadProgress[message.attachmentUrl] ?? 0.0;
    final isDownloaded = _downloadedFiles.containsKey(message.attachmentUrl);
    final isSentByCurrentUser = message.senderId == widget.id; // Check if sent by current user

    if (isImage) {
      return Stack(
        alignment: Alignment.center,
        children: [
          InkWell(
            onTap: isDownloading ? null : () {
              if (isSentByCurrentUser) {
                // For images sent by current user, open directly from URL
                _showImageDialog(message.attachmentUrl);
              } else {
                // For received images, download first then open
                if (isDownloaded) {
                  _openDownloadedFile(_downloadedFiles[message.attachmentUrl]!);
                } else {
                  final fileName = message.attachmentUrl.split('/').last.split('?').first;
                  _downloadFileWithProgress(message.attachmentUrl, fileName);
                }
              }
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                message.attachmentUrl,
                width: 150,
                height: 150,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      color: isCurrentUser
                          ? Colors.white.withOpacity(0.2)
                          : Colors.grey.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.broken_image,
                          color: isCurrentUser ? Colors.white : Colors.grey[600],
                          size: 40,
                        ),
                        Text(
                          'Image failed to load',
                          style: TextStyle(
                            color: isCurrentUser ? Colors.white : Colors.grey[600],
                            fontSize: 10,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                },
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      color: isCurrentUser
                          ? Colors.white.withOpacity(0.2)
                          : Colors.grey.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes!
                            : null,
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          isCurrentUser ? Colors.white : Color(0xFF6E2A87),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          // Download progress overlay (only for received files)
          if (isDownloading && !isSentByCurrentUser)
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.7),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 50,
                      height: 50,
                      child: CircularProgressIndicator(
                        value: progress,
                        strokeWidth: 4,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        backgroundColor: Colors.white.withOpacity(0.3),
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '${(progress * 100).toInt()}%',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Downloading...',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      );
    } else {
      // For non-image files (videos, documents, etc.)
      String displayText;
      if (isSentByCurrentUser) {
        displayText = isVideo ? 'Video File' : 'Document';
      } else {
        if (isDownloading) {
          displayText = 'Downloading...';
        } else if (isDownloaded) {
          displayText = 'Open';
        } else {
          displayText = isVideo ? 'Video File' : 'Document';
        }
      }

      return InkWell(
        onTap: isDownloading ? null : () {
          if (isSentByCurrentUser) {
            // For files sent by current user, try to open with external app
            _openWithExternalApp(message.attachmentUrl);
          } else {
            // For received files
            if (isDownloaded) {
              _openDownloadedFile(_downloadedFiles[message.attachmentUrl]!);
            } else {
              final fileName = message.attachmentUrl.split('/').last.split('?').first;
              _downloadFileWithProgress(message.attachmentUrl, fileName);
            }
          }
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: isCurrentUser
                ? Colors.white.withOpacity(0.2)
                : Colors.grey.withOpacity(0.2),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: isCurrentUser ? Colors.white : Colors.grey,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                isDownloaded && !isSentByCurrentUser ? Icons.open_in_new_outlined :
                isVideo ? Icons.videocam : Icons.attach_file,
                color: isCurrentUser ? Colors.white : Colors.grey[600],
                size: 16,
              ),
              SizedBox(width: 4),
              Text(
                displayText,
                style: TextStyle(
                  color: isCurrentUser ? Colors.white : Colors.grey[600],
                  fontWeight: FontWeight.w500,
                ),
              ),
              if (isDownloading) ...[
                SizedBox(width: 8),
                SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(
                    value: progress,
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      isCurrentUser ? Colors.white : Color(0xFF6E2A87),
                    ),
                  ),
                ),
                SizedBox(width: 4),
                Text(
                  '${(progress * 100).toInt()}%',
                  style: TextStyle(
                    color: isCurrentUser ? Colors.white : Colors.grey[600],
                    fontSize: 10,
                  ),
                ),
              ],
            ],
          ),
        ),
      );
    }
  }

  Future<void> _openDownloadedFile(String filePath) async {
    try {
      final file = File(filePath);
      if (await file.exists()) {
        final fileName = filePath.split('/').last;
        final fileType = _getFileType(fileName);

        // Navigate to file viewer
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FileViewerWidget(
              filePath: filePath,
              fileName: fileName,
              fileType: fileType,
            ),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('File not found')),
        );
      }
    } catch (e) {
      print('Error opening file: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error opening file: ${e.toString()}')),
      );
    }
  }

  String _getFileType(String fileName) {
    final extension = fileName.split('.').last.toLowerCase();
    switch (extension) {
      case 'pdf':
        return 'application/pdf';
      case 'mp4':
      case 'mov':
      case 'avi':
      case 'mkv':
        return 'video/$extension';
      case 'jpg':
      case 'jpeg':
      case 'png':
      case 'gif':
        return 'image/$extension';
      case 'doc':
      case 'docx':
        return 'application/msword';
      case 'xls':
      case 'xlsx':
        return 'application/excel';
      case 'txt':
        return 'text/plain';
      default:
        return 'application/octet-stream';
    }
  }

  void _showImageDialog(String imageUrl) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.black,
          child: Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppBar(
                  title: Text('Image'),
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  leading: IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),
                Flexible(
                  child: InteractiveViewer(
                    minScale: 0.5,
                    maxScale: 4.0,
                    child: Image.network(
                      imageUrl,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.error, color: Colors.white, size: 60),
                              SizedBox(height: 16),
                              Text('Error loading image', style: TextStyle(color: Colors.white)),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _openWithExternalApp(String url) async {
    try {
      final uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('No app found to open this file')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error opening file: ${e.toString()}')),
      );
    }
  }
}



class FileViewerWidget extends StatefulWidget {
  final String filePath;
  final String fileName;
  final String fileType;

  const FileViewerWidget({
    Key? key,
    required this.filePath,
    required this.fileName,
    required this.fileType,
  }) : super(key: key);

  @override
  State<FileViewerWidget> createState() => _FileViewerWidgetState();
}

class _FileViewerWidgetState extends State<FileViewerWidget> {
  bool _isImageFile() {
    return widget.fileType.toLowerCase().contains('image') ||
        widget.fileName.toLowerCase().endsWith('.jpg') ||
        widget.fileName.toLowerCase().endsWith('.jpeg') ||
        widget.fileName.toLowerCase().endsWith('.png') ||
        widget.fileName.toLowerCase().endsWith('.gif');
  }

  bool _isVideoFile() {
    return widget.fileType.toLowerCase().contains('video') ||
        widget.fileName.toLowerCase().endsWith('.mp4') ||
        widget.fileName.toLowerCase().endsWith('.mov') ||
        widget.fileName.toLowerCase().endsWith('.avi') ||
        widget.fileName.toLowerCase().endsWith('.mkv');
  }

  bool _isPdfFile() {
    return widget.fileType.toLowerCase().contains('pdf') ||
        widget.fileName.toLowerCase().endsWith('.pdf');
  }

  Future<void> _openWithExternalApp() async {
    try {
      final uri = Uri.file(widget.filePath);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('No app found to open this file')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error opening file: ${e.toString()}')),
      );
    }
  }

  Widget _buildFileViewer() {
    if (_isImageFile()) {
      return _buildImageViewer();
    } else {
      return _buildUnsupportedFileViewer();
    }
  }

  Widget _buildImageViewer() {
    return InteractiveViewer(
      minScale: 0.5,
      maxScale: 4.0,
      child: Center(
        child: Image.file(
          File(widget.filePath),
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.broken_image, size: 80, color: Colors.grey),
                  SizedBox(height: 16),
                  Text('Error loading image', style: TextStyle(color: Colors.grey)),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _openWithExternalApp,
                    child: Text('Open with External App'),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildUnsupportedFileViewer() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            _isVideoFile() ? Icons.videocam :
            _isPdfFile() ? Icons.picture_as_pdf :
            Icons.insert_drive_file,
            size: 100,
            color: Colors.grey[400],
          ),
          SizedBox(height: 24),
          Text(
            _isVideoFile() ? 'Video File' :
            _isPdfFile() ? 'PDF Document' :
            'Document',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey[600],
            ),
          ),
          SizedBox(height: 8),
          Text(
            'File: ${widget.fileName}',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: _openWithExternalApp,
            icon: Icon(Icons.open_in_new),
            label: Text('Open with External App'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF6E2A87),
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.fileName,
          overflow: TextOverflow.ellipsis,
        ),
        backgroundColor: Color(0xFF6E2A87),
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(Icons.open_in_new),
            onPressed: _openWithExternalApp,
            tooltip: 'Open with External App',
          ),
        ],
      ),
      body: SafeArea(
        child: _buildFileViewer(),
      ),
    );
  }
}