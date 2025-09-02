import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';

import '../../freelancer/portfolio_page/PortfolioGalleryDetailPageWidget.dart';
import '/backend/api_requests/api_calls.dart';
import '/components/no_data_found_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/index.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'FaqViewAllPage.dart';
import 'PortfolioViewAllPage.dart';
import 'RecommendedViewAllPage.dart';
import 'ViewAllReviewsPage.dart';
import 'service_detail_page_model.dart';
export 'service_detail_page_model.dart';

class ServiceDetailPageWidget extends StatefulWidget {
  const ServiceDetailPageWidget({
    super.key,
    this.serviceId,
  });

  final String? serviceId;

  static String routeName = 'ServiceDetailPage';
  static String routePath = '/serviceDetailPage';

  @override
  State<ServiceDetailPageWidget> createState() =>
      _ServiceDetailPageWidgetState();
}

class _ServiceDetailPageWidgetState extends State<ServiceDetailPageWidget> {
  late ServiceDetailPageModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isApiCalled = false;
  bool _isLoading = true;
  bool? _isSaved;
  dynamic _serviceDetail;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ServiceDetailPageModel());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isApiCalled) {
      _fetchServiceDetails();
      _isApiCalled = true;
    }
  }

  Future<void> _fetchServiceDetails() async {
    setState(() => _isLoading = true);
    print('Service Details API Request:');
    print('subCategoryId: ${widget.serviceId}');
    print('authToken: ${FFAppState().apitoken}');

    _model.detailsResponse = await ClientHomePageGroup.serviceDetailCall.call(
      subCategoryId: widget.serviceId,
      authToken: FFAppState().apitoken,
    );

    print('Service Details API Response: ${_model.detailsResponse?.jsonBody}');

    setState(() {
      _serviceDetail = _model.detailsResponse?.jsonBody;
      print('_serviceDetail: $_serviceDetail');
      _isSaved = getJsonField(_serviceDetail, r'''$.data.isSaved''');
      print('_isSaved: $_isSaved');
      final id = getJsonField(_serviceDetail, r'''$.data.id''');
      print('id: $id');
      _isLoading = false;
    });
  }

  Future<void> _toggleBookmark() async {
    if (_serviceDetail == null) return;
    final serviceId = getJsonField(_serviceDetail, r'''$.data.id''').toString();
    print('Toggle Bookmark API Request:');
    print('id: $serviceId');
    print('_isSaved: $_isSaved');
    print('authToken: ${FFAppState().apitoken}');

    final response = await ClientHomePageGroup.addToFavouriteCall.call(
      id: serviceId,
      authToken: FFAppState().apitoken,
    );

    print('Toggle Bookmark API Response: ${response.jsonBody}');

    final apiMessage =
        getJsonField(response.jsonBody, r'''$.message''')?.toString() ??
            'No message';
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(apiMessage, style: TextStyle(color: Colors.white)),
        backgroundColor: Color(0xFF6E2A87),
      ),
    );
    if (response.succeeded) {
      await _fetchServiceDetails();
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
    if (_isLoading) {
      return Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF6E2A87)),
          ),
        ),
      );
    }
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: NestedScrollView(
          floatHeaderSlivers: true,
          headerSliverBuilder: (context, _) => [
            SliverAppBar(
              expandedHeight: 200.0,
              collapsedHeight: 200.0,
              pinned: true,
              floating: true,
              snap: true,
              backgroundColor: Color(0xFF6E2A87),
              automaticallyImplyLeading: false,
              title: Row(
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
                  // FlutterFlowIconButton(
                  //   borderRadius: 8.0,
                  //   buttonSize: 36.0,
                  //   fillColor: Colors.white,
                  //   icon: Icon(
                  //     Icons.edit_outlined,
                  //     color: Color(0xFF252525),
                  //     size: 18.0,
                  //   ),
                  //   onPressed: () async {
                  //     context.safePop();
                  //   },
                  // ),
                ],
              ),
              actions: [],
              flexibleSpace: FlexibleSpaceBar(
                background: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    'https://picsum.photos/id/115/600',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              centerTitle: false,
              elevation: 2.0,
            )
          ],
          body: Builder(
            builder: (context) {
              return SafeArea(
                top: false,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () async {
                          context.pushNamed(
                            CompleteProfilePageWidget.routeName,
                            queryParameters: {
                              'userId': serializeParam(
                                getJsonField(
                                  ClientHomePageGroup.serviceDetailCall
                                      .serviceDetail(
                                    (_model.detailsResponse?.jsonBody ?? ''),
                                  ),
                                  r'''$.user_id''',
                                ).toString(),
                                ParamType.String,
                              ),
                            }.withoutNulls,
                          );
                        },
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                          ),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 20.0, 0.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Align(
                                  alignment: AlignmentDirectional(-1.0, 0.0),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        20.0, 20.0, 0.0, 10.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Container(
                                          width: 60.0,
                                          height: 60.0,
                                          clipBehavior: Clip.antiAlias,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                          ),
                                          child: Image.network(
                                            getJsonField(
                                              ClientHomePageGroup
                                                  .serviceDetailCall
                                                  .serviceDetail(
                                                (_model.detailsResponse
                                                        ?.jsonBody ??
                                                    ''),
                                              ),
                                              r'''$.gallery[0].url''',
                                            ).toString(),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  15.0, 0.0, 0.0, 0.0),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                getJsonField(
                                                  ClientHomePageGroup
                                                      .serviceDetailCall
                                                      .serviceDetail(
                                                    (_model.detailsResponse
                                                            ?.jsonBody ??
                                                        ''),
                                                  ),
                                                  r'''$.username''',
                                                ).toString(),
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily:
                                                              'primaryFont',
                                                          fontSize: 16.0,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                              ),
                                              Text(
                                                getJsonField(
                                                  ClientHomePageGroup
                                                      .serviceDetailCall
                                                      .serviceDetail(
                                                    (_model.detailsResponse
                                                            ?.jsonBody ??
                                                        ''),
                                                  ),
                                                  r'''$.title''',
                                                ).toString(),
                                                style: FlutterFlowTheme.of(
                                                        context)
                                                    .bodyMedium
                                                    .override(
                                                      fontFamily: 'primaryFont',
                                                      color: Color(0xFF898989),
                                                      fontSize: 12.0,
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
                                Icon(
                                  Icons.arrow_forward_ios,
                                  color: Color(0xFF898989),
                                  size: 24.0,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                        ),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              20.0, 22.0, 20.0, 0.0),
                          child: Builder(
                            builder: (context) {
                              final packageList =
                                  ClientHomePageGroup.serviceDetailCall
                                          .packageList(
                                            (_model.detailsResponse?.jsonBody ??
                                                ''),
                                          )
                                          ?.toList() ??
                                      [];

                              return SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  // Align items to start
                                  children: List.generate(packageList.length,
                                      (packageListIndex) {
                                    final packageListItem =
                                        packageList[packageListIndex];
                                    final isSelected = getJsonField(
                                            _model.selectedPackage,
                                            r'''$.id''') ==
                                        getJsonField(
                                            packageListItem, r'''$.id''');

                                    return Padding(
                                      padding:
                                          const EdgeInsets.only(right: 6.0),
                                      child: InkWell(
                                        splashColor: Colors.transparent,
                                        focusColor: Colors.transparent,
                                        hoverColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onTap: () async {
                                          _model.selectedPackage =
                                              packageListItem;
                                          safeSetState(() {});
                                        },
                                        child: LayoutBuilder(
                                          builder: (context, constraints) {
                                            double screenWidth =
                                                MediaQuery.of(context)
                                                    .size
                                                    .width;
                                            double itemWidth =
                                                screenWidth * 0.3;

                                            return ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(12.0),
                                              child: Container(
                                                width: itemWidth,
                                                height: 80.0,
                                                decoration: BoxDecoration(
                                                  color: isSelected
                                                      ? Color(0xFF6E2A87)
                                                      : Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12.0),
                                                  border: Border.all(
                                                    color: Color(0xFFD0B7EC),
                                                  ),
                                                ),
                                                child: Center(
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 10.0),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Flexible(
                                                          child: Text(
                                                            valueOrDefault<
                                                                String>(
                                                              getJsonField(
                                                                      packageListItem,
                                                                      r'''$.price''')
                                                                  ?.toString(),
                                                              'N/A',
                                                            ),
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            maxLines: 1,
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyMedium
                                                                .override(
                                                                  font:
                                                                      GoogleFonts
                                                                          .rubik(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontStyle,
                                                                  ),
                                                                  color: isSelected
                                                                      ? Colors
                                                                          .white
                                                                      : Color(
                                                                          0xFF181818),
                                                                  fontSize:
                                                                      16.0,
                                                                ),
                                                          ),
                                                        ),
                                                        SizedBox(height: 4),
                                                        Flexible(
                                                          child: Text(
                                                            valueOrDefault<
                                                                String>(
                                                              getJsonField(
                                                                      packageListItem,
                                                                      r'''$.title''')
                                                                  ?.toString(),
                                                              'N/A',
                                                            ),
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            maxLines: 1,
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'primaryFont',
                                                                  color: isSelected
                                                                      ? Colors
                                                                          .white
                                                                      : Color(
                                                                          0xFF181818),
                                                                  fontSize:
                                                                      13.0,
                                                                ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    );
                                  }),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      if (_model.selectedPackage != null)
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              20.0, 0.0, 20.0, 0.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 20.0, 0.0, 0.0),
                                child: Text(
                                  getJsonField(
                                    _model.selectedPackage,
                                    r'''$.title''',
                                  ).toString(),
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'primaryFont',
                                        color: FlutterFlowTheme.of(context)
                                            .primaryText,
                                        fontSize: 15.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    FFLocalizations.of(context).getText(
                                        'ghyim16e' /* Delivery time */),
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          font: GoogleFonts.inter(
                                            fontWeight: FontWeight.bold,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontStyle,
                                          ),
                                          fontSize: 14.0,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.bold,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontStyle,
                                        ),
                                  ),
                                  Text(
                                    getJsonField(
                                      _model.selectedPackage,
                                      r'''$.delivery_time''',
                                    ).toString(),
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'primaryFont',
                                          fontSize: 14.0,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 16.0, 0.0, 0.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      FFLocalizations.of(context)
                                          .getText('yhvq829g' /* Revisions */),
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            font: GoogleFonts.inter(
                                              fontWeight: FontWeight.bold,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontStyle,
                                            ),
                                            fontSize: 14.0,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.bold,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontStyle,
                                          ),
                                    ),
                                    Text(
                                      getJsonField(
                                        _model.selectedPackage,
                                        r'''$.number_of_revisions''',
                                      ).toString(),
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'primaryFont',
                                            fontSize: 14.0,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                              Divider(
                                thickness: 1.0,
                                color: FlutterFlowTheme.of(context).alternate,
                              ),
                              Builder(
                                builder: (context) {
                                  final featureList = getJsonField(
                                    _model.selectedPackage,
                                    r'''$.features''',
                                  ).toList();

                                  return ListView.separated(
                                    padding: EdgeInsets.zero,
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    scrollDirection: Axis.vertical,
                                    itemCount: featureList.length,
                                    separatorBuilder: (_, __) =>
                                        SizedBox(height: 6.0),
                                    itemBuilder: (context, featureListIndex) {
                                      final featureListItem =
                                          featureList[featureListIndex];
                                      return Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            getJsonField(
                                              featureListItem,
                                              r'''$.title''',
                                            ).toString(),
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily: 'primaryFont',
                                                  color: Color(0xFF252525),
                                                  fontSize: 14.0,
                                                  letterSpacing: 0.0,
                                                ),
                                          ),
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            child: Image.asset(
                                              'assets/images/Icon_(1).png',
                                              width: 13.0,
                                              height: 12.0,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 40.0, 0.0, 0.0),
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
                                      if (_model.selectedPackage != null) {
                                        context.pushNamed(
                                          CreateOrderWidget.routeName,
                                          queryParameters: {
                                            'serviceId': serializeParam(
                                              widget.serviceId,
                                              ParamType.String,
                                            ),
                                            'packageId': serializeParam(
                                              getJsonField(
                                                _model.selectedPackage,
                                                r'''$.id''',
                                              ).toString(),
                                              ParamType.String,
                                            ),
                                            'price': serializeParam(
                                              getJsonField(
                                                _model.selectedPackage,
                                                r'''$.price''',
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
                                              'Please select package',
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                            duration:
                                                Duration(milliseconds: 4000),
                                            backgroundColor: Color(0xFF6E2A87),
                                          ),
                                        );
                                      }
                                    },
                                    text: FFLocalizations.of(context)
                                        .getText('a0l4dtf9' /* Continue */),
                                    icon: Icon(
                                      Icons.arrow_forward,
                                      size: 15.0,
                                    ),
                                    options: FFButtonOptions(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          16.0, 0.0, 16.0, 0.0),
                                      iconAlignment: IconAlignment.end,
                                      iconPadding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              0.0, 0.0, 0.0, 0.0),
                                      color: Color(0x004B39EF),
                                      textStyle: FlutterFlowTheme.of(context)
                                          .titleSmall
                                          .override(
                                            font: GoogleFonts.interTight(
                                              fontWeight:
                                                  FlutterFlowTheme.of(context)
                                                      .titleSmall
                                                      .fontWeight,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
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
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      // Padding(
                      //   padding:
                      //       EdgeInsetsDirectional.fromSTEB(0.0, 22.0, 0.0, 0.0),
                      //   child: Container(
                      //     width: double.infinity,
                      //     height: 1.0,
                      //     decoration: BoxDecoration(
                      //       color: Color(0xFF898989),
                      //     ),
                      //   ),
                      // ),
                      Divider(),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            20.0, 16.0, 20.0, 0.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              getJsonField(
                                ClientHomePageGroup.serviceDetailCall
                                    .serviceDetail(
                                  (_model.detailsResponse?.jsonBody ?? ''),
                                ),
                                r'''$.title''',
                              ).toString(),
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'primaryFont',
                                    color: Color(0xFF252525),
                                    fontSize: 17.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            IconButton(
                              icon: Icon(
                                _isSaved == true
                                    ? Icons.bookmark
                                    : Icons.bookmark_border,
                                color: FlutterFlowTheme.of(context).primaryText,
                                size: 24.0,
                              ),
                              onPressed: _toggleBookmark,
                            ),
                          ],
                        ),
                      ),
                      Align(
                        alignment: AlignmentDirectional(-1.0, 0.0),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              20.0, 10.0, 0.0, 0.0),
                          child: Text(
                            getJsonField(
                              ClientHomePageGroup.serviceDetailCall
                                  .serviceDetail(
                                (_model.detailsResponse?.jsonBody ?? ''),
                              ),
                              r'''$.description''',
                            ).toString(),
                            textAlign: TextAlign.start,
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'primaryFont',
                                  color: Color(0xFF252525),
                                  fontSize: 12.0,
                                  letterSpacing: 0.0,
                                ),
                          ),
                        ),
                      ),
                      // Padding(
                      //   padding:
                      //       EdgeInsetsDirectional.fromSTEB(0.0, 22.0, 0.0, 0.0),
                      //   child: Container(
                      //     width: double.infinity,
                      //     height: 1.0,
                      //     decoration: BoxDecoration(
                      //       color: Color(0xFF898989),
                      //     ),
                      //   ),
                      // ),
                      Divider(),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            20.0, 16.0, 20.0, 0.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  FFLocalizations.of(context)
                                      .getText('h2ywztkp' /* Reviews */),
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'primaryFont',
                                        fontSize: 16.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => ViewAllReviewsPage(
                                          reviews:
                                              List<Map<String, dynamic>>.from(
                                            getJsonField(_serviceDetail,
                                                    r'''$.data.reviews''') ??
                                                [],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    FFLocalizations.of(context)
                                        .getText('gp1dky31' /* View all */),
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
                                          color: Color(0xFF898989),
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
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 12),
                            Builder(
                              builder: (context) {
                                final reviews = (getJsonField(_serviceDetail,
                                            r'''$.data.reviews''')
                                        as List<dynamic>? ??
                                    []);
                                if (reviews.isEmpty) {
                                  return Text('No reviews found',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium);
                                }
                                return
                                  ListView.separated(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: reviews.length,
                                  separatorBuilder: (_, __) =>
                                      SizedBox(height: 12),
                                  itemBuilder: (context, index) {
                                    final review = reviews[index];
                                    final userImageUrl = review['user_image']?['url']?.toString();
                                    return Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        ClipOval(
                                          child: userImageUrl != null && userImageUrl.isNotEmpty
                                              ? Image.network(
                                            userImageUrl,
                                            width: 32,
                                            height: 32,
                                            fit: BoxFit.cover,
                                            errorBuilder: (context, error, stackTrace) => Icon(
                                              Icons.account_circle,
                                              size: 32,
                                              color: Color(0xFF898989),
                                            ),
                                          )
                                              : Icon(
                                            Icons.account_circle,
                                            size: 32,
                                            color: Color(0xFF898989),
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                review['user']?.toString() ??
                                                    '',
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily:
                                                              'primaryFont',
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 14.0,
                                                        ),
                                              ),
                                              SizedBox(height: 2),
                                              RatingBarIndicator(
                                                rating: double.tryParse(
                                                        review['rate']
                                                                ?.toString() ??
                                                            '0') ??
                                                    0,
                                                itemBuilder: (context, _) =>
                                                    Icon(Icons.star_rounded,
                                                        color:
                                                            Color(0xFF181725)),
                                                itemCount: 5,
                                                itemSize: 20.0,
                                                unratedColor:
                                                    FlutterFlowTheme.of(context)
                                                        .accent1,
                                              ),
                                              SizedBox(height: 2),
                                              Text(
                                                review['comment']?.toString() ??
                                                    '',
                                                style: FlutterFlowTheme.of(
                                                        context)
                                                    .bodyMedium
                                                    .override(
                                                      fontFamily: 'primaryFont',
                                                      fontSize: 13.0,
                                                      color: Color(0xFF252525),
                                                    ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      // Padding(
                      //   padding:
                      //       EdgeInsetsDirectional.fromSTEB(0.0, 22.0, 0.0, 0.0),
                      //   child: Container(
                      //     width: double.infinity,
                      //     height: 1.0,
                      //     decoration: BoxDecoration(
                      //       color: Color(0xFF898989),
                      //     ),
                      //   ),
                      // ),
                      Divider(),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            20.0, 16.0, 20.0, 0.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              FFLocalizations.of(context)
                                  .getText('owlctk8d' /* FAQs */),
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'primaryFont',
                                    fontSize: 16.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            GestureDetector(
                              onTap: () {
                                final faqList =
                                    ClientHomePageGroup.serviceDetailCall
                                            .faqList(
                                              (_model.detailsResponse
                                                      ?.jsonBody ??
                                                  ''),
                                            )
                                            ?.toList() ??
                                        [];

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => FaqViewAllPage(
                                      faqList: List<Map<String, dynamic>>.from(
                                          faqList),
                                    ),
                                  ),
                                );
                              },
                              child: Text(
                                FFLocalizations.of(context)
                                    .getText('lxzvlmeb' /* View all */),
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
                                      color: Color(0xFF898989),
                                      letterSpacing: 0.0,
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            20.0, 20.0, 20.0, 0.0),
                        child: Builder(
                          builder: (context) {
                            final faqList =
                                ClientHomePageGroup.serviceDetailCall
                                        .faqList(
                                          (_model.detailsResponse?.jsonBody ??
                                              ''),
                                        )
                                        ?.toList() ??
                                    [];

                            return CollapsibleFaqList(
                              faqList: List<Map<String, dynamic>>.from(faqList),
                            );
                          },
                        ),
                      ),
                      // Padding(
                      //   padding:
                      //       EdgeInsetsDirectional.fromSTEB(0.0, 22.0, 0.0, 0.0),
                      //   child: Container(
                      //     width: double.infinity,
                      //     height: 1.0,
                      //     decoration: BoxDecoration(
                      //       color: Color(0xFF898989),
                      //     ),
                      //   ),
                      // ),
                      Divider(),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            20.0, 16.0, 20.0, 0.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              FFLocalizations.of(context)
                                  .getText('yxhsmzhc' /* My Portfolio */),
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'primaryFont',
                                    fontSize: 16.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            GestureDetector(
                              onTap: () {
                                final portfolioList =
                                    ClientHomePageGroup.serviceDetailCall
                                            .portFolioList(
                                              (_model.detailsResponse
                                                      ?.jsonBody ??
                                                  ''),
                                            )
                                            ?.toList() ??
                                        [];

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => PortfolioViewAllPage(
                                      portfolioList:
                                          List<Map<String, dynamic>>.from(
                                              portfolioList),
                                    ),
                                  ),
                                );
                              },
                              child: Text(
                                FFLocalizations.of(context)
                                    .getText('yum7tpzn' /* View all */),
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
                                      color: Color(0xFF898989),
                                      letterSpacing: 0.0,
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            20.0, 16.0, 20.0, 0.0),
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Color(0x00FFFFFF),
                          ),
                          child: Builder(
                            builder: (context) {
                              final prtFolioLst =
                                  ClientHomePageGroup.serviceDetailCall
                                          .portFolioList(
                                            (_model.detailsResponse?.jsonBody ??
                                                ''),
                                          )
                                          ?.toList() ??
                                      [];

                              return GridView.builder(
                                padding: EdgeInsets.zero,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 10.0,
                                  mainAxisSpacing: 10.0,
                                  childAspectRatio: 1.0,
                                ),
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: prtFolioLst.length,
                                itemBuilder: (context, prtFolioLstIndex) {
                                  final prtFolioLstItem =
                                      prtFolioLst[prtFolioLstIndex];
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) =>
                                              PortfolioGalleryDetailPageWidget(
                                            title:
                                                prtFolioLstItem['title'] ?? '',
                                            galleryUrls: (prtFolioLstItem[
                                                            'gallery']
                                                        as List<dynamic>? ??
                                                    [])
                                                .map((g) => g['url'] as String)
                                                .toList(),
                                          ),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      width: 100.0,
                                      height: 100.0,
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryBackground,
                                      ),
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        child: Image.network(
                                          getJsonField(
                                            prtFolioLstItem,
                                            r'''$.gallery[0].url''',
                                          ).toString(),
                                          width: 200.0,
                                          height: 200.0,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            20.0, 20.0, 20.0, 0.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              FFLocalizations.of(context).getText(
                                  'b158s3sb' /* Recommended services */),
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'primaryFont',
                                    color: Colors.black,
                                    fontSize: 16.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            GestureDetector(
                              onTap: () {
                                final recommendedList = (_model
                                            .detailsResponse?.jsonBody !=
                                        null)
                                    ? (getJsonField(
                                                _model.detailsResponse!.jsonBody,
                                                r'$.recommended')
                                            as List<dynamic>? ??
                                        [])
                                    : [];
                                print(
                                    "recommendedList>>${recommendedList.length}");
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => RecommendedViewAllPage(
                                      recommendedList:
                                          List<Map<String, dynamic>>.from(
                                              recommendedList),
                                    ),
                                  ),
                                );
                              },
                              child: Text(
                                FFLocalizations.of(context)
                                    .getText('kbsotbtj' /* View all */),
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'primaryFont',
                                      color: Color(0xFF898989),
                                      letterSpacing: 0.0,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            20.0, 20.0, 20.0, 0.0),
                        child: Builder(
                          builder: (context) {
                            final recommendedList = (_model
                                        .detailsResponse?.jsonBody !=
                                    null)
                                ? (getJsonField(
                                        _model.detailsResponse!.jsonBody,
                                        r'$.recommended') as List<dynamic>? ??
                                    [])
                                : [];
                            if (recommendedList.isEmpty) {
                              return NoDataFoundWidget(title: 'No Data Found');
                            }
                            return SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: List.generate(recommendedList.length,
                                    (index) {
                                  final item = recommendedList[index];
                                  return Container(
                                    width: 160,
                                    margin: EdgeInsets.only(right: 15),
                                    decoration: BoxDecoration(
                                      color: Color(0xFFE9E9E9),
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.vertical(
                                              top: Radius.circular(16)),
                                          child: FadeInImage.assetNetwork(
                                            placeholder:
                                                'assets/images/Rectangle_202.png',
                                            image: (item['gallery'] as List)
                                                    .isNotEmpty
                                                ? item['gallery'][0]['url'] ??
                                                    ''
                                                : 'assets/images/Rectangle_202.png',
                                            height: 90,
                                            width: double.infinity,
                                            fit: BoxFit.cover,
                                            imageErrorBuilder: (_, __, ___) =>
                                                Icon(Icons.broken_image,
                                                    size: 90),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            item['title'] ?? '',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily: 'primaryFont',
                                                  color: Color(0xFF252525),
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0),
                                          child: Text(
                                            item['description'] ?? '',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily: 'primaryFont',
                                                  color: Color(0xFF252525),
                                                  fontSize: 10,
                                                ),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Start From ${item['start_from'] ?? 'N/A'}',
                                                style: FlutterFlowTheme.of(
                                                        context)
                                                    .bodyMedium
                                                    .override(
                                                      fontFamily: 'primaryFont',
                                                      color: Color(0xFF898989),
                                                      fontSize: 8,
                                                    ),
                                              ),
                                              Row(
                                                children: [
                                                  Icon(Icons.star,
                                                      color: Color(0xFFFFCF26),
                                                      size: 12),
                                                  SizedBox(width: 2),
                                                  Text(
                                                    item['average_reviews']
                                                        .toString(),
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily:
                                                              'primaryFont',
                                                          fontSize: 10,
                                                        ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                              ),
                            );
                          },
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
