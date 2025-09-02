import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'add_occupation_model.dart';

class AddOccupationWidget extends StatefulWidget {
  final Map<String, dynamic>? initialOccupation;

  const AddOccupationWidget({super.key, this.initialOccupation});

  @override
  State<AddOccupationWidget> createState() => _AddOccupationWidgetState();
}

class _AddOccupationWidgetState extends State<AddOccupationWidget> {
  late AddOccupationModel _model;
  String? selectedCategoryName;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AddOccupationModel());
    // Do NOT set dropdown value/controller here!
    selectedCategoryName = widget.initialOccupation?['category_name'];
  }

  @override
  void dispose() {
    _model.maybeDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                          widget.initialOccupation == null
                              ? 'Add Occupation'
                              : 'Edit Occupation',
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
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 0.0),
                        child: FutureBuilder<ApiCallResponse>(
                          future: ClientHomePageGroup.categoryCall.call(
                            authToken: FFAppState().apitoken,
                          ),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return Center(
                                child: SizedBox(
                                  width: 50.0,
                                  height: 50.0,
                                  child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Color(0xFF6E2A87)),
                                  ),
                                ),
                              );
                            }
                            final dropDownCategoryResponse = snapshot.data!;
                            final options = List<String>.from(
                              ClientHomePageGroup.categoryCall
                                  .categoryList(
                                    dropDownCategoryResponse.jsonBody,
                                  )!
                                  .map((e) =>
                                      getJsonField(e, r'''$.id''').toString()),
                            );
                            final optionLabels = ClientHomePageGroup
                                .categoryCall
                                .categoryList(
                                  dropDownCategoryResponse.jsonBody,
                                )!
                                .map((e) =>
                                    getJsonField(e, r'''$.name''').toString())
                                .toList();

                            // Set dropdown value/controller after options are loaded
                            if (_model.dropDownValue == null &&
                                widget.initialOccupation?['category_id'] !=
                                    null) {
                              final initialId = widget
                                  .initialOccupation!['category_id']
                                  .toString();
                              if (options.contains(initialId)) {
                                _model.dropDownValue = initialId;
                                _model.dropDownValueController =
                                    FormFieldController<String>(initialId);
                                final idx = options.indexOf(initialId);
                                selectedCategoryName =
                                    idx >= 0 ? optionLabels[idx] : null;
                              }
                            }

                            return FlutterFlowDropDown<String>(
                              controller: _model.dropDownValueController ??=
                                  FormFieldController<String>(
                                      _model.dropDownValue ?? ''),
                              options: options,
                              optionLabels: optionLabels,
                              onChanged: (val) {
                                setState(() {
                                  _model.dropDownValue = val;
                                  final idx = options.indexOf(val ?? '');
                                  selectedCategoryName =
                                      idx >= 0 ? optionLabels[idx] : null;
                                });
                              },
                              width: double.infinity,
                              height: 56.0,
                              textStyle:
                                  FlutterFlowTheme.of(context).bodyMedium,
                              hintText: 'Select category',
                              icon: Icon(Icons.keyboard_arrow_down_rounded,
                                  color: Color(0xFF898989), size: 24.0),
                              fillColor: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                              elevation: 2.0,
                              borderColor: Color(0xFFE2E8F0),
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
                        alignment: AlignmentDirectional(0.0, -1.0),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              20.0, 60.0, 20.0, 0.0),
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
                                    text: 'Cancel',
                                    options: FFButtonOptions(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          16.0, 0.0, 16.0, 0.0),
                                      iconPadding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              0.0, 0.0, 0.0, 0.0),
                                      color: Color(0x004B39EF),
                                      textStyle: FlutterFlowTheme.of(context)
                                          .titleSmall
                                          .override(
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
                                  child: FFButtonWidget(
                                    onPressed: () async {
                                      if (_model.dropDownValue != null &&
                                          _model.dropDownValue != '') {
                                        _model.apiResultros =
                                            await FreelancerAuthorizationGroup
                                                .occupationCall
                                                .call(
                                          categoryId: _model.dropDownValue,
                                          authToken: FFAppState().apitoken,
                                        );
                                        if ((_model.apiResultros?.succeeded ??
                                            true)) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                getJsonField(
                                                        (_model.apiResultros
                                                                ?.jsonBody ??
                                                            ''),
                                                        r'''$.message''')
                                                    .toString(),
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                              duration:
                                                  Duration(milliseconds: 4000),
                                              backgroundColor:
                                                  Color(0xFF6E2A87),
                                            ),
                                          );
                                          Navigator.pop(context, {
                                            'category_id': _model.dropDownValue,
                                            // ID
                                            'category_name':
                                                selectedCategoryName,
                                            // Display name
                                          });
                                        } else {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                getJsonField(
                                                        (_model.apiResultros
                                                                ?.jsonBody ??
                                                            ''),
                                                        r'''$.message''')
                                                    .toString(),
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                              duration:
                                                  Duration(milliseconds: 4000),
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
                                              'Please select a category',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            duration:
                                                Duration(milliseconds: 4000),
                                            backgroundColor: Color(0xFF6E2A87),
                                          ),
                                        );
                                      }
                                      setState(() {});
                                    },
                                    text: widget.initialOccupation == null
                                        ? 'Add'
                                        : 'Update',
                                    options: FFButtonOptions(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          16.0, 0.0, 16.0, 0.0),
                                      iconPadding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              0.0, 0.0, 0.0, 0.0),
                                      color: Color(0x004B39EF),
                                      textStyle: FlutterFlowTheme.of(context)
                                          .titleSmall
                                          .override(
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
