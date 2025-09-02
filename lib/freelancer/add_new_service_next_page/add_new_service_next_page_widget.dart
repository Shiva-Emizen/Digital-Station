import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/index.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'add_new_service_next_page_model.dart';
export 'add_new_service_next_page_model.dart';

class AddNewServiceNextPageWidget extends StatefulWidget {
  const AddNewServiceNextPageWidget({
    super.key,
    required this.serviceId,
  });

  final String? serviceId;

  static String routeName = 'AddNewServiceNextPage';
  static String routePath = '/addNewServiceNextPage';

  @override
  State<AddNewServiceNextPageWidget> createState() =>
      _AddNewServiceNextPageWidgetState();
}

class _AddNewServiceNextPageWidgetState
    extends State<AddNewServiceNextPageWidget> {
  late AddNewServiceNextPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  List<dynamic> _planList = [];
  bool _shouldRefreshApi = false;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AddNewServiceNextPageModel());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments as Map?;
    if (args != null && args['callApi'] == true) {
      _shouldRefreshApi = true;
      setState(() {
        _model.apiRequestCompleter = null;
      });
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

    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
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
          body: Stack(
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(20.0, 40, 20.0, 20),
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
                        Navigator.pop(context);
                      },
                    ),
                    Padding(
                      padding:
                      EdgeInsetsDirectional.fromSTEB(0.0, 10, 20.0, 0.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            FFLocalizations.of(context).getText(
                              '1y1701ac' /* Add New Service */,
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
                        color: FlutterFlowTheme.of(context).secondaryBackground,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 80.0, 0.0, 0.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding:
                        EdgeInsetsDirectional.fromSTEB(20.0, 20, 20.0, 0.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 15.0, 0.0, 0.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                        '1ig4bjdg' /* Packages */,
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
                            FFButtonWidget(
                              onPressed: () async {
                                FFAppState().deleteFeatures();
                                FFAppState().features = [];
                                safeSetState(() {});
                                final result = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AddPakagePageWidget(id: widget.serviceId),
                                  ),
                                );
                                if (result != null && result['callApi'] == true) {
                                  setState(() {
                                    _model.apiRequestCompleter = null; // This will refresh the API
                                  });
                                }
                              },
                              text: FFLocalizations.of(context).getText(
                                'swyjkk5a' /* Add  */,
                              ),
                              options: FFButtonOptions(
                                height: 32.0,
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    16.0, 0.0, 16.0, 0.0),
                                iconPadding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 0.0),
                                color: Color(0xFF6E2A87),
                                textStyle: FlutterFlowTheme.of(context)
                                    .titleSmall
                                    .override(
                                  font: GoogleFonts.interTight(
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .fontStyle,
                                  ),
                                  color: Colors.white,
                                  fontSize: 14.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .fontStyle,
                                ),
                                elevation: 0.0,
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 0.0),
                        child: FutureBuilder<ApiCallResponse>(
                          future: (_model.apiRequestCompleter ??=
                          Completer<ApiCallResponse>()
                            ..complete(FreelancerHomePageGroup
                                .getPlanCall
                                .call(
                                authToken: FFAppState().apitoken,
                                serviceId: widget.serviceId)
                                .then((response) {
                              print(
                                  'API Request Auth Token: ${FFAppState().apitoken}');
                              print(
                                  'API Response JSON: ${response.jsonBody}');
                              print(
                                  'API Response JSON: ${response.statusCode}');
                              return response;
                            })))
                              .future,
                          builder: (context, snapshot) {
                            print(
                                'Auth Token Sent in Request: ${FFAppState().apitoken}');
                            print(
                                'Auth Token Sent in Request: ${FFAppState().apitoken}');

                            if (!snapshot.hasData) {
                              return Center(
                                child: SizedBox(
                                  width: 50.0,
                                  height: 50.0,
                                  child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      Color(0xFF6E2A87),
                                    ),
                                  ),
                                ),
                              );
                            }

                            final listViewGetPlanResponse = snapshot.data!;

                            final planList = FreelancerHomePageGroup.getPlanCall
                                .planList(listViewGetPlanResponse.jsonBody)
                                ?.toList() ??
                                [];

                            _planList = planList;

                            return Builder(
                              builder: (context) {
                                return RefreshIndicator(
                                  color: Color(0xFF6E2A87),
                                  onRefresh: () async {
                                    safeSetState(() =>
                                    _model.apiRequestCompleter = null);
                                    await _model.waitForApiRequestCompleted();
                                  },
                                  child: ListView.builder(
                                    padding: EdgeInsets.zero,
                                    shrinkWrap: true,
                                    scrollDirection: Axis.vertical,
                                    itemCount: _planList.length,
                                    itemBuilder: (context, planListIndex) {
                                      final planListItem =
                                      _planList[planListIndex];
                                      return Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            20.0, 20.0, 20.0, 0.0),
                                        child: Container(
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryBackground,
                                            borderRadius:
                                            BorderRadius.circular(10.0),
                                          ),
                                          child: Padding(
                                            padding:
                                            EdgeInsetsDirectional.fromSTEB(
                                                15.0, 22.0, 15.0, 22.0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceBetween,
                                              children: [
                                                Row(
                                                  mainAxisSize:
                                                  MainAxisSize.max,
                                                  children: [
                                                    ClipRRect(
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                      child: Image.asset(
                                                        'assets/images/package.png',
                                                        width: 35.0,
                                                        height: 35.0,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                      EdgeInsetsDirectional
                                                          .fromSTEB(
                                                          15.0,
                                                          0.0,
                                                          0.0,
                                                          0.0),
                                                      child: Text(
                                                        getJsonField(
                                                          planListItem,
                                                          r'''$.title''',
                                                        ).toString(),
                                                        style:
                                                        FlutterFlowTheme.of(
                                                            context)
                                                            .bodyMedium
                                                            .override(
                                                          fontFamily:
                                                          'primaryFont',
                                                          letterSpacing:
                                                          0.0,
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                      EdgeInsetsDirectional
                                                          .fromSTEB(
                                                          14.0,
                                                          0.0,
                                                          0.0,
                                                          0.0),
                                                      child: Container(
                                                        decoration:
                                                        BoxDecoration(
                                                          color:
                                                          Color(0x45898989),
                                                          borderRadius:
                                                          BorderRadius
                                                              .circular(
                                                              10.0),
                                                        ),
                                                        child: Align(
                                                          alignment:
                                                          AlignmentDirectional(
                                                              0.0, 0.0),
                                                          child: Padding(
                                                            padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                14.0,
                                                                6.0,
                                                                14.0,
                                                                6.0),
                                                            child: Text(
                                                              getJsonField(
                                                                planListItem,
                                                                r'''$.price''',
                                                              ).toString(),
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
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Icon(
                                                  Icons.arrow_forward_ios,
                                                  color: FlutterFlowTheme.of(
                                                      context)
                                                      .primaryText,
                                                  size: 20.0,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                );
                              },
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
                child: Padding(
                  padding:
                  EdgeInsetsDirectional.fromSTEB(20.0, 200.0, 20.0, 20.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            context.pushNamed(AddNewServiceWidget.routeName);
                          },
                          child: Container(
                            width: double.infinity,
                            height: 56.0,
                            decoration: BoxDecoration(
                              color: Color(0xFFE7E7E7),
                              borderRadius: BorderRadius.circular(8.0),
                              shape: BoxShape.rectangle,
                            ),
                            child: Align(
                              alignment: AlignmentDirectional(0.0, 0.0),
                              child: Text(
                                FFLocalizations.of(context).getText(
                                  '3mllwvb3' /* Previous */,
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                  fontFamily: 'primaryFont',
                                  color: Color(0xFF6E2A87),
                                  fontSize: 16.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            if (_planList.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Please add package',
                                    style: TextStyle(color: Color(0xFFFFFFFF)),
                                  ),
                                  backgroundColor: Color(0xFF6E2A87),
                                ),
                              );
                              return;
                            }

                            context.pushNamed(
                              PublishServicePageWidget.routeName,
                              queryParameters: {
                                'serviceId': widget.serviceId,
                              }.withoutNulls,
                            );
                          },
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
                            child: Align(
                              alignment: AlignmentDirectional(0.0, 0.0),
                              child: Text(
                                FFLocalizations.of(context).getText(
                                  'xq9mxche' /* Next */,
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                  fontFamily: 'primaryFont',
                                  color: Colors.white,
                                  fontSize: 16.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
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
    );
  }
}