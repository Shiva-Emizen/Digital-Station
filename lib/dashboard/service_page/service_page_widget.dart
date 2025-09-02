import '/backend/api_requests/api_calls.dart';
import '/components/no_data_found_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'dart:async';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'service_page_model.dart';
export 'service_page_model.dart';

class ServicePageWidget extends StatefulWidget {
  const ServicePageWidget({
    super.key,
    required this.categoryId,
  });

  final String? categoryId;

  static String routeName = 'ServicePage';
  static String routePath = '/servicePage';

  @override
  State<ServicePageWidget> createState() => _ServicePageWidgetState();
}

class _ServicePageWidgetState extends State<ServicePageWidget> {
  late ServicePageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ServicePageModel());
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
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 20),
            child: Stack(
              children: [
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
                        padding: EdgeInsetsDirectional.fromSTEB(0.0, 6.0, 20.0, 0.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Align(
                              alignment: AlignmentDirectional(-1.0, -1.0),
                              child: Text(
                                FFLocalizations.of(context).getText('tq1gkx9t' /* Services */),
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
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(20.0, 60.0, 20.0, 0.0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        FutureBuilder<ApiCallResponse>(
                          future: (_model.apiRequestCompleter ??=
                          Completer<ApiCallResponse>()
                            ..complete(
                              ClientHomePageGroup.serviceApiCall.call(
                                authToken: FFAppState().apitoken,
                                categoryId: widget.categoryId,
                              ),
                            ))
                              .future,
                          builder: (context, snapshot) {
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
                            final listViewServiceApiResponse = snapshot.data!;
                            final serviceList = ClientHomePageGroup.serviceApiCall
                                .serviceList(listViewServiceApiResponse.jsonBody)
                                ?.toList() ??
                                [];
                            if (serviceList.isEmpty) {
                              return Container(
                                height: 600.0,
                                child: NoDataFoundWidget(
                                  title: 'No new service',
                                ),
                              );
                            }

                            return ListView.separated(
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              itemCount: serviceList.length,
                              separatorBuilder: (_, __) => SizedBox(height: 16.0),
                              itemBuilder: (context, serviceListIndex) {
                                final serviceListItem = serviceList[serviceListIndex];
                                final isSaved = getJsonField(serviceListItem, r'''$.isSaved''');
                                return InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () {
                                    context.pushNamed(
                                      ServiceDetailPageWidget.routeName,
                                      queryParameters: {
                                        'serviceId': getJsonField(serviceListItem, r'''$.id''').toString(),
                                      }.withoutNulls,
                                    );
                                  },
                                  child: Container(
                                    width: double.infinity,
                                    height: 125.0,
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context).secondaryBackground,
                                      borderRadius: BorderRadius.circular(16.0),
                                    ),
                                    child: Row(
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(8.0),
                                          child: SizedBox(
                                            height: 125,
                                            width: 125,
                                            child: Image.network(
                                              valueOrDefault<String>(
                                                getJsonField(serviceListItem, r'''$.gallery[0].url''')?.toString(),
                                                'https://fastly.picsum.photos/id/237/200/300.jpg?hmac=TmmQSbShHz9CdQm0NkEjx1Dyh_Y984R9LpNrpvH2D_U',
                                              ),
                                              fit: BoxFit.cover,
                                              errorBuilder: (context, error, stackTrace) {
                                                return Image.asset(
                                                  'assets/images/placeholder.png',
                                                  width: 70.0,
                                                  height: 70.0,
                                                  fit: BoxFit.cover,
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Stack(
                                            children: [
                                              Padding(
                                                padding: EdgeInsetsDirectional.fromSTEB(0, 0, 40, 0),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding: EdgeInsetsDirectional.fromSTEB(16.0, 16.0, 0.0, 0.0),
                                                      child: Row(
                                                        children: [
                                                          ClipRRect(
                                                            borderRadius: BorderRadius.circular(8.0),
                                                            child: Image.asset(
                                                              'assets/images/user-01.png',
                                                              width: 13.0,
                                                              height: 13.0,
                                                              fit: BoxFit.cover,
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding: EdgeInsetsDirectional.fromSTEB(2.0, 0.0, 0.0, 0.0),
                                                            child: SizedBox(
                                                              width: 80,
                                                              child: Text(
                                                                valueOrDefault<String>(
                                                                  getJsonField(serviceListItem, r'''$.username''')?.toString(),
                                                                  'N/A',
                                                                ),
                                                                maxLines: 1,
                                                                overflow: TextOverflow.ellipsis,
                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                  fontFamily: 'primaryFont',
                                                                  color: Color(0xFF898989),
                                                                  fontSize: 10.0,
                                                                  letterSpacing: 0.0,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Container(
                                                      width: MediaQuery.sizeOf(context).width * 0.46,
                                                      child: Padding(
                                                        padding: EdgeInsetsDirectional.fromSTEB(16.0, 16.0, 0.0, 0.0),
                                                        child: Text(
                                                          valueOrDefault<String>(
                                                            getJsonField(serviceListItem, r'''$.description''')?.toString(),
                                                            'N/A',
                                                          ),
                                                          maxLines: 2,
                                                          overflow: TextOverflow.ellipsis,
                                                          style: FlutterFlowTheme.of(context)
                                                              .bodyMedium
                                                              .override(
                                                            fontFamily: 'primaryFont',
                                                            fontSize: 13.0,
                                                            letterSpacing: 0.0,
                                                            fontWeight: FontWeight.bold,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(child: Container()),
                                                    Padding(
                                                      padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 0.0, 10.0),
                                                      child: Text(
                                                        'Start From \$${valueOrDefault<String>(
                                                          getJsonField(serviceListItem, r'''$.start_from''')?.toString(),
                                                          'N/A',
                                                        )}',
                                                        maxLines: 1,
                                                        overflow: TextOverflow.ellipsis,
                                                        style: FlutterFlowTheme.of(context)
                                                            .bodyMedium
                                                            .override(
                                                          fontFamily: 'primaryFont',
                                                          color: Color(0xFF898989),
                                                          fontSize: 10.0,
                                                          letterSpacing: 0.0,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              // Bookmark icon at top right
                                              Positioned(
                                                top: 10,
                                                right: 10,
                                                child: InkWell(
                                                  splashColor: Colors.transparent,
                                                  focusColor: Colors.transparent,
                                                  hoverColor: Colors.transparent,
                                                  highlightColor: Colors.transparent,
                                                  onTap: () async {
                                                    final serviceId = getJsonField(serviceListItem, r'''$.id''').toString();
                                                    final isSaved = getJsonField(serviceListItem, r'''$.isSaved''');
                                                    String toastMessage = 'Something went wrong';

                                                    final apiResult = await ClientHomePageGroup.addToFavouriteCall.call(
                                                      id: serviceId,
                                                      authToken: FFAppState().apitoken,
                                                    );
                                                    toastMessage = getJsonField(apiResult.jsonBody, r'''$.message''')?.toString() ?? toastMessage;
                                                    ScaffoldMessenger.of(context).showSnackBar(
                                                      SnackBar(
                                                        content: Text(
                                                          toastMessage,
                                                          style: TextStyle(color: Colors.white),
                                                        ),
                                                        duration: Duration(milliseconds: 4000),
                                                        backgroundColor: Color(0xFF6E2A87),
                                                      ),
                                                    );
                                                    safeSetState(() => _model.apiRequestCompleter = null);
                                                  },
                                                  child: Icon(
                                                    isSaved ? Icons.bookmark : Icons.bookmark_border,
                                                    color: FlutterFlowTheme.of(context).primaryText,
                                                    size: 24.0,
                                                  ),
                                                ),
                                              ),
                                              // Rating at bottom right
                                              Positioned(
                                                bottom: 10,
                                                right: -14,
                                                child: Row(
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    Icon(
                                                      Icons.star,
                                                      color: Color(0xFFFFCF26),
                                                      size: 16.0,
                                                    ),
                                                    SizedBox(
                                                      width: 40,
                                                      child: Text(
                                                        valueOrDefault<String>(
                                                          getJsonField(serviceListItem, r'''$.average_reviews''')?.toString(),
                                                          'N/A',
                                                        ),
                                                        maxLines: 1,
                                                        overflow: TextOverflow.ellipsis,
                                                        style: FlutterFlowTheme.of(context)
                                                            .bodyMedium
                                                            .override(
                                                          fontFamily: 'primaryFont',
                                                          fontSize: 12.0,
                                                          letterSpacing: 0.0,
                                                        ),
                                                      ),
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
                                );
                              },
                            );
                          },
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