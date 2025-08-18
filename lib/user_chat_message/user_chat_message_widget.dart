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

class _UserChatMessageWidgetState extends State<UserChatMessageWidget> {
  late UserChatMessageModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  File? _selectedFile;
  String? _selectedFileName;
  String? _attachmentUrl;
  bool _isUploading = false;
  double _uploadProgress = 0.0;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => UserChatMessageModel());
    _model.textController ??= TextEditingController();
    _model.textFieldFocusNode ??= FocusNode();
    if (widget.chatId != null) {
      FirebaseFirestore.instance
          .collection('chats')
          .doc(widget.chatId)
          .set({'isOnline': true},SetOptions(merge: true));
    }
  }

  @override
  void dispose() {
    if (widget.chatId != null) {
      FirebaseFirestore.instance
          .collection('chats')
          .doc(widget.chatId)
          .set({'isOnline': false},SetOptions(merge: true));
    }
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
      final ref = FirebaseStorage.instance.ref().child('chat_attachments/$fileName');
      final uploadTask = ref.putFile(file);

      uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
        setState(() {
          _uploadProgress = snapshot.bytesTransferred / (snapshot.totalBytes == 0 ? 1 : snapshot.totalBytes);
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
              : Icon(Icons.insert_drive_file, size: 40, color: Color(0xFF6E2A87)),
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
                    child: Image.network(
                      widget.profileURL!,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 12.0, 0.0),
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
                              'na',
                            ),
                            style: FlutterFlowTheme.of(context)
                                .titleMedium
                                .override(
                              font: GoogleFonts.interTight(
                                fontWeight: FontWeight.w600,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .titleMedium
                                    .fontStyle,
                              ),
                              color: FlutterFlowTheme.of(context)
                                  .primaryBackground,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.w600,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .titleMedium
                                  .fontStyle,
                            ),
                          ),
                        ),
                        // Online/Offline status
                        StreamBuilder<DocumentSnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('chats')
                              .doc(widget.chatId)
                              .snapshots(),
                          builder: (context, userSnapshot) {
                            if (!snapshot.hasData || snapshot.data!.isEmpty) {
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

                            final isOnline = userSnapshot.data?['isOnline'] == true;
                            return Row(
                              children: [
                                Container(
                                  width: 8,
                                  height: 8,
                                  decoration: BoxDecoration(
                                    color: isOnline ? Colors.green : Colors.grey,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                SizedBox(width: 4),
                                Text(
                                  isOnline ? 'Active now' : 'Offline',
                                  style: TextStyle(
                                    color: isOnline ? Colors.green : Colors.grey,
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
                                    return Column(
                                      key: ValueKey(listViewChatMessagesRecord
                                          .timeStamp ==
                                          widget.lastMessage
                                          ? 'lastMessageKey'
                                          : ''),
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        if (listViewChatMessagesRecord
                                            .senderType ==
                                            'client')
                                          Padding(
                                            padding:
                                            EdgeInsetsDirectional.fromSTEB(
                                                0.0, 0.0, 0.0, 16.0),
                                            child: Container(
                                              decoration: BoxDecoration(),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                MainAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding:
                                                    EdgeInsets.all(12.0),
                                                    child: Container(
                                                      width: 220.0,
                                                      decoration: BoxDecoration(
                                                        color:
                                                        Color(0xFFD4D0F3),
                                                        borderRadius:
                                                        BorderRadius
                                                            .circular(
                                                            12.0),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                        EdgeInsets.all(
                                                            16.0),
                                                        child: Column(
                                                          mainAxisSize:
                                                          MainAxisSize.max,
                                                          crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                          children: [
                                                            Text(
                                                              listViewChatMessagesRecord
                                                                  .message,
                                                              style: FlutterFlowTheme
                                                                  .of(context)
                                                                  .bodyMedium
                                                                  .override(
                                                                font: GoogleFonts
                                                                    .inter(
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                      context)
                                                                      .bodyMedium
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                      context)
                                                                      .bodyMedium
                                                                      .fontStyle,
                                                                ),
                                                                color: FlutterFlowTheme.of(
                                                                    context)
                                                                    .primaryText,
                                                                letterSpacing:
                                                                0.0,
                                                                fontWeight: FlutterFlowTheme.of(
                                                                    context)
                                                                    .bodyMedium
                                                                    .fontWeight,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                    context)
                                                                    .bodyMedium
                                                                    .fontStyle,
                                                              ),
                                                            ),
                                                            if (listViewChatMessagesRecord.hasAttachmentUrl())
                                                              Padding(
                                                                padding: EdgeInsets.only(top: 8.0),
                                                                child: listViewChatMessagesRecord.attachmentUrl.endsWith('.jpg') ||
                                                                    listViewChatMessagesRecord.attachmentUrl.endsWith('.png')
                                                                    ? Image.network(
                                                                  listViewChatMessagesRecord.attachmentUrl,
                                                                  width: 150,
                                                                  height: 150,
                                                                  fit: BoxFit.cover,
                                                                )
                                                                    : InkWell(
                                                                  onTap: () async {
                                                                    await launchUrl(Uri.parse(listViewChatMessagesRecord.attachmentUrl));
                                                                  },
                                                                  child: Text(
                                                                    'View Attachment',
                                                                    style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline),
                                                                  ),
                                                                ),
                                                              ),
                                                            if (listViewChatMessagesRecord.timeStamp != null)
                                                              Align(
                                                                alignment: AlignmentDirectional(1.0, 0.0),
                                                                child: Text(
                                                                  dateTimeFormat(
                                                                    "jm",
                                                                    listViewChatMessagesRecord.timeStamp!,
                                                                    locale: FFLocalizations.of(context).languageCode,
                                                                  ),
                                                                  textAlign: TextAlign.end,
                                                                  style: FlutterFlowTheme.of(context).bodySmall.override(
                                                                    font: GoogleFonts.inter(
                                                                      fontWeight: FlutterFlowTheme.of(context).bodySmall.fontWeight,
                                                                      fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                    ),
                                                                    color: FlutterFlowTheme.of(context).secondaryText,
                                                                    letterSpacing: 0.0,
                                                                  ),
                                                                ),
                                                              )
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        if (listViewChatMessagesRecord
                                            .senderType ==
                                            'freelancer')
                                          Align(
                                            alignment:
                                            AlignmentDirectional(1.0, 0.0),
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                  0.0, 0.0, 0.0, 16.0),
                                              child: Container(
                                                decoration: BoxDecoration(),
                                                alignment: AlignmentDirectional(
                                                    0.0, -1.0),
                                                child: Row(
                                                  mainAxisSize:
                                                  MainAxisSize.max,
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                      EdgeInsets.all(12.0),
                                                      child: Container(
                                                        width: 220.0,
                                                        decoration:
                                                        BoxDecoration(
                                                          color:
                                                          Color(0xFF6E2A87),
                                                          borderRadius:
                                                          BorderRadius
                                                              .circular(
                                                              12.0),
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                          EdgeInsets.all(
                                                              16.0),
                                                          child: Column(
                                                            mainAxisSize:
                                                            MainAxisSize
                                                                .max,
                                                            crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                            children: [
                                                              Text(
                                                                listViewChatMessagesRecord
                                                                    .message,
                                                                style: FlutterFlowTheme.of(
                                                                    context)
                                                                    .bodyMedium
                                                                    .override(
                                                                  font: GoogleFonts
                                                                      .inter(
                                                                    fontWeight: FlutterFlowTheme.of(context)
                                                                        .bodyMedium
                                                                        .fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(context)
                                                                        .bodyMedium
                                                                        .fontStyle,
                                                                  ),
                                                                  color: FlutterFlowTheme.of(
                                                                      context)
                                                                      .primaryBackground,
                                                                  letterSpacing:
                                                                  0.0,
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                      context)
                                                                      .bodyMedium
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                      context)
                                                                      .bodyMedium
                                                                      .fontStyle,
                                                                ),
                                                              ),
                                                              if (listViewChatMessagesRecord.hasAttachmentUrl())
                                                                Padding(
                                                                  padding: EdgeInsets.only(top: 8.0),
                                                                  child: listViewChatMessagesRecord.attachmentUrl.endsWith('.jpg') ||
                                                                      listViewChatMessagesRecord.attachmentUrl.endsWith('.png')
                                                                      ? Image.network(
                                                                    listViewChatMessagesRecord.attachmentUrl,
                                                                    width: 150,
                                                                    height: 150,
                                                                    fit: BoxFit.cover,
                                                                  )
                                                                      : InkWell(
                                                                    onTap: () async {
                                                                      await launchUrl(Uri.parse(listViewChatMessagesRecord.attachmentUrl));
                                                                    },
                                                                    child: Text(
                                                                      'View Attachment',
                                                                      style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline),
                                                                    ),
                                                                  ),
                                                                ),
                                                              Align(
                                                                alignment:
                                                                AlignmentDirectional(
                                                                    1.0,
                                                                    0.0),
                                                                child: Text(
                                                                  valueOrDefault<
                                                                      String>(
                                                                    dateTimeFormat(
                                                                      "jm",
                                                                      listViewChatMessagesRecord
                                                                          .timeStamp,
                                                                      locale: FFLocalizations.of(
                                                                          context)
                                                                          .languageCode,
                                                                    ),
                                                                    '00:00',
                                                                  ),
                                                                  textAlign:
                                                                  TextAlign
                                                                      .end,
                                                                  style: FlutterFlowTheme.of(
                                                                      context)
                                                                      .bodySmall
                                                                      .override(
                                                                    font: GoogleFonts
                                                                        .inter(
                                                                      fontWeight: FlutterFlowTheme.of(context)
                                                                          .bodySmall
                                                                          .fontWeight,
                                                                      fontStyle: FlutterFlowTheme.of(context)
                                                                          .bodySmall
                                                                          .fontStyle,
                                                                    ),
                                                                    color: FlutterFlowTheme.of(context)
                                                                        .primaryBackground,
                                                                    letterSpacing:
                                                                    0.0,
                                                                    fontWeight: FlutterFlowTheme.of(context)
                                                                        .bodySmall
                                                                        .fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(context)
                                                                        .bodySmall
                                                                        .fontStyle,
                                                                  ),
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
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      IconButton(
                                        icon: Icon(Icons.attach_file, color: Color(0xFF6E2A87)),
                                        onPressed: _isUploading ? null : _pickAttachment,
                                      ),
                                      Expanded(
                                        child: Align(
                                          alignment: AlignmentDirectional(-1.0, 0.0),
                                          child: TextFormField(
                                            controller: _model.textController,
                                            focusNode: _model.textFieldFocusNode,
                                            autofocus: false,
                                            obscureText: false,

                                            decoration: InputDecoration(
                                              hintText: 'Type a message',
                                              hintStyle: FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .override(
                                                fontFamily: 'primaryFont',
                                                color: Color(0xFF8C8C8C),
                                              ),
                                              border:OutlineInputBorder(
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
                                              contentPadding: EdgeInsetsDirectional.fromSTEB(
                                                  16.0, 16.0, 16.0, 16.0),
                                            ),
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                              fontFamily: 'primaryFont',
                                              color: Color(0xFF8C8C8C),
                                            ),
                                            minLines: 1,
                                            validator: _model.textControllerValidator
                                                .asValidator(context),
                                            enabled: !_isUploading,
                                          ),
                                        ),
                                      ),
                                      _isUploading
                                          ? Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                        child: Row(
                                          children: [
                                            SizedBox(
                                              width: 24,
                                              height: 24,
                                              child: CircularProgressIndicator(
                                                strokeWidth: 2,
                                                value: _uploadProgress,
                                                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF6E2A87)),
                                              ),
                                            ),
                                            SizedBox(width: 8),
                                            Text(
                                              '${(_uploadProgress * 100).toStringAsFixed(0)}%',
                                              style: TextStyle(color: Color(0xFF6E2A87)),
                                            ),
                                          ],
                                        ),
                                      )
                                          : Align(
                                        alignment: AlignmentDirectional(0.0, 0.0),
                                        child: Padding(
                                          padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 16.0, 0.0),
                                          child: InkWell(
                                            splashColor: Colors.transparent,
                                            focusColor: Colors.transparent,
                                            hoverColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            onTap: () async {
                                              if (_model.textController.text != '' || _selectedFile != null) {
                                                String? attachmentUrl;
                                                if (_selectedFile != null && _selectedFileName != null) {
                                                  attachmentUrl = await _uploadAttachment(_selectedFile!, _selectedFileName!);
                                                }
                                                await ChatMessagesRecord.createDoc(
                                                    userChatMessageChatsRecord!.reference
                                                ).set({
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
                                                    lastMessage: _model.textController.text,
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
                                              } else {
                                                ScaffoldMessenger.of(context).showSnackBar(
                                                  SnackBar(
                                                    content: Text(
                                                      'Please type something or select an attachment',
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                    duration: Duration(milliseconds: 4000),
                                                    backgroundColor: Color(0xFF3D348B),
                                                  ),
                                                );
                                              }
                                            },
                                            child: Icon(
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
}