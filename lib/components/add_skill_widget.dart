import 'package:provider/provider.dart';

import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'add_skill_model.dart';
export 'add_skill_model.dart';

class AddSkillWidget extends StatefulWidget {
  final Map<String, dynamic>? initialSkill;
  const AddSkillWidget({super.key, this.initialSkill});

  @override
  State<AddSkillWidget> createState() => _AddSkillWidgetState();
}

class _AddSkillWidgetState extends State<AddSkillWidget> {
  late AddSkillModel _model;
  String? selectedExperienceName;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AddSkillModel());
    _model.emailTextController ??= TextEditingController(
      text: widget.initialSkill?['title'] ?? '',
    );
    _model.emailFocusNode ??= FocusNode();
    // Do NOT set dropdown value/controller here!
    selectedExperienceName = widget.initialSkill?['experience_name'];
  }

  @override
  void dispose() {
    _model.maybeDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Align(
      alignment: AlignmentDirectional(0.0, 0.0),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 10.0, 0.0),
        child: Container(
          width: double.infinity,
          height: MediaQuery.sizeOf(context).height * 0.4,
          constraints: BoxConstraints(maxWidth: 700.0),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                blurRadius: 12.0,
                color: Color(0x33000000),
                offset: Offset(0.0, 5.0),
              )
            ],
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 12.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Text(
                          widget.initialSkill == null
                              ? FFLocalizations.of(context).getText('nza6d2c9' /* Add Skill */)
                              : 'Edit Skill',
                          style: FlutterFlowTheme.of(context)
                              .headlineSmall
                              .override(
                            fontFamily: 'primaryFont',
                            color: Color(0xFF252525),
                            fontSize: 16.0,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      FlutterFlowIconButton(
                        borderColor: Colors.transparent,
                        borderRadius: 30.0,
                        borderWidth: 1.0,
                        buttonSize: 44.0,
                        icon: Icon(
                          Icons.close_rounded,
                          color: Color(0xFF57636C),
                          size: 24.0,
                        ),
                        onPressed: () async {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                ),
                Form(
                  key: _model.formKey,
                  autovalidateMode: AutovalidateMode.disabled,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      TextFormField(
                        controller: _model.emailTextController,
                        focusNode: _model.emailFocusNode,
                        autofocus: false,
                        obscureText: false,
                        decoration: InputDecoration(
                          isDense: true,
                          labelStyle: FlutterFlowTheme.of(context).labelMedium,
                          hintText: FFLocalizations.of(context).getText('7to24sjb' /* Example : HTML */),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFFE2E8F0), width: 1.0),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0x00000000), width: 1.0),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: FlutterFlowTheme.of(context).error, width: 1.0),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: FlutterFlowTheme.of(context).error, width: 1.0),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: EdgeInsets.all(20.0),
                        ),
                        style: FlutterFlowTheme.of(context).bodyMedium,
                        textAlign: TextAlign.start,
                        cursorColor: FlutterFlowTheme.of(context).primaryText,
                        validator: _model.emailTextControllerValidator.asValidator(context),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 0.0),
                        child: FutureBuilder<ApiCallResponse>(
                          future: FreelancerAuthorizationGroup.levelCall.call(
                            authToken: FFAppState().apitoken,
                          ),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return Center(
                                child: SizedBox(
                                  width: 50.0,
                                  height: 50.0,
                                  child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF6E2A87)),
                                  ),
                                ),
                              );
                            }
                            final dropDownLevelResponse = snapshot.data!;
                            final options = List<String>.from(
                              FreelancerAuthorizationGroup.levelCall.levelList(
                                dropDownLevelResponse.jsonBody,
                              )!.map((e) => getJsonField(e, r'''$.id''').toString()),
                            );
                            final optionLabels = FreelancerAuthorizationGroup.levelCall.levelList(
                              dropDownLevelResponse.jsonBody,
                            )!.map((e) => getJsonField(e, r'''$.name''').toString()).toList();

                            // Set dropdown value/controller after options are loaded
                            if (_model.dropDownValue == null && widget.initialSkill?['experience'] != null) {
                              final initialId = widget.initialSkill!['experience'].toString();
                              if (options.contains(initialId)) {
                                _model.dropDownValue = initialId;
                                _model.dropDownValueController = FormFieldController<String>(initialId);
                                final idx = options.indexOf(initialId);
                                selectedExperienceName = idx >= 0 ? optionLabels[idx] : null;
                              }
                            }

                            return FlutterFlowDropDown<String>(
                              controller: _model.dropDownValueController ??=
                                  FormFieldController<String>(_model.dropDownValue ?? ''),
                              options: options,
                              optionLabels: optionLabels,
                              onChanged: (val) {
                                setState(() {
                                  _model.dropDownValue = val;
                                  final idx = options.indexOf(val ?? '');
                                  selectedExperienceName = idx >= 0 ? optionLabels[idx] : null;
                                });
                              },
                              width: double.infinity,
                              height: 56.0,
                              textStyle: FlutterFlowTheme.of(context).bodyMedium,
                              hintText: FFLocalizations.of(context).getText('ijtleo45' /* Experience level */),
                              icon: Icon(Icons.keyboard_arrow_down_rounded, color: Color(0xFF898989), size: 24.0),
                              fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                              elevation: 2.0,
                              borderColor: Color(0xFFE2E8F0),
                              borderWidth: 0.0,
                              borderRadius: 8.0,
                              margin: EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 12.0, 0.0),
                              hidesUnderline: true,
                              isOverButton: false,
                              isSearchable: false,
                              isMultiSelect: false,
                            );
                          },
                        ),
                      ),
                      Align(
                        alignment: AlignmentDirectional(0.0, -1.0),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(20.0, 20.0, 20.0, 0.0),
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
                                      Navigator.pop(context);
                                    },
                                    text: FFLocalizations.of(context).getText('i2kiacv4' /* Cancel */),
                                    options: FFButtonOptions(
                                      padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                                      iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                                      color: Color(0x004B39EF),
                                      textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                        font: GoogleFonts.interTight(),
                                        color: Color(0xFF6E2A87),
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
                                      if (_model.formKey.currentState == null ||
                                          !_model.formKey.currentState!.validate()) {
                                        return;
                                      }
                                      if (_model.dropDownValue == null || _model.dropDownValue == '') {
                                        return;
                                      }
                                      _model.apiResultrh3 = await FreelancerAuthorizationGroup.addSkillCall.call(
                                        title: _model.emailTextController.text,
                                        experience: _model.dropDownValue,
                                        authToken: FFAppState().apitoken,
                                      );
                                      if ((_model.apiResultrh3?.succeeded ?? true)) {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              getJsonField((_model.apiResultrh3?.jsonBody ?? ''), r'''$.message''').toString(),
                                              style: TextStyle(color: Colors.white),
                                            ),
                                            duration: Duration(milliseconds: 4000),
                                            backgroundColor: Color(0xFF6E2A87),
                                          ),
                                        );
                                        Navigator.pop(context, {
                                          'title': _model.emailTextController.text,
                                          'experience': _model.dropDownValue, // ID
                                          'experience_name': selectedExperienceName, // Display name
                                        });
                                      } else {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              getJsonField((_model.apiResultrh3?.jsonBody ?? ''), r'''$.message''').toString(),
                                              style: TextStyle(color: Colors.white),
                                            ),
                                            duration: Duration(milliseconds: 4000),
                                            backgroundColor: Color(0xFF6E2A87),
                                          ),
                                        );
                                      }
                                      setState(() {});
                                    },
                                    text: widget.initialSkill == null
                                        ? FFLocalizations.of(context).getText('uaoz53nw' /* Add */)
                                        : 'Update',
                                    options: FFButtonOptions(
                                      padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                                      iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                                      color: Color(0x004B39EF),
                                      textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                        font: GoogleFonts.interTight(),
                                        color: Colors.white,
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}