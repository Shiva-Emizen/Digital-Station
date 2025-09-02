import '../../profile/service_detail_page/service_detail_page_widget.dart';
import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
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
  late Future<ApiCallResponse> _popularServiceFuture;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ViewAllPageModel());
    _popularServiceFuture = ClientHomePageGroup.popularServiceCall.call(
      authToken: FFAppState().apitoken,
    );
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  Future<void> _refreshPopularServices() async {
    setState(() {
      _popularServiceFuture = ClientHomePageGroup.popularServiceCall.call(
        authToken: FFAppState().apitoken,
      );
    });
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
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      borderRadius: BorderRadius.circular(8.0),
                      onTap: () => Navigator.of(context).pop(),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        padding: const EdgeInsets.all(8.0),
                        child: const Icon(
                          Icons.arrow_back_ios_new,
                          color: Color(0xFF252525),
                          size: 18.0,
                        ),
                      ),
                    ),
                    Text(
                      'Popular Services',
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'primaryFont',
                            color: Color(0xFF252525),
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(width: 36.0),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(
                      20.0, 20.0, 20.0, 20.0),
                  child: FutureBuilder<ApiCallResponse>(
                    future: _popularServiceFuture,
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
                      final serviceList = ClientHomePageGroup.popularServiceCall
                              .popularServiceList(snapshot.data!.jsonBody)
                              ?.toList() ??
                          [];
                      if (serviceList.isEmpty) {
                        return Center(
                          child: Text(
                            'No Data Found',
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'primaryFont',
                                  color: Color(0xFF252525),
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        );
                      }
                      return RefreshIndicator(
                        color: Color(0xFF6E2A87),
                        onRefresh: _refreshPopularServices,
                        child: ListView.separated(
                          padding: EdgeInsets.zero,
                          itemCount: serviceList.length,
                          separatorBuilder: (_, __) => SizedBox(height: 16.0),
                          itemBuilder: (context, index) {
                            final service = serviceList[index];
                            final imageUrl = valueOrDefault<String>(
                              getJsonField(service, r'''$.gallery[0].url''')
                                  ?.toString(),
                              'https://fastly.picsum.photos/id/237/200/300.jpg?hmac=TmmQSbShHz9CdQm0NkEjx1Dyh_Y984R9LpNrpvH2D_U',
                            );
                            final username = valueOrDefault<String>(
                              getJsonField(service, r'''$.username''')
                                  ?.toString(),
                              'N/A',
                            );
                            final description = valueOrDefault<String>(
                              getJsonField(service, r'''$.description''')
                                  ?.toString(),
                              'N/A',
                            );
                            final startFrom = valueOrDefault<String>(
                              getJsonField(service, r'''$.start_from''')
                                  ?.toString(),
                              'N/A',
                            );
                            final averageReviews = valueOrDefault<String>(
                              getJsonField(service, r'''$.average_reviews''')
                                  ?.toString(),
                              'N/A',
                            );
                            final isSaved =
                                getJsonField(service, r'''$.isSaved''') ??
                                    false;

                            return InkWell(
                              onTap: () {
                                context.pushNamed(
                                  ServiceDetailPageWidget.routeName,
                                  queryParameters: {
                                    'serviceId':
                                        getJsonField(service, r'''$.id''')
                                            .toString(),
                                  }.withoutNulls,
                                );
                              },
                              child: Container(
                                width: double.infinity,
                                height: 125.0,
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                  borderRadius: BorderRadius.circular(16.0),
                                ),
                                child: Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8.0),
                                      child: SizedBox(
                                        width: 125,
                                        height: 125,
                                        child: Image.network(
                                          imageUrl,
                                          fit: BoxFit.cover,
                                          errorBuilder:
                                              (context, error, stackTrace) {
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
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(0, 0, 40, 0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsetsDirectional
                                                          .fromSTEB(
                                                          16.0, 16.0, 0.0, 0.0),
                                                  child: Row(
                                                    children: [
                                                      ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8.0),
                                                        child: Image.asset(
                                                          'assets/images/user-01.png',
                                                          width: 13.0,
                                                          height: 13.0,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsetsDirectional
                                                                .fromSTEB(2.0,
                                                                0.0, 0.0, 0.0),
                                                        child: SizedBox(
                                                          width: 80,
                                                          child: Text(
                                                            username,
                                                            maxLines: 1,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'primaryFont',
                                                                  color: Color(
                                                                      0xFF898989),
                                                                  fontSize:
                                                                      10.0,
                                                                  letterSpacing:
                                                                      0.0,
                                                                ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  width:
                                                      MediaQuery.sizeOf(context)
                                                              .width *
                                                          0.46,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsetsDirectional
                                                            .fromSTEB(16.0,
                                                            16.0, 0.0, 0.0),
                                                    child: Text(
                                                      description,
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyMedium
                                                          .override(
                                                            fontFamily:
                                                                'primaryFont',
                                                            fontSize: 13.0,
                                                            letterSpacing: 0.0,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(child: Container()),
                                                Padding(
                                                  padding:
                                                      const EdgeInsetsDirectional
                                                          .fromSTEB(
                                                          16.0, 0.0, 0.0, 10.0),
                                                  child: Text(
                                                    'Start From \$${startFrom}',
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily:
                                                              'primaryFont',
                                                          color:
                                                              Color(0xFF898989),
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
                                              highlightColor:
                                                  Colors.transparent,
                                              onTap: () async {
                                                final serviceId = getJsonField(
                                                        service, r'''$.id''')
                                                    .toString();
                                                final response =
                                                    await ClientHomePageGroup
                                                        .addToFavouriteCall
                                                        .call(
                                                  id: serviceId,
                                                  authToken:
                                                      FFAppState().apitoken,
                                                );
                                                final apiMessage = getJsonField(
                                                            response.jsonBody,
                                                            r'''$.message''')
                                                        ?.toString() ??
                                                    'No message';
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  SnackBar(
                                                    content: Text(apiMessage,
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white)),
                                                    backgroundColor:
                                                        Color(0xFF6E2A87),
                                                  ),
                                                );
                                                if (response.succeeded) {
                                                  await _refreshPopularServices();
                                                }
                                              },
                                              child: Icon(
                                                isSaved
                                                    ? Icons.bookmark
                                                    : Icons.bookmark_border,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryText,
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
                                                const Icon(
                                                  Icons.star,
                                                  color: Color(0xFFFFCF26),
                                                  size: 16.0,
                                                ),
                                                SizedBox(
                                                  width: 40,
                                                  child: Text(
                                                    averageReviews,
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily:
                                                              'primaryFont',
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
                        ),
                      );
                    },
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
