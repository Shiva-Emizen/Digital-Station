import 'dart:async';

import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:shimmer/shimmer.dart';

import '/backend/api_requests/api_calls.dart';
import '/components/no_data_found_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart'
    as smooth_page_indicator;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'RecentlyViewedPageWidget.dart';
import 'home_page_model.dart';
export 'home_page_model.dart';

class HomePageWidget extends StatefulWidget {
  final String? fromWorkInfo;

  const HomePageWidget({super.key, this.fromWorkInfo});

  static String routeName = 'HomePage';
  static String routePath = '/homePage';

  @override
  State<HomePageWidget> createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  late HomePageModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  late Future<Map<String, ApiCallResponse>> _allDataFuture;
  List<dynamic> _sliderList = [];
  Timer? _sliderTimer;
  bool _isFromWorkInfo = false;

  bool get isFromWorkInfo {
    // First check widget parameter
    if (widget.fromWorkInfo == 'true') return true;

    // Then check route query parameters
    final route = ModalRoute.of(context);
    if (route?.settings.arguments is Map) {
      final args = route!.settings.arguments as Map;
      return args['fromWorkInfo'] == 'true';
    }

    // Check for query parameters in the current route
    final uri = GoRouterState.of(context).uri;
    return uri.queryParameters['fromWorkInfo'] == 'true';
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Check route parameters here where it's safe to access inherited widgets
    try {
      final uri = GoRouterState.of(context).uri;
      if (uri.queryParameters['fromWorkInfo'] == 'true') {
        setState(() {
          _isFromWorkInfo = true;
        });
      }
    } catch (e) {
      print("Error accessing GoRouterState: $e");
    }
  }

