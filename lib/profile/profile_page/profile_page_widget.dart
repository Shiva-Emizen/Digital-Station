import 'dart:io';
import 'dart:typed_data';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:path_provider/path_provider.dart';
import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/upload_data.dart';
import 'profile_page_model.dart';
export 'profile_page_model.dart';

class ProfilePageWidget extends StatefulWidget {
  const ProfilePageWidget({super.key});

  static String routeName = 'ProfilePage';
  static String routePath = '/profilePage';

  @override
  State<ProfilePageWidget> createState() => _ProfilePageWidgetState();
}

class _ProfilePageWidgetState extends State<ProfilePageWidget> {
  late ProfilePageModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool _apiCalled = false;

  File? _pickedImage;
  Uint8List? _pickedImageBytes;
  bool _isUploadingAvatar = false;
  FFUploadedFile? _uploadedLocalFile;
  ApiCallResponse? _avatarApiResult;
  bool _isAvatar = false;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ProfilePageModel());
  }

  Future<void> _fetchProfileData() async {
    final result = await ClientHomePageGroup.clientProfileCall.call(
      authToken: FFAppState().apitoken,
    );
    if (!mounted) return;
    setState(() {
      _model.apiResultoen = result;
      final avatarUrl =
          getJsonField(result.jsonBody ?? '', r'''$.data.avatar.url''')
              ?.toString();
      _isAvatar = avatarUrl != null && avatarUrl.isNotEmpty;
    });
  }

  Future<File> _saveImageToAppDir(String originalPath, Uint8List? bytes) async {
    try {
      final appDir = await getApplicationDocumentsDirectory();
      final fileName = 'avatar_${DateTime.now().millisecondsSinceEpoch}.jpg';
      final savedFile = File('${appDir.path}/$fileName');

      if (bytes != null) {
        await savedFile.writeAsBytes(bytes);
      } else {
        final originalFile = File(originalPath);
        if (await originalFile.exists()) {
          await originalFile.copy(savedFile.path);
        } else {
          throw Exception('Original file not found');
        }
      }

      return savedFile;
    } catch (e) {
      throw Exception('Failed to save image: $e');
    }
  }

  Future<void> _pickAndUploadAvatar() async {
    try {
      final selectedMedia = await selectMediaWithSourceBottomSheet(
        context: context,
        allowPhoto: true,
      );

      if (selectedMedia == null || selectedMedia.isEmpty) return;

      if (!selectedMedia
          .every((m) => validateFileFormat(m.storagePath, context))) {
        return;
      }

      setState(() => _isUploadingAvatar = true);

      final media = selectedMedia.first;
      var selectedUploadedFiles = <FFUploadedFile>[];

      try {
        selectedUploadedFiles = selectedMedia
            .map((m) => FFUploadedFile(
                  name: m.storagePath.split('/').last,
                  bytes: m.bytes,
                  height: m.dimensions?.height,
                  width: m.dimensions?.width,
                  blurHash: m.blurHash,
                ))
            .toList();
      } catch (e) {
        setState(() => _isUploadingAvatar = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error processing image: $e'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      if (selectedUploadedFiles.isNotEmpty) {
        try {
          // Save image to app directory
          final savedFile =
              await _saveImageToAppDir(media.storagePath, media.bytes);

          setState(() {
            _uploadedLocalFile = selectedUploadedFiles.first;
            _pickedImage = savedFile;
            _pickedImageBytes = media.bytes;
          });

          // Upload the image
          _avatarApiResult = await FreelancerAuthorizationGroup.avatarCall.call(
            avatar: _uploadedLocalFile,
            authToken: FFAppState().apitoken,
          );

          setState(() => _isUploadingAvatar = false);

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                getJsonField(
                        (_avatarApiResult?.jsonBody ?? ''), r'''$.message''')
                    .toString(),
                style: const TextStyle(color: Colors.white),
              ),
              backgroundColor: const Color(0xFF6E2A87),
            ),
          );

          if ((_avatarApiResult?.succeeded ?? false)) {
            setState(() {
              _isAvatar = true;
            });
            await _fetchProfileData();
          }
        } catch (e) {
          setState(() => _isUploadingAvatar = false);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Failed to save or upload image: $e'),
              backgroundColor: Colors.red,
            ),
          );
          setState(() {
            _pickedImage = null;
            _pickedImageBytes = null;
          });
        }
      } else {
        setState(() => _isUploadingAvatar = false);
      }
    } catch (e) {
      setState(() => _isUploadingAvatar = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error selecting image: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Widget _buildAvatarImage() {
    final profileData = _model.apiResultoen?.jsonBody;
    final avatarUrl =
        getJsonField(profileData ?? '', r'''$.data.avatar.url''')?.toString();

    if (_isUploadingAvatar) {
      return Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF6E2A87)),
        ),
      );
    }

    // Show picked image if available
    if (_pickedImageBytes != null) {
      return Image.memory(
        _pickedImageBytes!,
        width: 90,
        height: 90,
        fit: BoxFit.cover,
      );
    }

    if (_pickedImage != null) {
      return FutureBuilder<bool>(
        future: _pickedImage!.exists(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SizedBox();
          }
          if (snapshot.data == true) {
            return Image.file(
              _pickedImage!,
              width: 90,
              height: 90,
              fit: BoxFit.cover,
            );
          } else {
            // File doesn't exist, fall back to network image
            return _buildNetworkOrDefaultImage(avatarUrl);
          }
        },
      );
    }

    // Show network image or default
    return _buildNetworkOrDefaultImage(avatarUrl);
  }

  Widget _buildNetworkOrDefaultImage(String? avatarUrl) {
    if (avatarUrl != null && avatarUrl.isNotEmpty) {
      return Image.network(
        avatarUrl,
        width: 90,
        height: 90,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) =>
            const Icon(Icons.person, size: 60, color: Colors.grey),
      );
    } else {
      return const Icon(Icons.person, size: 60, color: Colors.grey);
    }
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    if (!_apiCalled) {
      _apiCalled = true;
      SchedulerBinding.instance.addPostFrameCallback((_) {
        _fetchProfileData();
      });
    }

    final profileData = _model.apiResultoen?.jsonBody;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: SafeArea(
          top: true,
          child: profileData == null
              ? Center(
                  child: CircularProgressIndicator(
                    valueColor:
                        AlwaysStoppedAnimation<Color>(Color(0xFF6E2A87)),
                  ),
                )
              : Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          FlutterFlowIconButton(
                            borderRadius: 8,
                            buttonSize: 36,
                            fillColor: Colors.white,
                            icon: const Icon(
                              Icons.arrow_back_ios_new,
                              color: Color(0xFF252525),
                              size: 18,
                            ),
                            onPressed: () {
                              _apiCalled = false;
                              context.safePop();
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 30),
                            child: Column(
                              children: [
                                Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Container(
                                      width: 90,
                                      height: 90,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.grey[200],
                                      ),
                                      child: ClipOval(
                                        child: _buildAvatarImage(),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 0,
                                      right: 0,
                                      child: InkWell(
                                        onTap: _isUploadingAvatar
                                            ? null
                                            : _pickAndUploadAvatar,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            shape: BoxShape.circle,
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.black26,
                                                  blurRadius: 4)
                                            ],
                                          ),
                                          padding: const EdgeInsets.all(8),
                                          child: Icon(Icons.edit,
                                              color: Color(0xFF6E2A87),
                                              size: 22),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 14),
                                  child: Text(
                                    valueOrDefault<String>(
                                      getJsonField(
                                        profileData ?? '',
                                        r'''$.data.name''',
                                      )?.toString(),
                                      'N/A',
                                    ),
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'primaryFont',
                                          color: const Color(0xFF252525),
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 36),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          _InfoRow(
                            iconPath: 'assets/images/marker-pin-04.png',
                            label: 'From',
                            value: getJsonField(
                              profileData ?? '',
                              r'''$.data.country''',
                            )?.toString(),
                          ),
                          Divider(
                            thickness: 2,
                            color: FlutterFlowTheme.of(context).alternate,
                          ),
                          _InfoRow(
                            iconPath: 'assets/images/user-02.png',
                            label: 'Member Since',
                            value: getJsonField(
                              profileData ?? '',
                              r'''$.data.created_at''',
                            )?.toString(),
                          ),
                          Divider(
                            thickness: 2,
                            color: FlutterFlowTheme.of(context).alternate,
                          ),
                          _InfoRow(
                            iconPath: 'assets/images/sticker-square.png',
                            label: 'Completed Orders',
                            value: getJsonField(
                              profileData ?? '',
                              r'''$.data.completed_jobs''',
                            )?.toString(),
                          ),
                        ].divide(const SizedBox(height: 10)),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String iconPath;
  final String label;
  final String? value;

  const _InfoRow({
    required this.iconPath,
    required this.label,
    this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.asset(
            iconPath,
            width: 24,
            height: 24,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: FlutterFlowTheme.of(context).bodyMedium.override(
                    fontFamily: 'primaryFont',
                    color: const Color(0xFF898989),
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 10),
            Text(
              valueOrDefault<String>(value, 'N/A'),
              style: FlutterFlowTheme.of(context).bodyMedium.override(
                    fontFamily: 'primaryFont',
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ],
        ),
      ],
    );
  }
}
