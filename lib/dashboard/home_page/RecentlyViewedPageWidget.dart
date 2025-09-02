import 'package:flutter/material.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import '../../profile/service_detail_page/service_detail_page_widget.dart';
import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';

class RecentlyViewedPageWidget extends StatefulWidget {
  static String routeName = 'RecentlyViewedPage';
  static String routePath = '/recentlyViewedPage';

  final List<Map<String, dynamic>> recentViewList;

  const RecentlyViewedPageWidget({Key? key, required this.recentViewList}) : super(key: key);

  @override
  State<RecentlyViewedPageWidget> createState() => _RecentlyViewedPageWidgetState();
}

class _RecentlyViewedPageWidgetState extends State<RecentlyViewedPageWidget> {
  late List<Map<String, dynamic>> _recentViewList;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _recentViewList = List<Map<String, dynamic>>.from(widget.recentViewList);
  }

  Future<void> _refreshRecentlyViewed() async {
    setState(() => _isLoading = true);
    final recentResponse = await ClientHomePageGroup.recentServicesCall.call(
      authToken: FFAppState().apitoken,
    );
    final newList = ClientHomePageGroup.recentServicesCall.recentViewList(
      recentResponse.jsonBody,
    )?.map((e) => Map<String, dynamic>.from(e)).toList() ?? [];
    setState(() {
      _recentViewList = newList;
      _isLoading = false;
    });
  }

  Future<void> _toggleBookmark(int index) async {
    final item = _recentViewList[index];
    final serviceId = getJsonField(item, r'''$.id''').toString();
    final response = await ClientHomePageGroup.addToFavouriteCall.call(
      id: serviceId,
      authToken: FFAppState().apitoken,
    );
    final apiMessage = getJsonField(response.jsonBody, r'''$.message''')?.toString() ?? 'No message';
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(apiMessage, style: TextStyle(color: Colors.white)),
        backgroundColor: Color(0xFF6E2A87),
      ),
    );
    if (response.succeeded) {
      await _refreshRecentlyViewed();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      body: SafeArea(
        top: true,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
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
                    'Recently Viewed',
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
              child: _isLoading
                  ? Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF6E2A87)),
                ),
              )
                  : _recentViewList.isEmpty
                  ? Center(
                child: Text(
                  'No Data Found',
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                    fontFamily: 'primaryFont',
                    color: Color(0xFF252525),
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
                  : RefreshIndicator(
                color: Color(0xFF6E2A87),
                onRefresh: _refreshRecentlyViewed,
                child: ListView.separated(
                  padding: const EdgeInsetsDirectional.fromSTEB(20.0, 40.0, 20.0, 20.0),
                  itemCount: _recentViewList.length,
                  separatorBuilder: (_, __) => SizedBox(height: 16.0),
                  itemBuilder: (context, index) {
                    final item = _recentViewList[index];
                    final imageUrl = getJsonField(item, r'''$.gallery[0].url''')?.toString() ??
                        getJsonField(item, r'''$.image.url''')?.toString() ??
                        'https://fastly.picsum.photos/id/237/200/300.jpg?hmac=TmmQSbShHz9CdQm0NkEjx1Dyh_Y984R9LpNrpvH2D_U';
                    final username = valueOrDefault<String>(
                      getJsonField(item, r'''$.username''')?.toString(),
                      'N/A',
                    );
                    final description = valueOrDefault<String>(
                      getJsonField(item, r'''$.title''')?.toString(),
                      'N/A',
                    );
                    final startFrom = valueOrDefault<String>(
                      getJsonField(item, r'''$.start_from''')?.toString(),
                      'N/A',
                    );
                    final averageReviews = valueOrDefault<String>(
                      getJsonField(item, r'''$.average_reviews''')?.toString(),
                      'N/A',
                    );
                    final isSaved = getJsonField(item, r'''$.isSaved''') ?? false;

                    return InkWell(
                      onTap: () {
                        context.pushNamed(
                          ServiceDetailPageWidget.routeName,
                          queryParameters: {
                            'serviceId': getJsonField(item, r'''$.id''').toString(),
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
                                width: 125,
                                height: 125,
                                child: Image.network(
                                  imageUrl,
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
                                    padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 40, 0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsetsDirectional.fromSTEB(16.0, 16.0, 0.0, 0.0),
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
                                                padding: const EdgeInsetsDirectional.fromSTEB(2.0, 0.0, 0.0, 0.0),
                                                child: SizedBox(
                                                  width: 80,
                                                  child: Text(
                                                    username,
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
                                            padding: const EdgeInsetsDirectional.fromSTEB(16.0, 16.0, 0.0, 0.0),
                                            child: Text(
                                              description,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
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
                                          padding: const EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 0.0, 10.0),
                                          child: Text(
                                            'Start From \$${startFrom}',
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
                                        await _toggleBookmark(index);
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
                                            overflow: TextOverflow.ellipsis,
                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
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
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}