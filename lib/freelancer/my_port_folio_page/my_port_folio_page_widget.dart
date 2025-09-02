import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/upload_data.dart';
import '/index.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'my_port_folio_page_model.dart';
export 'my_port_folio_page_model.dart';

import 'dart:typed_data';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart' as p;

class MyPortFolioPageWidget extends StatefulWidget {
  const MyPortFolioPageWidget({super.key});

  static String routeName = 'MyPortFolioPage';
  static String routePath = '/myPortFolioPage';

  @override
  State<MyPortFolioPageWidget> createState() => _MyPortFolioPageWidgetState();
}

class _MyPortFolioPageWidgetState extends State<MyPortFolioPageWidget> {
  late MyPortFolioPageModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  List<FFUploadedFile> _uploadedFiles = [];

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MyPortFolioPageModel());
    _model.nameTextController ??= TextEditingController();
    _model.nameFocusNode ??= FocusNode();
  }

  @override
  void dispose() {
    _model.dispose();
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
        _uploadedFiles.addAll(newFiles);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: SafeArea(
          top: true,
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 0.0),
            child: Stack(
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 0.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Align(
                        alignment: AlignmentDirectional(0.0, -1.0),
                        child: FlutterFlowIconButton(
                          borderRadius: 8.0,
                          buttonSize: 36.0,
                          fillColor: Colors.white,
                          icon: Icon(
                            Icons.arrow_back_ios_new,
                            color: Color(0xFF252525),
                            size: 18.0,
                          ),
                          onPressed: () async {
                            context.pop();
                          },
                        ),
                      ),
                      Align(
                        alignment: AlignmentDirectional(0.0, -1.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              FFLocalizations.of(context).getText(
                                'n8hjgwn0' /* My Portfolio */,
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                fontFamily: 'primaryFont',
                                color: Color(0xFF252525),
                                fontSize: 16.0,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Align(
                        alignment: AlignmentDirectional(0.0, -1.0),
                        child: GestureDetector(
                          onTap: _model.isSavingPortfolio
                              ? null
                              : () async {
                            if (_model.formKey.currentState == null ||
                                !_model.formKey.currentState!
                                    .validate()) {
                              return;
                            }

                            if (_uploadedFiles.any((file) =>
                            (file.bytes?.isEmpty ?? true))) {
                              return;
                            }

                            if (_uploadedFiles.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Please upload files',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  duration: Duration(milliseconds: 4000),
                                  backgroundColor: Color(0xFF6E2A87),
                                ),
                              );
                              return;
                            }

                            setState(
                                    () => _model.isSavingPortfolio = true);

                            try {
                              _model.apiResultks3 =
                              await FreelancerHomePageGroup
                                  .addPortfolioCall
                                  .call(
                                title: _model.nameTextController.text,
                                galleryList: _uploadedFiles,
                                authToken: FFAppState().apitoken,
                              );

                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    getJsonField(
                                      (_model.apiResultks3?.jsonBody ??
                                          ''),
                                      r'''$.message''',
                                    ).toString(),
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  duration: Duration(milliseconds: 4000),
                                  backgroundColor: Color(0xFF6E2A87),
                                ),
                              );

                              if ((_model.apiResultks3?.succeeded ??
                                  true)) {
                                context.pushNamed(
                                    PortfolioPageWidget.routeName);
                              }
                            } finally {
                              setState(
                                      () => _model.isSavingPortfolio = false);
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 24, vertical: 12),
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: Colors.transparent,
                                width: 1.0,
                              ),
                            ),
                            child: _model.isSavingPortfolio
                                ? SizedBox(
                              width: 18,
                              height: 18,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.black),
                              ),
                            )
                                : Text(
                              FFLocalizations.of(context)
                                  .getText('4d3c2aow' /* Save */),
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                fontFamily: 'primaryFont',
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                letterSpacing: 0.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Form(
                  key: _model.formKey,
                  autovalidateMode: AutovalidateMode.disabled,
                  child: Padding(
                    padding:
                    EdgeInsetsDirectional.fromSTEB(0.0, 12.0, 0.0, 0.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              20.0, 40.0, 20.0, 0.0),
                          child: TextFormField(
                            controller: _model.nameTextController,
                            focusNode: _model.nameFocusNode,
                            autofocus: false,
                            obscureText: false,
                            decoration: InputDecoration(
                              isDense: true,
                              labelStyle: FlutterFlowTheme.of(context)
                                  .labelMedium
                                  .override(
                                font: GoogleFonts.inter(
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .fontStyle,
                                ),
                                letterSpacing: 0.0,
                                fontWeight: FlutterFlowTheme.of(context)
                                    .labelMedium
                                    .fontWeight,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .labelMedium
                                    .fontStyle,
                              ),
                              hintText: FFLocalizations.of(context).getText(
                                '3psjtp6b' /* Enter Title */,
                              ),
                              hintStyle: FlutterFlowTheme.of(context)
                                  .labelMedium
                                  .override(
                                font: GoogleFonts.inter(
                                  fontWeight: FontWeight.normal,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .fontStyle,
                                ),
                                fontSize: 16.0,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.normal,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .labelMedium
                                    .fontStyle,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xFFE2E8F0),
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0x00000000),
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: FlutterFlowTheme.of(context).error,
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: FlutterFlowTheme.of(context).error,
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding: EdgeInsetsDirectional.fromSTEB(
                                  16.0, 20.0, 16.0, 20.0),
                            ),
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                              font: GoogleFonts.inter(
                                fontWeight: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .fontWeight,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .fontStyle,
                              ),
                              letterSpacing: 0.0,
                              fontWeight: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .fontWeight,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .fontStyle,
                            ),
                            textAlign: TextAlign.start,
                            cursorColor:
                            FlutterFlowTheme.of(context).primaryText,
                            validator: _model.nameTextControllerValidator
                                .asValidator(context),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              20.0, 10.0, 20.0, 0.0),
                          child: GestureDetector(
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
                                        FFLocalizations.of(context).getText(
                                            'ig23abo7' /* Add New Gallery */),
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
                        ),
                      ].divide(SizedBox(height: 8.0)),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 260.0, 0.0, 0.0),
                  child: SingleChildScrollView(
                    primary: false,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              20.0, 0.0, 20.0, 0.0),
                          child: GridView.builder(
                            padding: EdgeInsets.fromLTRB(
                              0,
                              10.0,
                              0,
                              10.0,
                            ),
                            gridDelegate:
                            SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 20.0,
                              mainAxisSpacing: 20.0,
                              childAspectRatio: 1.4,
                            ),
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: _uploadedFiles.length,
                            itemBuilder: (context, index) {
                              final file = _uploadedFiles[index];
                              final ext = p.extension(file.name ?? '').replaceFirst('.', '').toLowerCase();
                              Widget preview;
                              if (['jpg', 'jpeg', 'png', 'gif'].contains(ext)) {
                                preview = Image.memory(file.bytes ?? Uint8List.fromList([]), fit: BoxFit.cover);
                              } else if (['mp4', 'mov', 'avi'].contains(ext)) {
                                preview = Icon(Icons.videocam, size: 60, color: Colors.deepPurple);
                              } else if (ext == 'pdf') {
                                preview = Icon(Icons.picture_as_pdf, size: 60, color: Colors.red);
                              } else if (ext == 'doc' || ext == 'docx') {
                                preview = Icon(Icons.description, size: 60, color: Colors.blue);
                              } else if (ext == 'csv') {
                                preview = Icon(Icons.table_chart, size: 60, color: Colors.green);
                              } else if (ext == 'zip') {
                                preview = Icon(Icons.archive, size: 60, color: Colors.orange);
                              } else {
                                preview = Icon(Icons.insert_drive_file, size: 60, color: Colors.grey);
                              }
                              return Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: SizedBox.expand(child: preview),
                                  ),
                                  InkWell(
                                    onTap: () async {
                                      setState(() {
                                        _uploadedFiles.removeAt(index);
                                      });
                                    },
                                    child: Align(
                                      alignment: AlignmentDirectional(1.0, -1.0),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 13.0, 13.0, 0.0),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(8.0),
                                          child: Image.asset(
                                            'assets/images/Group_1597881529.png',
                                            width: 27.0,
                                            height: 27.0,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}