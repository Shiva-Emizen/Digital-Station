import 'dart:io';
import 'dart:typed_data';
import 'package:digital_station/freelancer/portfolio_page/portfolio_page_widget.dart';
import 'package:ff_commons/api_requests/api_manager.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import '../../app_state.dart';
import '../../backend/api_requests/api_calls.dart';
import '../../flutter_flow/flutter_flow_util.dart';
import '../../flutter_flow/upload_data.dart';
import 'package:path/path.dart' as p;


class EditPortfolioPageWidget extends StatefulWidget {
  final String initialTitle;
  final List<String> galleryUrls;
  final String portfolioId;

  const EditPortfolioPageWidget({
    super.key,
    required this.initialTitle,
    required this.galleryUrls,
    required this.portfolioId,
  });

  @override
  State<EditPortfolioPageWidget> createState() =>
      _EditPortfolioPageWidgetState();
}

class _EditPortfolioPageWidgetState extends State<EditPortfolioPageWidget> {
  late TextEditingController _titleController;
  bool _isUpdating = false;
  ApiCallResponse? apiResultbgr;

  // Store both existing URLs and newly added files
  late List<String> _existingGalleryUrls;
  List<FFUploadedFile> _newFiles = [];

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.initialTitle);
    _existingGalleryUrls = List<String>.from(widget.galleryUrls);
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  Future<void> _pickFiles() async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: [
        'jpg', 'jpeg', 'png', 'gif', 'mp4', 'mov', 'avi', 'pdf', 'doc', 'docx', 'csv', 'zip'
      ],
      withData: true,
    );
    if (result != null) {
      final newFiles = <FFUploadedFile>[];
      for (var file in result.files) {
        final ext = file.extension?.toLowerCase() ?? '';
        Uint8List? bytes = file.bytes;
        if (bytes == null && file.path != null) {
          bytes = await File(file.path!).readAsBytes();
        }
        newFiles.add(FFUploadedFile(
          name: file.name,
          bytes: bytes,
        ));
      }
      setState(() {
        _newFiles.addAll(newFiles);
      });
    }
  }
  Future<void> _updatePortfolio() async {
    final title = _titleController.text.trim();

    if (title.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content:
          Text('Please enter title', style: TextStyle(color: Colors.white)),
          duration: Duration(milliseconds: 3000),
          backgroundColor: Color(0xFF6E2A87),
        ),
      );
      return;
    }

    setState(() {
      _isUpdating = true;
    });
    final List<FFUploadedFile> allAttachments = [
      ..._existingGalleryUrls.map((url) => FFUploadedFile(name: url.split('/').last)),
      ..._newFiles,
    ];
    try {
      // Pass both existing URLs and new files to the API
      print('Request: id=${widget.portfolioId}, title=$title, attachments=${allAttachments.length}, authToken=${FFAppState().apitoken}');
      apiResultbgr = await FreelancerHomePageGroup.updatePortfolioCall.call(
        id: widget.portfolioId,
        title: title,
        attachments: allAttachments,
        authToken: FFAppState().apitoken,
      );
      print('Response: ${apiResultbgr?.jsonBody}');
      print('Response: ${apiResultbgr?.statusCode}');
      print('Response: ${allAttachments}');

      final responseMessage = getJsonField(
        (apiResultbgr?.jsonBody ?? ''),
        r'''$.message''',
      ).toString();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(responseMessage,
              style: const TextStyle(color: Colors.white)),
          duration: const Duration(milliseconds: 4000),
          backgroundColor: const Color(0xFF6E2A87),
        ),
      );

      if ((apiResultbgr?.succeeded ?? false)) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const PortfolioPageWidget(),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Update failed. Try again.',
              style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.redAccent,
        ),
      );
    } finally {
      setState(() {
        _isUpdating = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Portfolio',
            style: FlutterFlowTheme.of(context).titleLarge),
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        iconTheme: const IconThemeData(color: Color(0xFF252525)),
        centerTitle: true,
        actions: [],
      ),
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Title',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0)),
              ),
              style: FlutterFlowTheme.of(context).bodyMedium,
            ),
            const SizedBox(height: 20),
            // Add New Gallery Button
            GestureDetector(
              onTap: _pickFiles,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16.0),
                    child: Image.asset(
                      'assets/images/Rectangle_188.png',
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 36.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          'assets/images/Icon_(Stroke)_(16).png',
                          width: 22.0,
                          height: 22.0,
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(height: 15.0),
                        Text(
                          'Add New Gallery',
                          style: FlutterFlowTheme.of(context)
                              .bodyMedium
                              .override(
                            fontFamily: 'primaryFont',
                            color: const Color(0xFF898989),
                            letterSpacing: 0.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Gallery Grid
            Expanded(
              child: GridView.builder(
                itemCount: _existingGalleryUrls.length + _newFiles.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 1.4,
                ),
                itemBuilder: (context, index) {
                  bool isExisting = index < _existingGalleryUrls.length;
                  Widget imageWidget;
                  final ext = isExisting
                      ? p.extension(_existingGalleryUrls[index]).replaceFirst('.', '').toLowerCase()
                      : p.extension(_newFiles[index - _existingGalleryUrls.length].name ?? '').replaceFirst('.', '').toLowerCase();
                  if (['jpg', 'jpeg', 'png', 'gif'].contains(ext)) {
                    imageWidget = isExisting
                        ? Image.network(_existingGalleryUrls[index], fit: BoxFit.cover, errorBuilder: (context, error, stackTrace) => const Icon(Icons.broken_image, size: 100))
                        : Image.memory(_newFiles[index - _existingGalleryUrls.length].bytes ?? Uint8List.fromList([]), fit: BoxFit.cover);
                  } else if (['mp4', 'mov', 'avi'].contains(ext)) {
                    imageWidget = const Icon(Icons.videocam, size: 60, color: Colors.deepPurple);
                  } else if (ext == 'pdf') {
                    imageWidget = const Icon(Icons.picture_as_pdf, size: 60, color: Colors.red);
                  } else if (ext == 'doc' || ext == 'docx') {
                    imageWidget = const Icon(Icons.description, size: 60, color: Colors.blue);
                  } else if (ext == 'csv') {
                    imageWidget = const Icon(Icons.table_chart, size: 60, color: Colors.green);
                  } else if (ext == 'zip') {
                    imageWidget = const Icon(Icons.archive, size: 60, color: Colors.orange);
                  } else {
                    imageWidget = const Icon(Icons.insert_drive_file, size: 60, color: Colors.grey);
                  }
                  return Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: SizedBox.expand(child: imageWidget),
                      ),
                      // Cross button for removal
                      Positioned(
                        top: 8,
                        right: 8,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              if (isExisting) {
                                _existingGalleryUrls.removeAt(index);
                              } else {
                                _newFiles.removeAt(index - _existingGalleryUrls.length);
                              }
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.8),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.close,
                              size: 18,
                              color: Colors.redAccent,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isUpdating ? null : _updatePortfolio,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6E2A87),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  disabledBackgroundColor: const Color(0xFF6E2A87),
                ),
                child: _isUpdating
                    ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
                )
                    : Text(
                  'Update',
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                    fontFamily: 'primaryFont',
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}