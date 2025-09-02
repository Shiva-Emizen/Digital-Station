import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/upload_data.dart';
import '/index.dart';
import 'package:paypal_integration_marketplace_library_9mtra1/custom_code/actions/index.dart'
as paypal_integration_marketplace_library_9mtra1_actions;
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'create_order_model.dart';
export 'create_order_model.dart';

import 'dart:typed_data';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:path/path.dart' as p;

class CreateOrderWidget extends StatefulWidget {
  const CreateOrderWidget({
    super.key,
    this.serviceId,
    this.packageId,
    this.price,
  });

  final String? serviceId;
  final String? packageId;
  final String? price;

  static String routeName = 'CreateOrder';
  static String routePath = '/createOrder';

  @override
  State<CreateOrderWidget> createState() => _CreateOrderWidgetState();
}

class _CreateOrderWidgetState extends State<CreateOrderWidget> {
  late CreateOrderModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  List<PlatformFile> _selectedFiles = [];
  List<Uint8List?> _videoThumbnails = [];

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CreateOrderModel());
    _model.textController ??= TextEditingController();
    _model.textFieldFocusNode ??= FocusNode();
    _model.switchValue = false;
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
      final newFiles = <PlatformFile>[];
      for (var file in result.files) {
        final ext = file.extension?.toLowerCase() ?? '';
        if (['jpg', 'jpeg', 'png', 'gif'].contains(ext) && file.bytes == null && file.path != null) {
          // Create a new PlatformFile with bytes loaded from disk
          final bytes = await File(file.path!).readAsBytes();
          newFiles.add(PlatformFile(
            name: file.name,
            size: file.size,
            path: file.path,
            bytes: bytes,
          ));
        } else {
          newFiles.add(file);
        }
      }

      // Avoid duplicates
      final uniqueFiles = newFiles.where((f) =>
      !_selectedFiles.any((e) => e.path == f.path && e.name == f.name)
      ).toList();

      _selectedFiles.addAll(uniqueFiles);

      final newThumbnails = await Future.wait(uniqueFiles.map((file) async {
        if (file.extension != null && ['mp4', 'mov', 'avi'].contains(file.extension!.toLowerCase()) && file.path != null) {
          return await VideoThumbnail.thumbnailData(
            video: file.path!,
            imageFormat: ImageFormat.PNG,
            maxWidth: 80,
            quality: 50,
          );
        }
        return null;
      }));

      _videoThumbnails.addAll(newThumbnails);
      setState(() {});
    }
  }

  void _removeFile(int index) {
    _selectedFiles.removeAt(index);
    _videoThumbnails.removeAt(index);
    setState(() {});
  }

  Widget _buildFilePreview(int index) {
    final file = _selectedFiles[index];
    final ext = file.extension?.toLowerCase() ?? '';
    if (['jpg', 'jpeg', 'png', 'gif'].contains(ext)) {
      return Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: file.bytes != null
                ? Image.memory(file.bytes!, width: 80, height: 80, fit: BoxFit.cover)
                : Container(width: 80, height: 80, color: Colors.grey[300], child: Icon(Icons.image)),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: InkWell(
              onTap: () => _removeFile(index),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black54,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.close, color: Colors.white, size: 20),
              ),
            ),
          ),
        ],
      );
    } else if (['mp4', 'mov', 'avi'].contains(ext)) {
      return Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: _videoThumbnails[index] != null
                ? Image.memory(_videoThumbnails[index]!, width: 80, height: 80, fit: BoxFit.cover)
                : Container(width: 80, height: 80, color: Colors.grey[300], child: Icon(Icons.videocam)),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: InkWell(
              onTap: () => _removeFile(index),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black54,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.close, color: Colors.white, size: 20),
              ),
            ),
          ),
        ],
      );
    } else {
      IconData icon;
      if (ext == 'pdf') icon = Icons.picture_as_pdf;
      else if (ext == 'doc' || ext == 'docx') icon = Icons.description;
      else if (ext == 'csv') icon = Icons.table_chart;
      else if (ext == 'zip') icon = Icons.archive;
      else icon = Icons.insert_drive_file;
      return Stack(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, size: 32, color: Colors.deepPurple),
                SizedBox(height: 4),
                Text(
                  p.basename(file.name),
                  style: TextStyle(fontSize: 10),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: InkWell(
              onTap: () => _removeFile(index),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black54,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.close, color: Colors.white, size: 20),
              ),
            ),
          ),
        ],
      );
    }
  }

  List<FFUploadedFile> get _ffUploadedFiles {
    return _selectedFiles.map((file) {
      return FFUploadedFile(
        name: file.name,
        bytes: file.bytes ??
            (file.path != null ? File(file.path!).readAsBytesSync() : null),
      );
    }).toList();
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
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
          child: Stack(
            children: [
              Form(
                key: _model.formKey,
                autovalidateMode: AutovalidateMode.disabled,
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 20.0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(20.0, 36.0, 20.0, 0.0),
                          child: Text(
                            FFLocalizations.of(context).getText('yf2rwd6p' /* Add description */),
                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'primaryFont',
                              fontSize: 12.0,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(20.0, 10.0, 20.0, 0.0),
                          child: TextFormField(
                            controller: _model.textController,
                            focusNode: _model.textFieldFocusNode,
                            autofocus: false,
                            obscureText: false,
                            decoration: InputDecoration(
                              isDense: true,
                              labelStyle: FlutterFlowTheme.of(context).labelMedium.override(
                                font: GoogleFonts.inter(
                                  fontWeight: FlutterFlowTheme.of(context).labelMedium.fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context).labelMedium.fontStyle,
                                ),
                                letterSpacing: 0.0,
                                fontWeight: FlutterFlowTheme.of(context).labelMedium.fontWeight,
                                fontStyle: FlutterFlowTheme.of(context).labelMedium.fontStyle,
                              ),
                              hintStyle: FlutterFlowTheme.of(context).labelMedium.override(
                                font: GoogleFonts.inter(
                                  fontWeight: FlutterFlowTheme.of(context).labelMedium.fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context).labelMedium.fontStyle,
                                ),
                                letterSpacing: 0.0,
                                fontWeight: FlutterFlowTheme.of(context).labelMedium.fontWeight,
                                fontStyle: FlutterFlowTheme.of(context).labelMedium.fontStyle,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0x00000000),
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
                              fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                            ),
                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                              font: GoogleFonts.inter(
                                fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                              ),
                              letterSpacing: 0.0,
                              fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                            ),
                            maxLines: 4,
                            cursorColor: FlutterFlowTheme.of(context).primaryText,
                            validator: _model.textControllerValidator.asValidator(context),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(20.0, 14.0, 20.0, 0.0),
                          child: Text(
                            FFLocalizations.of(context).getText('515lewtl' /* Attach Files */),
                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'primaryFont',
                              fontSize: 12.0,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(20.0, 5.0, 20.0, 0.0),
                          child: Text(
                            FFLocalizations.of(context).getText('bjis3h3t' /* Select zip,image,pdf or ms.wor... */),
                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'primaryFont',
                              color: Color(0xFF898989),
                              fontSize: 12.0,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(20.0, 10.0, 20.0, 0.0),
                          child: InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: _pickFiles,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.asset(
                                'assets/images/Group_1597881448.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        if (_selectedFiles.isNotEmpty)
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(20.0, 10.0, 20.0, 0.0),
                            child: Wrap(
                              spacing: 10,
                              runSpacing: 10,
                              children: List.generate(_selectedFiles.length, (index) => _buildFilePreview(index)),
                            ),
                          ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(20.0, 12.0, 0.0, 0.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(8.0),
                                        child: Image.asset(
                                          'assets/images/zap-fast.png',
                                          width: 20.0,
                                          height: 20.0,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Align(
                                        alignment: AlignmentDirectional(0.0, -1.0),
                                        child: Padding(
                                          padding: EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 20.0, 0.0),
                                          child: Text(
                                            FFLocalizations.of(context).getText('f5yj3pex' /* Express Delivery */),
                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                              fontFamily: 'primaryFont',
                                              fontSize: 12.0,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(20.0, 5.0, 0.0, 0.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Text(
                                        FFLocalizations.of(context).getText('e076xs5m' /* This Option Will add Extra  */),
                                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                                          fontFamily: 'primaryFont',
                                          color: Color(0xFF898989),
                                          fontSize: 12.0,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                      Text(
                                        FFLocalizations.of(context).getText('d3dq8wss' /*   */),
                                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                                          fontFamily: 'primaryFont',
                                          color: Color(0xFF898989),
                                          fontSize: 12.0,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Switch.adaptive(
                              value: _model.switchValue!,
                              onChanged: (newValue) async {
                                safeSetState(() => _model.switchValue = newValue);
                                if (newValue) {
                                  _model.extraPay = true;
                                  safeSetState(() {});
                                } else {
                                  _model.extraPay = false;
                                  safeSetState(() {});
                                }
                              },
                              activeColor: Color(0xFF53B175),
                              activeTrackColor: Colors.white,
                              inactiveTrackColor: Colors.white,
                              inactiveThumbColor: Color(0xFF53B175),
                            ),
                          ],
                        ),
                        Align(
                          alignment: AlignmentDirectional(0.0, -1.0),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(20.0, 200.0, 20.0, 0.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Container(
                                    width: double.infinity,
                                    height: 56.0,
                                    decoration: BoxDecoration(
                                      color: Color(0xFFE7E7E7),
                                      borderRadius: BorderRadius.circular(8.0),
                                      shape: BoxShape.rectangle,
                                    ),
                                    child: FFButtonWidget(
                                      onPressed: () async {
                                        context.safePop();
                                      },
                                      text: FFLocalizations.of(context).getText('5oc4qkeu' /* Cancel */),
                                      options: FFButtonOptions(
                                        height: 40.0,
                                        padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                                        iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                                        color: Color(0x004B39EF),
                                        textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                          font: GoogleFonts.interTight(
                                            fontWeight: FlutterFlowTheme.of(context).titleSmall.fontWeight,
                                            fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                          ),
                                          color: Color(0xFF6E2A87),
                                          letterSpacing: 0.0,
                                          fontWeight: FlutterFlowTheme.of(context).titleSmall.fontWeight,
                                          fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                        ),
                                        elevation: 0.0,
                                        borderRadius: BorderRadius.circular(8.0),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    width: double.infinity,
                                    height: 56.0,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [Color(0xFF6E2A87), Color(0xFF16AFE6)],
                                        stops: [0.0, 1.0],
                                        begin: AlignmentDirectional(1.0, 0.0),
                                        end: AlignmentDirectional(-1.0, 0),
                                      ),
                                      borderRadius: BorderRadius.circular(8.0),
                                      shape: BoxShape.rectangle,
                                    ),
                                    child: FFButtonWidget(

                                      onPressed: () async {
                                        if (_model.formKey.currentState == null || !_model.formKey.currentState!.validate()) {
                                          return;
                                        }
                                        _model.orderCreatedResponse = await ClientHomePageGroup.createOrderCall.call(
                                          serviceId: widget.serviceId,
                                          packageId: widget.packageId,
                                          description: _model.textController.text,
                                          attachments: _ffUploadedFiles, // <-- fixed here
                                          expressDelivery: _model.extraPay == true ? '1' : '0',
                                          authToken: FFAppState().apitoken,
                                        );
                                        if ((_model.orderCreatedResponse?.succeeded ?? true)) {
                                          String? totalStr = getJsonField(
                                            (_model.orderCreatedResponse?.jsonBody ?? ''),
                                            r'''$.data.total''',
                                          )?.toString();
                                          double total = double.tryParse(totalStr ?? '0') ?? 0.0;
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                getJsonField(
                                                  (_model.orderCreatedResponse?.jsonBody ?? ''),
                                                  r'''$.message''',
                                                ).toString(),
                                                style: TextStyle(
                                                  color: FlutterFlowTheme.of(context).primaryText,
                                                ),
                                              ),
                                              duration: Duration(milliseconds: 4000),
                                              backgroundColor: FlutterFlowTheme.of(context).secondary,
                                            ),
                                          );
                                          await paypal_integration_marketplace_library_9mtra1_actions.paypalPay(
                                            context,
                                            'AQzOQFUCXTbmGocpHXvBm8ZsZxR-ODRn9bSrCdQsKs9fgzOJe07-eYsPUKN7BmWCw8Vt3izzvG6BmJIx',
                                            'EPSYJsR227guAVsnR3HZDE-CKI0WaecqRYfuvwXNP5YOf1yUVAtzTlgeqZS4d9rwGErZQog6fA1eHtnB',
                                            total,
                                            'USD',
                                            _model.textController.text,
                                            'paypal',
                                            _model.amountDetails,
                                            _model.productList.toList(),
                                            _model.amountDetails,
                                            true,
                                                (data) async {
                                              context.pushNamed(HomePageWidget.routeName);
                                            },
                                                (params) async {},
                                                (message) async {
                                              ScaffoldMessenger.of(context).showSnackBar(
                                                SnackBar(
                                                  content: Text('PayPal Error: $message'),
                                                  backgroundColor: Colors.red,
                                                  duration: Duration(seconds: 5),
                                                ),
                                              );
                                            },
                                          );
                                        } else {
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                getJsonField(
                                                  (_model.orderCreatedResponse?.jsonBody ?? ''),
                                                  r'''$.message''',
                                                ).toString(),
                                                style: TextStyle(
                                                  color: FlutterFlowTheme.of(context).primaryText,
                                                ),
                                              ),
                                              duration: Duration(milliseconds: 4000),
                                              backgroundColor: FlutterFlowTheme.of(context).secondary,
                                            ),
                                          );
                                        }
                                        safeSetState(() {});
                                      },
                                      text: FFLocalizations.of(context).getText('tfdg6m2u' /* Confirm */),
                                      options: FFButtonOptions(
                                        height: 40.0,
                                        padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                                        iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                                        color: Color(0x004B39EF),
                                        textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                          font: GoogleFonts.interTight(
                                            fontWeight: FlutterFlowTheme.of(context).titleSmall.fontWeight,
                                            fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                          ),
                                          color: Colors.white,
                                          letterSpacing: 0.0,
                                          fontWeight: FlutterFlowTheme.of(context).titleSmall.fontWeight,
                                          fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                        ),
                                        elevation: 0.0,
                                        borderRadius: BorderRadius.circular(8.0),
                                      ),
                                    ),
                                  ),
                                ),
                              ].divide(SizedBox(width: 20.0)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 0.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                          context.safePop();
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 20.0, 0.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            FFLocalizations.of(context).getText('mr3cqan3' /* Order */),
                            style: FlutterFlowTheme.of(context).bodyMedium.override(
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
                      child: Container(
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).secondaryBackground,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}