  @override
  void initState() {
    super.initState();

    // Only check widget parameter in initState
    _isFromWorkInfo = widget.fromWorkInfo == 'true';

    print("sddfdfdf${widget.fromWorkInfo}");
    print("fromWorkInfo value: $_isFromWorkInfo");

    _model = createModel(context, () => HomePageModel());
    _model.textController ??= TextEditingController();
    _model.textFieldFocusNode ??= FocusNode();
    _allDataFuture = _fetchAllData();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startSliderAutoScroll();
    });

    print("apitoken===>${FFAppState().apitoken}");
  }

  void _startSliderAutoScroll() {
    _sliderTimer?.cancel();
    _sliderTimer = Timer.periodic(Duration(seconds: 5), (timer) {
      final controller = _model.pageViewController;
      if (controller != null &&
          controller.hasClients &&
          _sliderList.isNotEmpty) {
        int nextPage = controller.page?.round() ?? 0;
        nextPage = (nextPage + 1) % _sliderList.length;
        controller.animateToPage(
          nextPage,
          duration: Duration(milliseconds: 400),
          curve: Curves.ease,
        );
      }
    });
  }

  Future<Map<String, ApiCallResponse>> _fetchAllData() async {
    final authToken = FFAppState().apitoken;
    final futures = await Future.wait([
      ClientHomePageGroup.clientProfileCall.call(authToken: authToken),
      ClientHomePageGroup.getSliderAPICall.call(authToken: authToken),
      ClientHomePageGroup.categoryCall.call(),
      ClientHomePageGroup.popularServiceCall.call(authToken: authToken),
      ClientHomePageGroup.recentServicesCall.call(authToken: authToken),
    ]);
    print('Recently Viewed API Response: ${futures[4].jsonBody}');

    return {
      'profile': futures[0],
      'slider': futures[1],
      'category': futures[2],
      'popular': futures[3],
      'recent': futures[4],
    };
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return FutureBuilder<Map<String, ApiCallResponse>>(
      future: _allDataFuture,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: Color(0xFFF1F4F8),
            body: Center(
              child: SizedBox(
                width: 50.0,
                height: 50.0,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Color(0xFF6E2A87),
                  ),
                ),
              ),
            ),
          );
        }
        final data = snapshot.data!;
        final homePageClientProfileResponse = data['profile']!;
        final pageViewGetSliderAPIResponse = data['slider']!;
        final rowCategoryResponse = data['category']!;
        final rowPopularServiceResponse = data['popular']!;
        final rowRecentServicesResponse = data['recent']!;

        final sliderList = ClientHomePageGroup.getSliderAPICall
                .sliderList(
                  pageViewGetSliderAPIResponse.jsonBody,
                )
                ?.toList() ??
            [];
        final popularList = ClientHomePageGroup.categoryCall
                .categoryList(
                  rowCategoryResponse.jsonBody,
                )
                ?.toList() ??
            [];
        final pupularList = ClientHomePageGroup.popularServiceCall
                .popularServiceList(
                  rowPopularServiceResponse.jsonBody,
                )
                ?.toList() ??
            [];
        final recentViewList = ClientHomePageGroup.recentServicesCall
                .recentViewList(
                  rowRecentServicesResponse.jsonBody,
                )
                ?.toList() ??
            [];

        // Update _sliderList for timer use
        if (_sliderList.length != sliderList.length) {
          _sliderList = sliderList;
        }

        return WillPopScope(
          onWillPop: () async => false,
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
              FocusManager.instance.primaryFocus?.unfocus();
            },
            child: Scaffold(
              key: scaffoldKey,
              backgroundColor: Color(0xFFF1F4F8),
              body: SafeArea(
                child: Stack(
                  children: [
                    Builder(
                      builder: (context) {
                        if (FFAppState().userType == '0') {
                          return Stack(
                            children: [
                              Align(
                                alignment: AlignmentDirectional(0.0, 0.0),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 245.0, 0.0, 0.0),
                                  child: SingleChildScrollView(
                                    child: LayoutBuilder(
                                      builder: (context, constraints) {
                                        final isWide =
                                            constraints.maxWidth > 600;
                                        return Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            // Slider Section
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      0.0, 30.0, 0.0, 0.0),
                                              child: Column(
                                                children: [
                                                  Container(
                                                    height:
                                                        isWide ? 220.0 : 146.0,
                                                    // Use your previous height
                                                    child: PageView.builder(
                                                      controller: _model
                                                              .pageViewController ??=
                                                          PageController(
                                                              initialPage: 0),
                                                      itemCount:
                                                          sliderList.length,
                                                      itemBuilder: (context,
                                                          sliderListIndex) {
                                                        final sliderListItem =
                                                            sliderList[
                                                                sliderListIndex];
                                                        final imageUrl = getJsonField(
                                                                sliderListItem,
                                                                r'''$.image.url''')
                                                            .toString();
                                                        return Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      isWide
                                                                          ? 40.0
                                                                          : 20.0),
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8.0),
                                                            child:
                                                                Image.network(
                                                              imageUrl,
                                                              width: double
                                                                  .infinity,
                                                              height: isWide
                                                                  ? 220.0
                                                                  : 146.0,
                                                              fit: BoxFit.cover,
                                                              errorBuilder:
                                                                  (context,
                                                                      error,
                                                                      stackTrace) {
                                                                return Image
                                                                    .asset(
                                                                  'assets/images/placeholder.png',
                                                                  width: double
                                                                      .infinity,
                                                                  height: isWide
                                                                      ? 220.0
                                                                      : 146.0,
                                                                  fit: BoxFit
                                                                      .cover,
                                                                );
                                                              },
                                                              loadingBuilder:
                                                                  (context,
                                                                      child,
                                                                      loadingProgress) {
                                                                if (loadingProgress ==
                                                                    null)
                                                                  return child;
                                                                return Shimmer
                                                                    .fromColors(
                                                                  baseColor:
                                                                      Colors.grey[
                                                                          300]!,
                                                                  highlightColor:
                                                                      Colors.grey[
                                                                          100]!,
                                                                  child:
                                                                      Container(
                                                                    width: double
                                                                        .infinity,
                                                                    height: isWide
                                                                        ? 220.0
                                                                        : 146.0,
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                );
                                                              },
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                  SizedBox(height: 12.0),
                                                  smooth_page_indicator
                                                      .SmoothPageIndicator(
                                                    controller: _model
                                                            .pageViewController ??
                                                        PageController(
                                                            initialPage: 0),
                                                    count: sliderList.length,
                                                    effect: smooth_page_indicator
                                                        .ExpandingDotsEffect(
                                                      expansionFactor: 3,
                                                      spacing: 8.0,
                                                      radius: 16.0,
                                                      dotWidth: 8.0,
                                                      dotHeight: 8.0,
                                                      dotColor:
                                                          Color(0xFFBDBDBD),
                                                      activeDotColor:
                                                          Color(0xFF6E2A87),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            // DS Categories Section
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      20.0, 20.0, 20.0, 0.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      FFLocalizations.of(
                                                              context)
                                                          .getText(
                                                              'g0hx8vrw' /* DS Categories */),
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyMedium
                                                          .override(
                                                            fontFamily:
                                                                'primaryFont',
                                                            color: Colors.black,
                                                            fontSize: isWide
                                                                ? 20.0
                                                                : 16.0,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                  InkWell(
                                                    onTap: () =>
                                                        context.pushNamed(
                                                            CategoryPageWidget
                                                                .routeName),
                                                    child: Text(
                                                      FFLocalizations.of(
                                                              context)
                                                          .getText(
                                                              'jvoomwde' /* View all */),
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium
                                                              .override(
                                                                fontFamily:
                                                                    'primaryFont',
                                                                color: Color(
                                                                    0xFF898989),
                                                              ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      20.0, 20.0, 20.0, 0.0),
                                              child: popularList.isEmpty
                                                  ? NoDataFoundWidget(
                                                      title: 'No data Found')
                                                  : SizedBox(
                                                      height: isWide
                                                          ? 220.0
                                                          : 188.0,
                                                      child: ListView.separated(
                                                        scrollDirection:
                                                            Axis.horizontal,
                                                        itemCount:
                                                            popularList.length,
                                                        separatorBuilder:
                                                            (_, __) => SizedBox(
                                                                width: 10.0),
                                                        itemBuilder:
                                                            (context, index) {
                                                          final categoryListItem =
                                                              popularList[
                                                                  index];
                                                          final imageUrl = getJsonField(
                                                                  categoryListItem,
                                                                  r'''$.image.url''')
                                                              .toString();
                                                          return InkWell(
                                                            onTap: () {
                                                              context.pushNamed(
                                                                SubCategoryWidget
                                                                    .routeName,
                                                                queryParameters:
                                                                    {
                                                                  'categoryName':
                                                                      serializeParam(
                                                                    getJsonField(
                                                                            categoryListItem,
                                                                            r'''$.name''')
                                                                        .toString(),
                                                                    ParamType
                                                                        .String,
                                                                  ),
                                                                  'categoryId':
                                                                      serializeParam(
                                                                    getJsonField(
                                                                            categoryListItem,
                                                                            r'''$.id''')
                                                                        .toString(),
                                                                    ParamType
                                                                        .String,
                                                                  ),
                                                                }.withoutNulls,
                                                              );
                                                            },
                                                            child: Container(
                                                              width: isWide
                                                                  ? 200.0
                                                                  : 160.0,
                                                              height: isWide
                                                                  ? 220.0
                                                                  : 188.0,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Colors
                                                                    .white,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            16.0),
                                                              ),
                                                              child: Padding(
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                  horizontal:
                                                                      isWide
                                                                          ? 40.0
                                                                          : 30.0,
                                                                  vertical:
                                                                      isWide
                                                                          ? 35.0
                                                                          : 25.0,
                                                                ),
                                                                child: Column(
                                                                  children: [
                                                                    Container(
                                                                      width: isWide
                                                                          ? 80.0
                                                                          : 60.0,
                                                                      height: isWide
                                                                          ? 80.0
                                                                          : 60.0,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        shape: BoxShape
                                                                            .circle,
                                                                        image: imageUrl.isNotEmpty
                                                                            ? DecorationImage(
                                                                                image: NetworkImage(imageUrl),
                                                                                fit: BoxFit.cover,
                                                                              )
                                                                            : null,
                                                                      ),
                                                                      child: imageUrl
                                                                              .isEmpty
                                                                          ? ClipOval(
                                                                              child: Image.asset(
                                                                                'assets/images/placeholder.png',
                                                                                width: isWide ? 80.0 : 60.0,
                                                                                height: isWide ? 80.0 : 60.0,
                                                                                fit: BoxFit.cover,
                                                                              ),
                                                                            )
                                                                          : ClipOval(
                                                                              child: Image.network(
                                                                                imageUrl,
                                                                                width: isWide ? 80.0 : 60.0,
                                                                                height: isWide ? 80.0 : 60.0,
                                                                                fit: BoxFit.cover,
                                                                                errorBuilder: (context, error, stackTrace) {
                                                                                  return Image.asset(
                                                                                    'assets/images/placeholder.png',
                                                                                    width: isWide ? 80.0 : 60.0,
                                                                                    height: isWide ? 80.0 : 60.0,
                                                                                    fit: BoxFit.cover,
                                                                                  );
                                                                                },
                                                                                loadingBuilder: (context, child, loadingProgress) {
                                                                                  if (loadingProgress == null) return child;
                                                                                  return Shimmer.fromColors(
                                                                                    baseColor: Colors.grey[300]!,
                                                                                    highlightColor: Colors.grey[100]!,
                                                                                    child: Container(
                                                                                      width: isWide ? 80.0 : 60.0,
                                                                                      height: isWide ? 80.0 : 60.0,
                                                                                      decoration: BoxDecoration(
                                                                                        shape: BoxShape.circle,
                                                                                        color: Colors.white,
                                                                                      ),
                                                                                    ),
                                                                                  );
                                                                                },
                                                                              ),
                                                                            ),
                                                                    ),
                                                                    SizedBox(
                                                                        height: isWide
                                                                            ? 20.0
                                                                            : 14.0),
                                                                    Text(
                                                                      valueOrDefault<
                                                                          String>(
                                                                        getJsonField(categoryListItem,
                                                                                r'''$.name''')
                                                                            ?.toString(),
                                                                        'N/A',
                                                                      ),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      maxLines:
                                                                          2,
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .override(
                                                                            fontFamily:
                                                                                'primaryFont',
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                          ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                    ),
                                            ),
                                            // Popular Services Section
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      20.0, 20.0, 20.0, 0.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      FFLocalizations.of(
                                                              context)
                                                          .getText(
                                                              'laukp26z' /* Popular Services */),
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyMedium
                                                          .override(
                                                            fontFamily:
                                                                'primaryFont',
                                                            color: Colors.black,
                                                            fontSize: isWide
                                                                ? 20.0
                                                                : 16.0,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                  InkWell(
                                                    onTap: () =>
                                                        context.pushNamed(
                                                            ViewAllPageWidget
                                                                .routeName),
                                                    child: Text(
                                                      FFLocalizations.of(
                                                              context)
                                                          .getText(
                                                              'd2skxp94' /* View all */),
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium
                                                              .override(
                                                                fontFamily:
                                                                    'primaryFont',
                                                                color: Color(
                                                                    0xFF898989),
                                                              ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      20.0, 20.0, 20.0, 0.0),
                                              child: pupularList.isEmpty
                                                  ? NoDataFoundWidget(
                                                      title: 'No Data Found')
                                                  : SizedBox(
                                                      height: isWide
                                                          ? 220.0
                                                          : 190.0,
                                                      child: ListView.separated(
                                                        scrollDirection:
                                                            Axis.horizontal,
                                                        itemCount:
                                                            pupularList.length,
                                                        separatorBuilder:
                                                            (_, __) => SizedBox(
                                                                width: 14.0),
                                                        itemBuilder:
                                                            (context, index) {
                                                          final pupularListItem =
                                                              pupularList[
                                                                  index];
                                                          final imageUrl =
                                                              valueOrDefault<
                                                                  String>(
                                                            getJsonField(
                                                                    pupularListItem,
                                                                    r'''$.gallery[0].url''')
                                                                ?.toString(),
                                                            'https://cdn-icons-png.flaticon.com/128/739/739249.png',
                                                          );
                                                          return InkWell(
                                                            onTap: () {
                                                              context.pushNamed(
                                                                ServiceDetailPageWidget
                                                                    .routeName,
                                                                queryParameters:
                                                                    {
                                                                  'serviceId':
                                                                      serializeParam(
                                                                    getJsonField(
                                                                            pupularListItem,
                                                                            r'''$.id''')
                                                                        .toString(),
                                                                    ParamType
                                                                        .String,
                                                                  ),
                                                                }.withoutNulls,
                                                              );
                                                            },
                                                            child: Material(
                                                              color: Colors
                                                                  .transparent,
                                                              shape:
                                                                  RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            12.0),
                                                              ),
                                                              child: ClipRRect(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            12.0),
                                                                child:
                                                                    Container(
                                                                  width: isWide
                                                                      ? 190.0
                                                                      : 150.0,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: Colors
                                                                        .white,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            12.0),
                                                                  ),
                                                                  child: Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      ClipRRect(
                                                                        borderRadius:
                                                                            BorderRadius.only(
                                                                          topLeft:
                                                                              Radius.circular(12.0),
                                                                          topRight:
                                                                              Radius.circular(12.0),
                                                                        ),
                                                                        child: Image
                                                                            .network(
                                                                          imageUrl,
                                                                          width:
                                                                              double.infinity,
                                                                          height: isWide
                                                                              ? 110.0
                                                                              : 90.0,
                                                                          // Increased image height
                                                                          fit: BoxFit
                                                                              .cover,
                                                                        ),
                                                                      ),
                                                                      Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            6.0,
                                                                            0.0,
                                                                            6.0,
                                                                            0.0),
                                                                        child:
                                                                            Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.spaceBetween,
                                                                          children: [
                                                                            Flexible(
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
                                                                                  SizedBox(width: 2),
                                                                                  Expanded(
                                                                                    child: Text(
                                                                                      valueOrDefault<String>(
                                                                                        getJsonField(pupularListItem, r'''$.username''')?.toString(),
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
                                                                                ],
                                                                              ),
                                                                            ),
                                                                            InkWell(
                                                                              splashColor: Colors.transparent,
                                                                              focusColor: Colors.transparent,
                                                                              hoverColor: Colors.transparent,
                                                                              highlightColor: Colors.transparent,
                                                                              onTap: () async {
                                                                                final serviceId = getJsonField(pupularListItem, r'''$.id''').toString();
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
                                                                                  setState(() {
                                                                                    _allDataFuture = _fetchAllData();
                                                                                  });
                                                                                }
                                                                              },
                                                                              child: Icon(
                                                                                getJsonField(pupularListItem, r'''$.isSaved''') ? Icons.bookmark : Icons.bookmark_border,
                                                                                color: FlutterFlowTheme.of(context).primaryText,
                                                                                size: 24.0,
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                      Expanded(
                                                                        child:
                                                                            Padding(
                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                              6.0,
                                                                              6.0,
                                                                              6.0,
                                                                              0.0),
                                                                          child:
                                                                              Text(
                                                                            valueOrDefault<String>(
                                                                              getJsonField(pupularListItem, r'''$.title''')?.toString(),
                                                                              'N/A',
                                                                            ),
                                                                            maxLines:
                                                                                2,
                                                                            // Show ... after 2 lines
                                                                            overflow:
                                                                                TextOverflow.ellipsis,
                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                  fontFamily: 'primaryFont',
                                                                                  fontSize: 13.0,
                                                                                  letterSpacing: 0.0,
                                                                                  fontWeight: FontWeight.bold,
                                                                                ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            6.0,
                                                                            6.0,
                                                                            6.0,
                                                                            6.0),
                                                                        child:
                                                                            Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.spaceBetween,
                                                                          children: [
                                                                            Expanded(
                                                                              child: Text(
                                                                                'Start From \$${valueOrDefault<String>(
                                                                                  getJsonField(pupularListItem, r'''$.start_from''')?.toString(),
                                                                                  'N/A',
                                                                                )}',
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
                                                                            Row(
                                                                              children: [
                                                                                Icon(
                                                                                  Icons.star,
                                                                                  color: Color(0xFFFFCF26),
                                                                                  size: 16.0,
                                                                                ),
                                                                                SizedBox(width: 2),
                                                                                Text(
                                                                                  valueOrDefault<String>(
                                                                                    getJsonField(pupularListItem, r'''$.average_reviews''')?.toString(),
                                                                                    'N/A',
                                                                                  ),
                                                                                  maxLines: 1,
                                                                                  overflow: TextOverflow.ellipsis,
                                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                        fontFamily: 'primaryFont',
                                                                                        fontSize: 12.0,
                                                                                        letterSpacing: 0.0,
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
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                    ),
                                            ),
                                            // Recently Viewed Section
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      20.0, 20.0, 20.0, 0.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      FFLocalizations.of(
                                                              context)
                                                          .getText(
                                                              'wn65sjss' /* Recently viewed */),
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyMedium
                                                          .override(
                                                            fontFamily:
                                                                'primaryFont',
                                                            color: Colors.black,
                                                            fontSize: isWide
                                                                ? 20.0
                                                                : 16.0,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (_) =>
                                                              RecentlyViewedPageWidget(
                                                            recentViewList: List<
                                                                    Map<String,
                                                                        dynamic>>.from(
                                                                recentViewList),
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                    child: Text(
                                                      FFLocalizations.of(
                                                              context)
                                                          .getText(
                                                              'tv53vz82' /* View all */),
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium
                                                              .override(
                                                                fontFamily:
                                                                    'primaryFont',
                                                                color: Color(
                                                                    0xFF898989),
                                                              ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      20.0, 20.0, 20.0, 0.0),
                                              child: recentViewList.isEmpty
                                                  ? NoDataFoundWidget(
                                                      title: 'No Data Found')
                                                  : SizedBox(
                                                      height: isWide
                                                          ? 220.0
                                                          : 190.0,
                                                      child: ListView.separated(
                                                        scrollDirection:
                                                            Axis.horizontal,
                                                        itemCount:
                                                            recentViewList
                                                                .length,
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 0),
                                                        physics:
                                                            BouncingScrollPhysics(),
                                                        shrinkWrap: true,
                                                        separatorBuilder:
                                                            (_, __) => SizedBox(
                                                                width: 14.0),
                                                        itemBuilder:
                                                            (context, index) {
                                                          bool _isProcessing =
                                                              false;
                                                          final recentViewListItem =
                                                              recentViewList[
                                                                  index];
                                                          final imageUrl = getJsonField(
                                                                      recentViewListItem,
                                                                      r'''$.gallery[0].url''')
                                                                  ?.toString() ??
                                                              '';
                                                          return InkWell(
                                                            onTap: () {
                                                              context.pushNamed(
                                                                ServiceDetailPageWidget
                                                                    .routeName,
                                                                queryParameters:
                                                                    {
                                                                  'serviceId':
                                                                      serializeParam(
                                                                    getJsonField(
                                                                            recentViewListItem,
                                                                            r'''$.id''')
                                                                        .toString(),
                                                                    ParamType
                                                                        .String,
                                                                  ),
                                                                }.withoutNulls,
                                                              );
                                                            },
                                                            child: Material(
                                                              color: Colors
                                                                  .transparent,
                                                              shape:
                                                                  RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            16.0),
                                                              ),
                                                              child: ClipRRect(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            16.0),
                                                                child:
                                                                    Container(
                                                                  width: isWide
                                                                      ? 190.0
                                                                      : 150.0,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: Color(
                                                                        0xFFFFFFFF),
                                                                    // Match Popular Services
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            16.0),
                                                                  ),
                                                                  child: Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      ClipRRect(
                                                                        borderRadius:
                                                                            BorderRadius.only(
                                                                          topLeft:
                                                                              Radius.circular(16.0),
                                                                          topRight:
                                                                              Radius.circular(16.0),
                                                                        ),
                                                                        child: Image
                                                                            .network(
                                                                          imageUrl.isNotEmpty
                                                                              ? imageUrl
                                                                              : 'https://cdn-icons-png.flaticon.com/128/739/739249.png',
                                                                          fit: BoxFit
                                                                              .cover,
                                                                          width:
                                                                              double.infinity,
                                                                          height: isWide
                                                                              ? 110.0
                                                                              : 90.0,
                                                                          errorBuilder: (context,
                                                                              error,
                                                                              stackTrace) {
                                                                            return Image.asset(
                                                                              'assets/images/Rectangle_202.png',
                                                                              fit: BoxFit.cover,
                                                                              width: double.infinity,
                                                                              height: isWide ? 110.0 : 90.0,
                                                                            );
                                                                          },
                                                                          loadingBuilder: (context,
                                                                              child,
                                                                              loadingProgress) {
                                                                            if (loadingProgress ==
                                                                                null)
                                                                              return child;
                                                                            return Shimmer.fromColors(
                                                                              baseColor: Colors.grey[300]!,
                                                                              highlightColor: Colors.grey[100]!,
                                                                              child: Container(
                                                                                width: double.infinity,
                                                                                height: isWide ? 110.0 : 90.0,
                                                                                color: Colors.white,
                                                                              ),
                                                                            );
                                                                          },
                                                                        ),
                                                                      ),
                                                                      Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            6.0,
                                                                            0.0,
                                                                            6.0,
                                                                            0.0),
                                                                        child:
                                                                            Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.spaceBetween,
                                                                          children: [
                                                                            Flexible(
                                                                              child: Row(
                                                                                children: [
                                                                                  ClipRRect(
                                                                                    borderRadius: BorderRadius.circular(8.0),
                                                                                    child: Image.asset(
                                                                                      'assets/images/Icon_(Stroke).png',
                                                                                      width: 13.0,
                                                                                      height: 13.0,
                                                                                      fit: BoxFit.cover,
                                                                                    ),
                                                                                  ),
                                                                                  SizedBox(width: 2),
                                                                                  Expanded(
                                                                                    child: Text(
                                                                                      valueOrDefault<String>(
                                                                                        getJsonField(recentViewListItem, r'''$.username''')?.toString(),
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
                                                                                ],
                                                                              ),
                                                                            ),
                                                                            InkWell(
                                                                              splashColor: Colors.transparent,
                                                                              focusColor: Colors.transparent,
                                                                              hoverColor: Colors.transparent,
                                                                              highlightColor: Colors.transparent,
                                                                              onTap: _isProcessing
                                                                                  ? null
                                                                                  : () async {
                                                                                      setState(() {
                                                                                        _isProcessing = true;
                                                                                      });
                                                                                      final serviceId = getJsonField(recentViewListItem, r'''$.id''').toString();
                                                                                      final isSaved = getJsonField(recentViewListItem, r'''$.isSaved''');
                                                                                      final response = await ClientHomePageGroup.addToFavouriteCall.call(
                                                                                        id: serviceId,
                                                                                        authToken: FFAppState().apitoken,
                                                                                      );
                                                                                      final apiMessage = getJsonField(response.jsonBody, r'''$.message''')?.toString() ?? 'No message';
                                                                                      if (response.succeeded) {
                                                                                        ScaffoldMessenger.of(context).showSnackBar(
                                                                                          SnackBar(
                                                                                            content: Text(apiMessage, style: TextStyle(color: Colors.white)),
                                                                                            backgroundColor: Color(0xFF6E2A87),
                                                                                          ),
                                                                                        );
                                                                                        setState(() {
                                                                                          _allDataFuture = _fetchAllData();
                                                                                        });
                                                                                      } else {
                                                                                        ScaffoldMessenger.of(context).showSnackBar(
                                                                                          SnackBar(
                                                                                            content: Text(apiMessage, style: TextStyle(color: Colors.white)),
                                                                                            backgroundColor: Color(0xFF6E2A87),
                                                                                          ),
                                                                                        );
                                                                                        setState(() {
                                                                                          _isProcessing = false;
                                                                                        });
                                                                                      }
                                                                                    },
                                                                              child: Icon(
                                                                                _isProcessing ? Icons.hourglass_top : (getJsonField(recentViewListItem, r'''$.isSaved''') ? Icons.bookmark : Icons.bookmark_border),
                                                                                color: FlutterFlowTheme.of(context).primaryText,
                                                                                size: 24.0,
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                      Expanded(
                                                                        child:
                                                                            Padding(
                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                              6.0,
                                                                              6.0,
                                                                              6.0,
                                                                              0.0),
                                                                          child:
                                                                              Text(
                                                                            valueOrDefault<String>(
                                                                              getJsonField(recentViewListItem, r'''$.title''')?.toString(),
                                                                              'N/A',
                                                                            ),
                                                                            maxLines:
                                                                                2,
                                                                            overflow:
                                                                                TextOverflow.ellipsis,
                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                  fontFamily: 'primaryFont',
                                                                                  color: Color(0xFF252525),
                                                                                  fontSize: 13.0,
                                                                                  // Match Popular Services
                                                                                  fontWeight: FontWeight.bold,
                                                                                  letterSpacing: 0.0,
                                                                                ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            6.0,
                                                                            6.0,
                                                                            6.0,
                                                                            6.0),
                                                                        child:
                                                                            Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.spaceBetween,
                                                                          children: [
                                                                            Expanded(
                                                                              child: Text(
                                                                                'Start From \$${valueOrDefault<String>(
                                                                                  getJsonField(recentViewListItem, r'''$.start_from''')?.toString(),
                                                                                  'N/A',
                                                                                )}',
                                                                                maxLines: 1,
                                                                                overflow: TextOverflow.ellipsis,
                                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                      fontFamily: 'primaryFont',
                                                                                      color: Color(0xFF898989),
                                                                                      fontSize: 10.0,
                                                                                      // Match Popular Services
                                                                                      letterSpacing: 0.0,
                                                                                    ),
                                                                              ),
                                                                            ),
                                                                            Row(
                                                                              children: [
                                                                                Icon(
                                                                                  Icons.star,
                                                                                  color: Color(0xFFFFCF26),
                                                                                  size: 16.0, // Match Popular Services
                                                                                ),
                                                                                SizedBox(width: 2),
                                                                                Text(
                                                                                  valueOrDefault<String>(
                                                                                    getJsonField(recentViewListItem, r'''$.average_reviews''')?.toString(),
                                                                                    'N/A',
                                                                                  ),
                                                                                  maxLines: 1,
                                                                                  overflow: TextOverflow.ellipsis,
                                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                        fontFamily: 'primaryFont',
                                                                                        fontSize: 12.0,
                                                                                        // Match Popular Services
                                                                                        letterSpacing: 0.0,
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
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                    ),
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(0.0),
                                child: Image.asset(
                                  'assets/images/Group_1597881521.png',
                                  width: double.infinity,
                                  height: 260.0,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Align(
                                alignment: AlignmentDirectional(0.0, 0.0),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 100.0, 0.0, 0.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            20.0, 0.0, 20.0, 0.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                InkWell(
                                                  splashColor:
                                                      Colors.transparent,
                                                  focusColor:
                                                      Colors.transparent,
                                                  hoverColor:
                                                      Colors.transparent,
                                                  highlightColor:
                                                      Colors.transparent,
                                                  onTap: () async {
                                                    context.pushNamed(
                                                        AccountPageWidget
                                                            .routeName);
                                                  },
                                                  child: Container(
                                                    width: 70.0,
                                                    height: 70.0,
                                                    clipBehavior:
                                                        Clip.antiAlias,
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: Colors.grey[300],
                                                    ),
                                                    child: Image.network(
                                                      valueOrDefault<String>(
                                                        getJsonField(
                                                          ClientHomePageGroup
                                                              .clientProfileCall
                                                              .clientDetails(
                                                            homePageClientProfileResponse
                                                                .jsonBody,
                                                          ),
                                                          r'''$.avatar.url''',
                                                        )?.toString(),
                                                        '',
                                                      ),
                                                      fit: BoxFit.cover,
                                                      errorBuilder: (context,
                                                          error, stackTrace) {
                                                        return Container(
                                                          width: 70.0,
                                                          height: 70.0,
                                                          decoration:
                                                              BoxDecoration(
                                                            shape:
                                                                BoxShape.circle,
                                                            color: Colors
                                                                .grey[300],
                                                          ),
                                                          child: Icon(
                                                            Icons.person,
                                                            size: 35.0,
                                                            color: Colors
                                                                .grey[600],
                                                          ),
                                                        );
                                                      },
                                                      loadingBuilder: (context,
                                                          child,
                                                          loadingProgress) {
                                                        if (loadingProgress ==
                                                            null) return child;
                                                        return Container(
                                                          width: 70.0,
                                                          height: 70.0,
                                                          decoration:
                                                              BoxDecoration(
                                                            shape:
                                                                BoxShape.circle,
                                                            color: Colors
                                                                .grey[300],
                                                          ),
                                                          child: Icon(
                                                            Icons.person,
                                                            size: 35.0,
                                                            color: Colors
                                                                .grey[600],
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                ),
                                                Align(
                                                  alignment:
                                                      AlignmentDirectional(
                                                          0.0, -1.0),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(12.0,
                                                                14.0, 0.0, 0.0),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        // Text(
                                                        //   FFLocalizations.of(
                                                        //           context)
                                                        //       .getText(
                                                        //     'en144zqw' /* Welcome Back */,
                                                        //   ),
                                                        //   style: FlutterFlowTheme
                                                        //           .of(context)
                                                        //       .bodyMedium
                                                        //       .override(
                                                        //         fontFamily:
                                                        //             'primaryFont',
                                                        //         color: Colors
                                                        //             .white,
                                                        //         fontSize: 12.0,
                                                        //         letterSpacing:
                                                        //             0.0,
                                                        //       ),
                                                        // ),
                                                        Text(
                                                          widget.fromWorkInfo ==
                                                                  "true"
                                                              ? 'Welcome'
                                                              : 'Welcome',
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyMedium
                                                              .override(
                                                                fontFamily:
                                                                    'primaryFont',
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 12.0,
                                                                letterSpacing:
                                                                    0.0,
                                                              ),
                                                        ),
                                                        Text(
                                                          valueOrDefault<
                                                              String>(
                                                            getJsonField(
                                                              ClientHomePageGroup
                                                                  .clientProfileCall
                                                                  .clientDetails(
                                                                homePageClientProfileResponse
                                                                    .jsonBody,
                                                              ),
                                                              r'''$.name''',
                                                            )?.toString(),
                                                            'N/A',
                                                          ),
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyMedium
                                                              .override(
                                                                fontFamily:
                                                                    'primaryFont',
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 16.0,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w900,
                                                              ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            InkWell(
                                              splashColor: Colors.transparent,
                                              focusColor: Colors.transparent,
                                              hoverColor: Colors.transparent,
                                              highlightColor:
                                                  Colors.transparent,
                                              onTap: () async {
                                                context.pushNamed(
                                                    NotificationPageWidget
                                                        .routeName);
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryBackground,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12.0),
                                                ),
                                                child: Padding(
                                                  padding: EdgeInsets.all(16.0),
                                                  child: Icon(
                                                    Icons.notifications_rounded,
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primaryText,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            20.0, 20.0, 20.0, 20.0),
                                        child: Container(
                                          width: double.infinity,
                                          child: TextFormField(
                                            controller: _model.textController,
                                            focusNode:
                                                _model.textFieldFocusNode,
                                            autofocus: false,
                                            obscureText: false,
                                            onTap: () {
                                              context.pushNamed(
                                                  AllServiceWidget.routeName);
                                            },
                                            decoration: InputDecoration(
                                              isDense: true,
                                              labelStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .labelMedium
                                                      .override(
                                                        font: GoogleFonts.inter(
                                                          fontWeight:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelMedium
                                                                  .fontWeight,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelMedium
                                                                  .fontStyle,
                                                        ),
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .labelMedium
                                                                .fontWeight,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .labelMedium
                                                                .fontStyle,
                                                      ),
                                              hintText:
                                                  FFLocalizations.of(context)
                                                      .getText(
                                                'r14e9dby' /* Search */,
                                              ),
                                              hintStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .labelMedium
                                                      .override(
                                                        font: GoogleFonts.inter(
                                                          fontWeight:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelMedium
                                                                  .fontWeight,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelMedium
                                                                  .fontStyle,
                                                        ),
                                                        color:
                                                            Color(0xFF64748B),
                                                        fontSize: 16.0,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .labelMedium
                                                                .fontWeight,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .labelMedium
                                                                .fontStyle,
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
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .error,
                                                  width: 1.0,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                              focusedErrorBorder:
                                                  OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .error,
                                                  width: 1.0,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                              filled: true,
                                              fillColor:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryBackground,
                                              prefixIcon: Icon(
                                                Icons.search_sharp,
                                              ),
                                            ),
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  font: GoogleFonts.inter(
                                                    fontWeight:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMedium
                                                            .fontWeight,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMedium
                                                            .fontStyle,
                                                  ),
                                                  letterSpacing: 0.0,
                                                  fontWeight:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontWeight,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontStyle,
                                                ),
                                            cursorColor:
                                                FlutterFlowTheme.of(context)
                                                    .primaryText,
                                            validator: _model
                                                .textControllerValidator
                                                .asValidator(context),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          );
                        } else {
                          final clientDetails = ClientHomePageGroup
                              .clientProfileCall
                              .clientDetails(
                                  homePageClientProfileResponse.jsonBody);
                          final portfolioList =
                              getJsonField(clientDetails, r'''$.portfolio''')
                                  as List<dynamic>?;
                          return Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(0.0),
                                child: Image.asset(
                                  'assets/images/Group_1597881521.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        20.0, 30.0, 20.0, 0.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            InkWell(
                                              splashColor: Colors.transparent,
                                              focusColor: Colors.transparent,
                                              hoverColor: Colors.transparent,
                                              highlightColor:
                                                  Colors.transparent,
                                              onTap: () async {
                                                context.pushNamed(
                                                    AccountPageWidget
                                                        .routeName);
                                              },
                                              child: Container(
                                                width: 70.0,
                                                height: 70.0,
                                                clipBehavior: Clip.antiAlias,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Colors.grey[300],
                                                ),
                                                child: Image.network(
                                                  valueOrDefault<String>(
                                                    getJsonField(
                                                      ClientHomePageGroup
                                                          .clientProfileCall
                                                          .clientDetails(
                                                        homePageClientProfileResponse
                                                            .jsonBody,
                                                      ),
                                                      r'''$.avatar.url''',
                                                    )?.toString(),
                                                    '',
                                                  ),
                                                  fit: BoxFit.cover,
                                                  errorBuilder: (context, error,
                                                      stackTrace) {
                                                    return Container(
                                                      width: 70.0,
                                                      height: 70.0,
                                                      decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color: Colors.grey[300],
                                                      ),
                                                      child: Icon(
                                                        Icons.person,
                                                        size: 35.0,
                                                        color: Colors.grey[600],
                                                      ),
                                                    );
                                                  },
                                                  loadingBuilder: (context,
                                                      child, loadingProgress) {
                                                    if (loadingProgress == null)
                                                      return child;
                                                    return Container(
                                                      width: 70.0,
                                                      height: 70.0,
                                                      decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color: Colors.grey[300],
                                                      ),
                                                      child: Icon(
                                                        Icons.person,
                                                        size: 35.0,
                                                        color: Colors.grey[600],
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),
                                            ),
                                            Align(
                                              alignment: AlignmentDirectional(
                                                  0.0, -1.0),
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        12.0, 14.0, 0.0, 0.0),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      widget.fromWorkInfo ==
                                                              "true"
                                                          ? 'Welcome'
                                                          : 'Welcome',
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyMedium
                                                          .override(
                                                            fontFamily:
                                                                'primaryFont',
                                                            color: Colors.white,
                                                            fontSize: 12.0,
                                                            letterSpacing: 0.0,
                                                          ),
                                                    ),
                                                    Text(
                                                      valueOrDefault<String>(
                                                        getJsonField(
                                                          ClientHomePageGroup
                                                              .clientProfileCall
                                                              .clientDetails(
                                                            homePageClientProfileResponse
                                                                .jsonBody,
                                                          ),
                                                          r'''$.name''',
                                                        )?.toString(),
                                                        'N/A',
                                                      ),
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyMedium
                                                          .override(
                                                            fontFamily:
                                                                'primaryFont',
                                                            color: Colors.white,
                                                            fontSize: 16.0,
                                                            letterSpacing: 0.0,
                                                            fontWeight:
                                                                FontWeight.w900,
                                                          ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        InkWell(
                                          splashColor: Colors.transparent,
                                          focusColor: Colors.transparent,
                                          hoverColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          onTap: () async {
                                            context.pushNamed(
                                                NotificationPageWidget
                                                    .routeName);
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryBackground,
                                              borderRadius:
                                                  BorderRadius.circular(12.0),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.all(16.0),
                                              child: Icon(
                                                Icons.notifications_rounded,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryText,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  if (portfolioList == null ||
                                      portfolioList.isEmpty)
                                    InkWell(
                                      onTap: () async {
                                        context.pushNamed(
                                            PortfolioPageWidget.routeName);
                                      },
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            20.0, 25.0, 20.0, 0.0),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          child: Image.asset(
                                            'assets/images/Profile_Notice.png',
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        20.0, 80.0, 20.0, 0.0),
                                    child: Container(
                                      width: double.infinity,
                                      height: 150.0,
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryBackground,
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            18.0, 0.0, 16.0, 18.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  valueOrDefault<String>(
                                                    getJsonField(
                                                      ClientHomePageGroup
                                                          .clientProfileCall
                                                          .clientDetails(
                                                        homePageClientProfileResponse
                                                            .jsonBody,
                                                      ),
                                                      r'''$.name''',
                                                    )?.toString(),
                                                    'N/A',
                                                  ),
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily:
                                                            'primaryFont',
                                                        color: Colors.white,
                                                        fontSize: 16.0,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.w900,
                                                      ),
                                                ),
                                                Text(
                                                  valueOrDefault<String>(
                                                    getJsonField(
                                                      ClientHomePageGroup
                                                          .clientProfileCall
                                                          .clientDetails(
                                                        homePageClientProfileResponse
                                                            .jsonBody,
                                                      ),
                                                      r'''$.completed_jobs''',
                                                    )?.toString(),
                                                    'N/A',
                                                  ),
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily:
                                                            'primaryFont',
                                                        fontSize: 50.0,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                ),
                                                Text(
                                                  FFLocalizations.of(context)
                                                      .getText(
                                                    '1v3zwolj' /* Completed Jobs */,
                                                  ),
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily:
                                                            'primaryFont',
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                ),
                                              ],
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      0.0, 14.0, 0.0, 0.0),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(0.0),
                                                child: Image.asset(
                                                  'assets/images/Icon_(Stroke)_(14).png',
                                                  width: 121.0,
                                                  height: 121.0,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          20.0, 20.0, 20.0, 0.0),
                                      child: GridView.builder(
                                        padding: EdgeInsets.zero,
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          crossAxisSpacing: 12.0,
                                          mainAxisSpacing: 12.0,
                                          childAspectRatio: 1.1,
                                        ),
                                        itemCount: 4,
                                        itemBuilder: (context, index) {
                                          final items = [
                                            {
                                              'icon':
                                                  'assets/images/Icon_(Stroke)_(15).png',
                                              'label': FFLocalizations.of(
                                                      context)
                                                  .getText(
                                                      'n2zd2q7c' /* My Orders */),
                                              'route':
                                                  OrderPageWidget.routeName,
                                              'iconWidth': 28.0,
                                              'iconHeight': 22.0,
                                            },
                                            {
                                              'icon':
                                                  'assets/images/Icon_(Stroke)_(21).png',
                                              'label': FFLocalizations.of(
                                                      context)
                                                  .getText(
                                                      'oj79jx8w' /* Services */),
                                              'route':
                                                  AllServiceWidget.routeName,
                                              'iconWidth': 32.0,
                                              'iconHeight': 32.0,
                                            },
                                            {
                                              'icon':
                                                  'assets/images/Icon_(Stroke)_(22).png',
                                              'label': FFLocalizations.of(
                                                      context)
                                                  .getText(
                                                      '2pfc6jye' /* Wallet */),
                                              'route':
                                                  WalletPageWidget.routeName,
                                              'iconWidth': 28.0,
                                              'iconHeight': 28.0,
                                            },
                                            {
                                              'icon':
                                                  'assets/images/Icon_(Stroke)_(18).png',
                                              'label': FFLocalizations.of(
                                                      context)
                                                  .getText(
                                                      'hwc5ij42' /* My Portfolio */),
                                              'route':
                                                  PortfolioPageWidget.routeName,
                                              'iconWidth': 30.0,
                                              'iconHeight': 26.0,
                                            },
                                          ];
                                          final item = items[index];
                                          return InkWell(
                                            splashColor: Colors.transparent,
                                            focusColor: Colors.transparent,
                                            hoverColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            onTap: () async {
                                              context.pushNamed(
                                                  item['route'] as String);
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryBackground,
                                                borderRadius:
                                                    BorderRadius.circular(12.0),
                                              ),
                                              child: Center(
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Image.asset(
                                                      item['icon'] as String,
                                                      width: item['iconWidth']
                                                          as double,
                                                      height: item['iconHeight']
                                                          as double,
                                                      fit: BoxFit.contain,
                                                    ),
                                                    SizedBox(height: 8),
                                                    Text(
                                                      item['label'] as String,
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyMedium
                                                          .override(
                                                            fontFamily:
                                                                'primaryFont',
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 13,
                                                            letterSpacing: 0.0,
                                                          ),
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
