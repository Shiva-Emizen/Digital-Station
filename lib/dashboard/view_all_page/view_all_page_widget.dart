import '../../profile/service_detail_page/service_detail_page_widget.dart';
import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'view_all_page_model.dart';
export 'view_all_page_model.dart';

class ViewAllPageWidget extends StatefulWidget {
  const ViewAllPageWidget({super.key});

  static String routeName = 'ViewAllPage';
  static String routePath = '/viewAllPage';

  @override
  State<ViewAllPageWidget> createState() => _ViewAllPageWidgetState();
}

class _ViewAllPageWidgetState extends State<ViewAllPageWidget> {
  late ViewAllPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ViewAllPageModel());
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
        backgroundColor: Color(0xFFF1F4F8),
        body: SafeArea(
          top: true,
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 0.0),
            child: Container(
              width: double.infinity,
              height: double.infinity,
              child: Stack(
                children: [
                  Align(
                    alignment: AlignmentDirectional(-1.0, -1.0),
                    child: Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 0.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Align(
                            alignment: AlignmentDirectional(-1.0, -1.0),
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
                          Align(
                            alignment: AlignmentDirectional(0.0, -1.0),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 20.0, 0.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    FFLocalizations.of(context).getText(
                                      'ik4fsx53' /* Popular Services */,
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
                          ),
                          Align(
                            alignment: AlignmentDirectional(0.0, -1.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(20.0, 40.0, 20.0, 0.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: FutureBuilder<ApiCallResponse>(
                            future: ClientHomePageGroup.popularServiceCall.call(
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
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        Color(0xFF6E2A87),
                                      ),
                                    ),
                                  ),
                                );
                              }
                              final gridViewPopularServiceResponse =
                                  snapshot.data!;

                              return Builder(
                                builder: (context) {
                                  final serviceList =
                                      ClientHomePageGroup.popularServiceCall
                                              .popularServiceList(
                                                gridViewPopularServiceResponse
                                                    .jsonBody,
                                              )
                                              ?.toList() ??
                                          [];

                                  return GridView.builder(
                                    padding: EdgeInsets.fromLTRB(
                                      0,
                                      20.0,
                                      0,
                                      20.0,
                                    ),
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 20.0,
                                      mainAxisSpacing: 20.0,
                                      childAspectRatio: 1.0,
                                    ),
                                    scrollDirection: Axis.vertical,
                                    itemCount: serviceList.length,
                                    itemBuilder: (context, serviceListIndex) {
                                      final serviceListItem =
                                          serviceList[serviceListIndex];
                                      return
                                        InkWell(
                                          onTap: (){
                                            context.pushNamed(
                                              ServiceDetailPageWidget.routeName,
                                              queryParameters: {
                                                'serviceId': serializeParam(
                                                  getJsonField(
                                                    serviceListItem,
                                                    r'''$.id''',
                                                  ).toString(),
                                                  ParamType.String,
                                                ),
                                              }.withoutNulls,
                                            );
                                          },
                                          child: Material(
                                          color: Colors.transparent,
                                          elevation: 2.0,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(12.0),
                                          ),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(12.0),
                                            child: Container(
                                              width: 126.0,
                                              height: 160.0,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(12.0),
                                              ),
                                              child: Container(
                                                width: double.infinity,
                                                child: Stack(
                                                  children: [
                                                    ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                      child: Image.network(
                                                        valueOrDefault<String>(
                                                          getJsonField(
                                                            serviceListItem,
                                                            r'''$.gallery[0].url''',
                                                          )?.toString(),
                                                          'https://placebear.com/250/250',
                                                        ),
                                                        width: double.infinity,
                                                        height: 70.0,
                                                        fit: BoxFit.fill,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(0.0, 80.0,
                                                                  0.0, 10.0),
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        6.0,
                                                                        0.0,
                                                                        6.0,
                                                                        0.0),
                                                            child: Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Row(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .min,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    ClipRRect(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              8.0),
                                                                      child: Image
                                                                          .asset(
                                                                        'assets/images/Icon_(Stroke).png',
                                                                        width:
                                                                            10.0,
                                                                        height:
                                                                            10.0,
                                                                        fit: BoxFit
                                                                            .cover,
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding: EdgeInsetsDirectional
                                                                          .fromSTEB(
                                                                              6.0,
                                                                              0.0,
                                                                              0.0,
                                                                              0.0),
                                                                      child: Text(
                                                                        valueOrDefault<
                                                                            String>(
                                                                          getJsonField(
                                                                            serviceListItem,
                                                                            r'''$.username''',
                                                                          )?.toString(),
                                                                          'N/A',
                                                                        ),
                                                                        style: FlutterFlowTheme.of(
                                                                                context)
                                                                            .bodyMedium
                                                                            .override(
                                                                              fontFamily:
                                                                                  'primaryFont',
                                                                              color:
                                                                                  Color(0xFF898989),
                                                                              fontSize:
                                                                                  8.0,
                                                                              letterSpacing:
                                                                                  0.0,
                                                                            ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                Align(
                                                                  alignment:
                                                                      AlignmentDirectional(
                                                                          0.0,
                                                                          0.0),
                                                                  child: Icon(
                                                                    Icons
                                                                        .bookmark_border,
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .primaryText,
                                                                    size: 24.0,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        6.0,
                                                                        0.0,
                                                                        6.0,
                                                                        0.0),
                                                            child: Container(
                                                              width: MediaQuery
                                                                          .sizeOf(
                                                                              context)
                                                                      .width *
                                                                  0.6,
                                                              decoration:
                                                                  BoxDecoration(),
                                                              child: Text(
                                                                valueOrDefault<
                                                                    String>(
                                                                  getJsonField(
                                                                    serviceListItem,
                                                                    r'''$.description''',
                                                                  )?.toString(),
                                                                  'N/A',
                                                                ),
                                                                maxLines: 2,
                                                                style: FlutterFlowTheme
                                                                        .of(context)
                                                                    .bodyMedium
                                                                    .override(
                                                                      fontFamily:
                                                                          'primaryFont',
                                                                      color: Color(
                                                                          0xFF252525),
                                                                      fontSize:
                                                                          10.0,
                                                                      letterSpacing:
                                                                          0.0,
                                                                    ),
                                                              ),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        6.0,
                                                                        6.0,
                                                                        6.0,
                                                                        0.0),
                                                            child: Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Padding(
                                                                  padding:
                                                                      EdgeInsetsDirectional
                                                                          .fromSTEB(
                                                                              6.0,
                                                                              0.0,
                                                                              0.0,
                                                                              0.0),
                                                                  child: Text(
                                                                    'Start From \$${valueOrDefault<String>(
                                                                      getJsonField(
                                                                        serviceListItem,
                                                                        r'''$.start_from''',
                                                                      )?.toString(),
                                                                      'N/A',
                                                                    )}',
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .override(
                                                                          fontFamily:
                                                                              'primaryFont',
                                                                          color: Color(
                                                                              0xFF898989),
                                                                          fontSize:
                                                                              8.0,
                                                                          letterSpacing:
                                                                              0.0,
                                                                        ),
                                                                  ),
                                                                ),
                                                                Row(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  children: [
                                                                    Icon(
                                                                      Icons.star,
                                                                      color: Color(
                                                                          0xFFFFCF26),
                                                                      size: 12.0,
                                                                    ),
                                                                    Padding(
                                                                      padding: EdgeInsetsDirectional
                                                                          .fromSTEB(
                                                                              2.0,
                                                                              0.0,
                                                                              0.0,
                                                                              0.0),
                                                                      child: Text(
                                                                        valueOrDefault<
                                                                            String>(
                                                                          getJsonField(
                                                                            serviceListItem,
                                                                            r'''$.average_reviews''',
                                                                          )?.toString(),
                                                                          'N/A',
                                                                        ),
                                                                        style: FlutterFlowTheme.of(
                                                                                context)
                                                                            .bodyMedium
                                                                            .override(
                                                                              fontFamily:
                                                                                  'primaryFont',
                                                                              fontSize:
                                                                                  10.0,
                                                                              letterSpacing:
                                                                                  0.0,
                                                                            ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
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
                                                                                ),
                                        );
                                    },
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ].divide(SizedBox(height: 8.0)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
