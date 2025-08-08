import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';

import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/flutter_flow/upload_data.dart';
import '/index.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'add_new_service_model.dart';
export 'add_new_service_model.dart';

class AddNewServiceWidget extends StatefulWidget {
  const AddNewServiceWidget({super.key});

  static String routeName = 'AddNewService';
  static String routePath = '/addNewService';

  @override
  State<AddNewServiceWidget> createState() => _AddNewServiceWidgetState();
}

class _AddNewServiceWidgetState extends State<AddNewServiceWidget> {
  late AddNewServiceModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AddNewServiceModel());

    _model.titleTextController ??= TextEditingController();
    _model.titleFocusNode ??= FocusNode();

    _model.descriptionTextController ??= TextEditingController();
    _model.descriptionFocusNode ??= FocusNode();
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return WillPopScope(
      onWillPop: () async {
        context.pushNamed(AllServiceWidget.routeName);
        return false;
      },
      child: GestureDetector(
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
              child: Container(
                height: double.infinity,
                child: Stack(
                  children: [
                    Padding(
                      padding:
                      EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 0.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FlutterFlowIconButton(
                            borderRadius: 8.0,
                            buttonSize: 36.0,
                            fillColor: Colors.white,
                            icon: Icon(
                              Icons.arrow_back_ios_new,
                              color: Color(0xFF252525),
                              size: 18.0,
                            ),
                            onPressed: () async {
                              context.pushNamed(AllServiceWidget.routeName);
                            },
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 8.0, 20.0, 0.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  FFLocalizations.of(context).getText(
                                    'oof6dd4m' /* Add New Service */,
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
                          Container(
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Form(
                      key: _model.formKey,
                      autovalidateMode: AutovalidateMode.disabled,
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            0.0, 60.0, 0.0, 20.0),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    20.0, 15.0, 0.0, 0.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8.0),
                                      child: Image.asset(
                                        'assets/images/edit-04.png',
                                        width: 20.0,
                                        height: 20.0,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          10.0, 0.0, 0.0, 0.0),
                                      child: Text(
                                        FFLocalizations.of(context).getText(
                                          'm86beweb' /* Service title */,
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                          fontFamily: 'primaryFont',
                                          fontSize: 12.0,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Align(
                                alignment: AlignmentDirectional(0.0, 0.0),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      20.0, 10.0, 20.0, 0.0),
                                  child: Container(
                                    width: double.infinity,
                                    child: TextFormField(
                                      controller: _model.titleTextController,
                                      focusNode: _model.titleFocusNode,
                                      autofocus: false,
                                      obscureText: false,
                                      decoration: InputDecoration(
                                        isDense: true,
                                        labelStyle: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .override(
                                          font: GoogleFonts.inter(
                                            fontWeight:
                                            FlutterFlowTheme.of(context)
                                                .labelMedium
                                                .fontWeight,
                                            fontStyle:
                                            FlutterFlowTheme.of(context)
                                                .labelMedium
                                                .fontStyle,
                                          ),
                                          letterSpacing: 0.0,
                                          fontWeight:
                                          FlutterFlowTheme.of(context)
                                              .labelMedium
                                              .fontWeight,
                                          fontStyle:
                                          FlutterFlowTheme.of(context)
                                              .labelMedium
                                              .fontStyle,
                                        ),
                                        hintText:
                                        FFLocalizations.of(context).getText(
                                          'fi30jo9b' /* Service title */,
                                        ),
                                        hintStyle: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .override(
                                          fontFamily: 'primaryFont',
                                          color: Color(0xFF64748B),
                                          fontSize: 16.0,
                                          letterSpacing: 0.0,
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(0x00000000),
                                            width: 1.0,
                                          ),
                                          borderRadius:
                                          BorderRadius.circular(8.0),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(0x00000000),
                                            width: 1.0,
                                          ),
                                          borderRadius:
                                          BorderRadius.circular(8.0),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: FlutterFlowTheme.of(context)
                                                .error,
                                            width: 1.0,
                                          ),
                                          borderRadius:
                                          BorderRadius.circular(8.0),
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: FlutterFlowTheme.of(context)
                                                .error,
                                            width: 1.0,
                                          ),
                                          borderRadius:
                                          BorderRadius.circular(8.0),
                                        ),
                                        filled: true,
                                        fillColor: FlutterFlowTheme.of(context)
                                            .secondaryBackground,
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                        font: GoogleFonts.inter(
                                          fontWeight:
                                          FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .fontWeight,
                                          fontStyle:
                                          FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .fontStyle,
                                        ),
                                        fontSize: 16.0,
                                        letterSpacing: 0.0,
                                        fontWeight:
                                        FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontWeight,
                                        fontStyle:
                                        FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                      ),
                                      cursorColor: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      validator: _model
                                          .titleTextControllerValidator
                                          .asValidator(context),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    20.0, 15.0, 0.0, 0.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(0.0),
                                        bottomRight: Radius.circular(0.0),
                                        topLeft: Radius.circular(0.0),
                                        topRight: Radius.circular(0.0),
                                      ),
                                      child: Image.asset(
                                        'assets/images/image-03_(1).png',
                                        width: 20.0,
                                        height: 20.0,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          10.0, 0.0, 0.0, 0.0),
                                      child: Text(
                                        FFLocalizations.of(context).getText(
                                          '36uritu5' /* Service gallery */,
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                          fontFamily: 'primaryFont',
                                          fontSize: 12.0,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    20.0, 10.0, 20.0, 0.0),
                                child: InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    final selectedMedia = await selectMedia(
                                      mediaSource: MediaSource.photoGallery,
                                      multiImage: true,
                                    );
                                    if (selectedMedia != null &&
                                        selectedMedia.every((m) =>
                                            validateFileFormat(
                                                m.storagePath, context))) {
                                      safeSetState(() =>
                                      _model.isDataUploading_uploadDataKyc =
                                      true);
                                      var selectedUploadedFiles =
                                      <FFUploadedFile>[];

                                      try {
                                        selectedUploadedFiles = selectedMedia
                                            .map((m) => FFUploadedFile(
                                          name: m.storagePath
                                              .split('/')
                                              .last,
                                          bytes: m.bytes,
                                          height: m.dimensions?.height,
                                          width: m.dimensions?.width,
                                          blurHash: m.blurHash,
                                        ))
                                            .toList();
                                      } finally {
                                        _model.isDataUploading_uploadDataKyc =
                                        false;
                                      }
                                      if (selectedUploadedFiles.length ==
                                          selectedMedia.length) {
                                        safeSetState(() {
                                          _model.uploadedLocalFiles_uploadDataKyc =
                                              selectedUploadedFiles;
                                        });
                                      } else {
                                        safeSetState(() {});
                                        return;
                                      }
                                    }
                                  },
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: Image.asset(
                                      'assets/images/Cover_(1).png',
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              if (_model
                                  .uploadedLocalFiles_uploadDataKyc.isNotEmpty)
                                Builder(
                                  builder: (context) {
                                    final imageList = _model
                                        .uploadedLocalFiles_uploadDataKyc
                                        .toList();

                                    return Wrap(
                                      spacing: 0.0,
                                      runSpacing: 0.0,
                                      alignment: WrapAlignment.start,
                                      crossAxisAlignment:
                                      WrapCrossAlignment.start,
                                      direction: Axis.horizontal,
                                      runAlignment: WrapAlignment.start,
                                      verticalDirection: VerticalDirection.down,
                                      clipBehavior: Clip.none,
                                      children: List.generate(imageList.length,
                                              (imageListIndex) {
                                            final imageListItem =
                                            imageList[imageListIndex];
                                            return Padding(
                                              padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  20.0, 20.0, 20.0, 0.0),
                                              child: ClipRRect(
                                                borderRadius:
                                                BorderRadius.circular(8.0),
                                                child: Image.memory(
                                                  imageListItem.bytes ??
                                                      Uint8List.fromList([]),
                                                  width: 80.0,
                                                  height: 80.0,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            );
                                          }),
                                    );
                                  },
                                ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    20.0, 15.0, 0.0, 0.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(0.0),
                                        bottomRight: Radius.circular(0.0),
                                        topLeft: Radius.circular(0.0),
                                        topRight: Radius.circular(0.0),
                                      ),
                                      child: Image.asset(
                                        'assets/images/paragraph-wrap_(1).png',
                                        width: 20.0,
                                        height: 20.0,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          10.0, 0.0, 0.0, 0.0),
                                      child: Text(
                                        FFLocalizations.of(context).getText(
                                          'wbuw8x1p' /* Service description */,
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                          fontFamily: 'primaryFont',
                                          fontSize: 12.0,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Align(
                                alignment: AlignmentDirectional(0.0, -1.0),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      20.0, 10.0, 20.0, 0.0),
                                  child: Container(
                                    width: double.infinity,
                                    child: TextFormField(
                                      controller:
                                      _model.descriptionTextController,
                                      focusNode: _model.descriptionFocusNode,
                                      autofocus: false,
                                      obscureText: false,
                                      decoration: InputDecoration(
                                        isDense: true,
                                        labelStyle: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .override(
                                          font: GoogleFonts.inter(
                                            fontWeight:
                                            FlutterFlowTheme.of(context)
                                                .labelMedium
                                                .fontWeight,
                                            fontStyle:
                                            FlutterFlowTheme.of(context)
                                                .labelMedium
                                                .fontStyle,
                                          ),
                                          letterSpacing: 0.0,
                                          fontWeight:
                                          FlutterFlowTheme.of(context)
                                              .labelMedium
                                              .fontWeight,
                                          fontStyle:
                                          FlutterFlowTheme.of(context)
                                              .labelMedium
                                              .fontStyle,
                                        ),
                                        hintText:
                                        FFLocalizations.of(context).getText(
                                          'dxtup6p7' /* About Service */,
                                        ),
                                        hintStyle: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .override(
                                          fontFamily: 'primaryFont',
                                          color: Color(0xFF64748B),
                                          fontSize: 16.0,
                                          letterSpacing: 0.0,
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(0x00000000),
                                            width: 1.0,
                                          ),
                                          borderRadius:
                                          BorderRadius.circular(8.0),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(0x00000000),
                                            width: 1.0,
                                          ),
                                          borderRadius:
                                          BorderRadius.circular(8.0),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: FlutterFlowTheme.of(context)
                                                .error,
                                            width: 1.0,
                                          ),
                                          borderRadius:
                                          BorderRadius.circular(8.0),
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: FlutterFlowTheme.of(context)
                                                .error,
                                            width: 1.0,
                                          ),
                                          borderRadius:
                                          BorderRadius.circular(8.0),
                                        ),
                                        filled: true,
                                        fillColor: FlutterFlowTheme.of(context)
                                            .secondaryBackground,
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                        font: GoogleFonts.inter(
                                          fontWeight:
                                          FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .fontWeight,
                                          fontStyle:
                                          FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .fontStyle,
                                        ),
                                        fontSize: 16.0,
                                        letterSpacing: 0.0,
                                        fontWeight:
                                        FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontWeight,
                                        fontStyle:
                                        FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                      ),
                                      maxLines: 4,
                                      cursorColor: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      validator: _model
                                          .descriptionTextControllerValidator
                                          .asValidator(context),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    20.0, 15.0, 0.0, 0.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(0.0),
                                        bottomRight: Radius.circular(0.0),
                                        topLeft: Radius.circular(0.0),
                                        topRight: Radius.circular(0.0),
                                      ),
                                      child: Image.asset(
                                        'assets/images/settings-04_(1).png',
                                        width: 20.0,
                                        height: 20.0,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          10.0, 0.0, 0.0, 0.0),
                                      child: Text(
                                        FFLocalizations.of(context).getText(
                                          'jg4w0qfi' /* Service category */,
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                          fontFamily: 'primaryFont',
                                          fontSize: 12.0,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    20.0, 10.0, 20.0, 0.0),
                                child: FutureBuilder<ApiCallResponse>(
                                  future: ClientHomePageGroup.categoryCall.call(
                                    authToken: FFAppState().apitoken,
                                  ),
                                  builder: (context, snapshot) {
                                    // Customize what your widget looks like when it's loading.
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
                                    final dropDownCategoryResponse =
                                    snapshot.data!;

                                    return FlutterFlowDropDown<String>(
                                      controller:
                                      _model.dropDownValueController1 ??=
                                          FormFieldController<String>(
                                            _model.dropDownValue1 ??= '',
                                          ),
                                      options: List<String>.from(
                                          ClientHomePageGroup.categoryCall
                                              .categoryList(
                                            dropDownCategoryResponse
                                                .jsonBody,
                                          )!
                                              .map((e) => getJsonField(
                                            e,
                                            r'''$.id''',
                                          ))
                                              .toList()
                                              .map((e) => e.toString())
                                              .toList()),
                                      optionLabels: ClientHomePageGroup
                                          .categoryCall
                                          .categoryList(
                                        dropDownCategoryResponse.jsonBody,
                                      )!
                                          .map((e) => getJsonField(
                                        e,
                                        r'''$.name''',
                                      ))
                                          .toList()
                                          .map((e) => e.toString())
                                          .toList(),
                                      onChanged: (val) async {
                                        safeSetState(
                                                () => _model.dropDownValue1 = val);
                                        safeSetState(() =>
                                        _model.apiRequestCompleter = null);
                                      },
                                      width: double.infinity,
                                      height: 56.0,
                                      textStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                        font: GoogleFonts.inter(
                                          fontWeight:
                                          FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .fontWeight,
                                          fontStyle:
                                          FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .fontStyle,
                                        ),
                                        color: Color(0xFF64748B),
                                        fontSize: 16.0,
                                        letterSpacing: 0.0,
                                        fontWeight:
                                        FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontWeight,
                                        fontStyle:
                                        FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                      ),
                                      hintText:
                                      FFLocalizations.of(context).getText(
                                        '0tuqrwcc' /* Select Category */,
                                      ),
                                      icon: Icon(
                                        Icons.keyboard_arrow_down_rounded,
                                        color: Color(0xFF898989),
                                        size: 24.0,
                                      ),
                                      fillColor: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                      elevation: 2.0,
                                      borderColor: Colors.transparent,
                                      borderWidth: 0.0,
                                      borderRadius: 8.0,
                                      margin: EdgeInsetsDirectional.fromSTEB(
                                          12.0, 0.0, 12.0, 0.0),
                                      hidesUnderline: true,
                                      isOverButton: false,
                                      isSearchable: false,
                                      isMultiSelect: false,
                                    );
                                  },
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    20.0, 10.0, 20.0, 0.0),
                                child: FutureBuilder<ApiCallResponse>(
                                  future: (_model.apiRequestCompleter ??=
                                  Completer<ApiCallResponse>()
                                    ..complete(ClientHomePageGroup
                                        .subCategoryCall
                                        .call(
                                      categoryId: _model.dropDownValue1,
                                      authToken: FFAppState().apitoken,
                                      paginate: '10',
                                      page: '1',
                                    )))
                                      .future,
                                  builder: (context, snapshot) {
                                    // Customize what your widget looks like when it's loading.
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
                                    final dropDownSubCategoryResponse =
                                    snapshot.data!;

                                    return FlutterFlowDropDown<String>(
                                      controller:
                                      _model.dropDownValueController2 ??=
                                          FormFieldController<String>(
                                            _model.dropDownValue2 ??= '',
                                          ),
                                      options: List<String>.from(
                                          ClientHomePageGroup.subCategoryCall
                                              .subCategoryList(
                                            dropDownSubCategoryResponse
                                                .jsonBody,
                                          )!
                                              .map((e) => getJsonField(
                                            e,
                                            r'''$.id''',
                                          ))
                                              .toList()
                                              .map((e) => e.toString())
                                              .toList()),
                                      optionLabels:
                                      ClientHomePageGroup.subCategoryCall
                                          .subCategoryList(
                                        dropDownSubCategoryResponse
                                            .jsonBody,
                                      )!
                                          .map((e) => getJsonField(
                                        e,
                                        r'''$.name''',
                                      ))
                                          .toList()
                                          .map((e) => e.toString())
                                          .toList(),
                                      onChanged: (val) => safeSetState(
                                              () => _model.dropDownValue2 = val),
                                      width: double.infinity,
                                      height: 56.0,
                                      textStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                        font: GoogleFonts.inter(
                                          fontWeight:
                                          FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .fontWeight,
                                          fontStyle:
                                          FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .fontStyle,
                                        ),
                                        color: Color(0xFF64748B),
                                        fontSize: 16.0,
                                        letterSpacing: 0.0,
                                        fontWeight:
                                        FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontWeight,
                                        fontStyle:
                                        FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                      ),
                                      hintText:
                                      FFLocalizations.of(context).getText(
                                        'rinid81g' /* Select  SubCategory */,
                                      ),
                                      icon: Icon(
                                        Icons.keyboard_arrow_down_rounded,
                                        color: Color(0xFF898989),
                                        size: 24.0,
                                      ),
                                      fillColor: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                      elevation: 2.0,
                                      borderColor: Colors.transparent,
                                      borderWidth: 0.0,
                                      borderRadius: 8.0,
                                      margin: EdgeInsetsDirectional.fromSTEB(
                                          12.0, 0.0, 12.0, 0.0),
                                      hidesUnderline: true,
                                      isOverButton: false,
                                      isSearchable: false,
                                      isMultiSelect: false,
                                    );
                                  },
                                ),
                              ),
                              Align(
                                alignment: AlignmentDirectional(0.0, 1.0),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      20.0, 20.0, 20.0, 0.0),
                                  child: Container(
                                    width: double.infinity,
                                    height: 56.0,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          Color(0xFF6E2A87),
                                          Color(0xFF16AFE6)
                                        ],
                                        stops: [0.0, 1.0],
                                        begin: AlignmentDirectional(1.0, 0.0),
                                        end: AlignmentDirectional(-1.0, 0),
                                      ),
                                      borderRadius: BorderRadius.circular(8.0),
                                      shape: BoxShape.rectangle,
                                    ),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 0.0, 0.0, 2.0),
                                      child: FFButtonWidget(
                                        onPressed: () async {
                                          if (_model.formKey.currentState ==
                                              null ||
                                              !_model.formKey.currentState!
                                                  .validate()) {
                                            return;
                                          }
                                          if (_model
                                              .uploadedLocalFiles_uploadDataKyc
                                              .any((file) =>
                                          (file.bytes?.isEmpty ??
                                              true))) {
                                            return;
                                          }
                                          if (_model.dropDownValue1 == null) {
                                            return;
                                          }
                                          if (_model
                                              .uploadedLocalFiles_uploadDataKyc
                                              .isNotEmpty) {
                                            _model.apiResultaro =
                                            await FreelancerHomePageGroup
                                                .addServicesCall
                                                .call(
                                              title: _model
                                                  .titleTextController.text,
                                              description: _model
                                                  .descriptionTextController
                                                  .text,
                                              galleryList: _model
                                                  .uploadedLocalFiles_uploadDataKyc,
                                              categoryId: _model.dropDownValue1,
                                              authToken: FFAppState().apitoken,
                                              categories: _model.dropDownValue2,
                                            );

                                            if ((_model
                                                .apiResultaro?.succeeded ??
                                                true)) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                    getJsonField(
                                                      (_model.apiResultaro
                                                          ?.jsonBody ??
                                                          ''),
                                                      r'''$.message''',
                                                    ).toString(),
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  duration: Duration(
                                                      milliseconds: 4000),
                                                  backgroundColor:
                                                  Color(0xFF6E2A87),
                                                ),
                                              );

                                              context.pushNamed(
                                                AddNewServiceNextPageWidget
                                                    .routeName,
                                                queryParameters: {
                                                  'serviceId': serializeParam(
                                                    getJsonField(
                                                      (_model.apiResultaro
                                                          ?.jsonBody ??
                                                          ''),
                                                      r'''$.data.id''',
                                                    ).toString(),
                                                    ParamType.String,
                                                  ),
                                                }.withoutNulls,
                                              );
                                            } else {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                    getJsonField(
                                                      (_model.apiResultaro
                                                          ?.jsonBody ??
                                                          ''),
                                                      r'''$.message''',
                                                    ).toString(),
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  duration: Duration(
                                                      milliseconds: 4000),
                                                  backgroundColor:
                                                  Color(0xFF6E2A87),
                                                ),
                                              );
                                            }
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                  'Please select a file',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                duration: Duration(
                                                    milliseconds: 4000),
                                                backgroundColor:
                                                Color(0xFF6E2A87),
                                              ),
                                            );
                                          }

                                          safeSetState(() {});
                                        },
                                        text:
                                        FFLocalizations.of(context).getText(
                                          '87bhnelc' /* Add Service */,
                                        ),
                                        options: FFButtonOptions(
                                          height: 40.0,
                                          padding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              16.0, 0.0, 16.0, 0.0),
                                          iconPadding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              0.0, 0.0, 0.0, 0.0),
                                          color: Color(0x004B39EF),
                                          textStyle: FlutterFlowTheme.of(
                                              context)
                                              .titleSmall
                                              .override(
                                            font: GoogleFonts.interTight(
                                              fontWeight:
                                              FlutterFlowTheme.of(
                                                  context)
                                                  .titleSmall
                                                  .fontWeight,
                                              fontStyle:
                                              FlutterFlowTheme.of(
                                                  context)
                                                  .titleSmall
                                                  .fontStyle,
                                            ),
                                            color: Colors.white,
                                            letterSpacing: 0.0,
                                            fontWeight:
                                            FlutterFlowTheme.of(context)
                                                .titleSmall
                                                .fontWeight,
                                            fontStyle:
                                            FlutterFlowTheme.of(context)
                                                .titleSmall
                                                .fontStyle,
                                          ),
                                          elevation: 0.0,
                                          borderRadius:
                                          BorderRadius.circular(8.0),
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
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
