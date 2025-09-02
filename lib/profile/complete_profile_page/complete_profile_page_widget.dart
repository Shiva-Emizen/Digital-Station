import '../../freelancer/portfolio_page/PortfolioGalleryDetailPageWidget.dart';
import '/backend/api_requests/api_calls.dart';
import '/components/no_data_found_widget.dart';
import '/flutter_flow/flutter_flow_button_tabbar.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'dart:async';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'complete_profile_page_model.dart';
export 'complete_profile_page_model.dart';

class CompleteProfilePageWidget extends StatefulWidget {
  const CompleteProfilePageWidget({
    super.key,
    this.userId,
  });

  final String? userId;

  static String routeName = 'CompleteProfilePage';
  static String routePath = '/completeProfilePage';

  @override
  State<CompleteProfilePageWidget> createState() =>
      _CompleteProfilePageWidgetState();
}

class _CompleteProfilePageWidgetState extends State<CompleteProfilePageWidget>
    with TickerProviderStateMixin {
  late CompleteProfilePageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isInit = false;

  @override
  void initState() {
    super.initState();

    _model = createModel(context, () => CompleteProfilePageModel());

    _model.tabBarController = TabController(
      vsync: this,
      length: 3,
      initialIndex: 0,
    )..addListener(() => safeSetState(() {}));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_isInit) {
      _isInit = true;
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        _model.freelancerResponse =
            await ClientHomePageGroup.freelancerProfileCall.call(
          userId: widget.userId,
          authToken: FFAppState().apitoken,
        );
        setState(() {});
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

    // Show loading indicator until data is loaded
    if (_model.freelancerResponse == null) {
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

    final freelancerData =
        ClientHomePageGroup.freelancerProfileCall.freelancerProfile(
      (_model.freelancerResponse?.jsonBody ?? ''),
    );

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
          child: Stack(
            children: [
              Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  // App bar section
                  Container(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(20.0, 20.0, 20.0, 0.0),
                    color: Colors.transparent,
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
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
                            context.pop();
                          },
                        ),
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(50.0),
                                child: Image.network(
                                  valueOrDefault<String>(
                                    getJsonField(
                                      freelancerData,
                                      r'''$.data.avatar.url''',
                                    )?.toString(),
                                    'https://digitalstation.ezxdemo.com/storage/3/01J368C5WP2Y13A7Y1SVV0CXSF.png', // <-- valid default image
                                  ),
                                  width: 90.0,
                                  height: 90.0,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Image.asset(
                                      'assets/images/placeholder.png',
                                      width: 90.0,
                                      height: 90.0,
                                      fit: BoxFit.cover,
                                    );
                                  },
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 14.0, 0.0, 0.0),
                                child: Text(
                                  valueOrDefault<String>(
                                    getJsonField(
                                      freelancerData,
                                      r'''$.name''',
                                    )?.toString(),
                                    'N/A',
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
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 4.0, 0.0, 0.0),
                                child: Text(
                                  valueOrDefault<String>(
                                    getJsonField(
                                      freelancerData,
                                      r'''$.job_title''',
                                    )?.toString(),
                                    'N/A',
                                  ),
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'primaryFont',
                                        color: Color(0xFF898989),
                                        fontSize: 12.0,
                                        letterSpacing: 0.0,
                                      ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 40,
                        )
                        // Container(
                        //   decoration: BoxDecoration(
                        //     color: FlutterFlowTheme.of(context)
                        //         .secondaryBackground,
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(20.0, 170.0, 20.0, 0.0),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment(0.0, 0),
                      child: FlutterFlowButtonTabBar(
                        useToggleButtonStyle: true,
                        labelStyle:
                            FlutterFlowTheme.of(context).titleMedium.override(
                                  font: GoogleFonts.interTight(
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .titleMedium
                                        .fontStyle,
                                  ),
                                  fontSize: 12.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .titleMedium
                                      .fontStyle,
                                ),
                        unselectedLabelStyle:
                            FlutterFlowTheme.of(context).titleMedium.override(
                                  fontFamily: 'primaryFont',
                                  fontSize: 12.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.bold,
                                ),
                        labelColor: Color(0xFF6E2A87),
                        unselectedLabelColor: Colors.black,
                        backgroundColor: Color(0x3DA856BA),
                        unselectedBackgroundColor: Colors.white,
                        borderColor: Color(0x004B39EF),
                        unselectedBorderColor:
                            FlutterFlowTheme.of(context).alternate,
                        borderWidth: 0.0,
                        borderRadius: 20.0,
                        elevation: 1.0,
                        buttonMargin:
                            EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 8.0, 0.0),
                        padding: EdgeInsets.all(6.0),
                        tabs: [
                          Tab(
                            text: FFLocalizations.of(context)
                                .getText('ffmzhimt' /* About */),
                          ),
                          Tab(
                            text: FFLocalizations.of(context)
                                .getText('lgwrxg77' /* Services */),
                          ),
                          Tab(
                            text: FFLocalizations.of(context)
                                .getText('u3iz83tr' /* Portfolio */),
                          ),
                        ],
                        controller: _model.tabBarController,
                        onTap: (i) async {
                          [() async {}, () async {}, () async {}][i]();
                        },
                      ),
                    ),
                    Expanded(
                      child: TabBarView(
                        controller: _model.tabBarController,
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 40.0, 0.0, 0.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  FFLocalizations.of(context)
                                      .getText('cc8271mx' /* Info */),
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'primaryFont',
                                        fontSize: 15.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 10.0, 0.0, 6.0),
                                  child: Text(
                                    valueOrDefault<String>(
                                      getJsonField(
                                        freelancerData,
                                        r'''$.about''',
                                      )?.toString(),
                                      'N/A',
                                    ),
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'primaryFont',
                                          color: Color(0xFF454545),
                                          fontSize: 12.0,
                                          letterSpacing: 0.0,
                                        ),
                                  ),
                                ),
                                Divider(
                                  thickness: 1.0,
                                  color: FlutterFlowTheme.of(context).alternate,
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 20.0, 0.0, 0.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        child: Image.asset(
                                          'assets/images/marker-pin-04.png',
                                          width: 24.0,
                                          height: 24.0,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            10.0, 0.0, 0.0, 0.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              FFLocalizations.of(context)
                                                  .getText(
                                                      'bsrugfxc' /* From */),
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .bodyMedium
                                                  .override(
                                                    fontFamily: 'primaryFont',
                                                    color: Color(0xFF898989),
                                                    fontSize: 13.0,
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      0.0, 10.0, 0.0, 0.0),
                                              child: Text(
                                                valueOrDefault<String>(
                                                  getJsonField(
                                                    freelancerData,
                                                    r'''$.country''',
                                                  )?.toString(),
                                                  'N/A',
                                                ),
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily:
                                                              'primaryFont',
                                                          fontSize: 15.0,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 20.0, 0.0, 6.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        child: Image.asset(
                                          'assets/images/user-02.png',
                                          width: 24.0,
                                          height: 24.0,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            10.0, 0.0, 0.0, 0.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              FFLocalizations.of(context).getText(
                                                  'cg2j1g4f' /* Member Since */),
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .bodyMedium
                                                  .override(
                                                    fontFamily: 'primaryFont',
                                                    color: Color(0xFF898989),
                                                    fontSize: 13.0,
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      0.0, 10.0, 0.0, 0.0),
                                              child: Text(
                                                valueOrDefault<String>(
                                                  getJsonField(
                                                    freelancerData,
                                                    r'''$.created_at''',
                                                  )?.toString(),
                                                  'N/A',
                                                ),
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily:
                                                              'primaryFont',
                                                          fontSize: 15.0,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Divider(
                                  thickness: 1.0,
                                  color: FlutterFlowTheme.of(context).alternate,
                                ),
                                Text(
                                  FFLocalizations.of(context)
                                      .getText('al4kie96' /* Languages */),
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
                                        color: Colors.black,
                                        fontSize: 15.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.bold,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                      ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 10.0, 0.0, 10.0),
                                  child: Text(
                                    valueOrDefault<String>(
                                      getJsonField(
                                        freelancerData,
                                        r'''$.language''',
                                      )?.toString(),
                                      'N/A',
                                    ),
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'primaryFont',
                                          color: Colors.black,
                                          fontSize: 15.0,
                                          letterSpacing: 0.0,
                                        ),
                                  ),
                                ),
                                Divider(
                                  thickness: 1.0,
                                  color: FlutterFlowTheme.of(context).alternate,
                                ),
                                Text(
                                  FFLocalizations.of(context)
                                      .getText('68obyc7g' /* Skills */),
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
                                        color: Colors.black,
                                        fontSize: 15.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.bold,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                      ),
                                ),
                                Builder(
                                  builder: (context) {
                                    final skillListRaw = getJsonField(
                                      freelancerData,
                                      r'''$.skills''',
                                    );
                                    final skillList = (skillListRaw is List)
                                        ? skillListRaw
                                        : <dynamic>[];

                                    if (skillList.isEmpty) {
                                      return Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 10.0),
                                        child: Text(
                                          'No skills found',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily: 'primaryFont',
                                                color: Colors.black,
                                                fontSize: 15.0,
                                                letterSpacing: 0.0,
                                              ),
                                        ),
                                      );
                                    }

                                    return ListView.separated(
                                      padding: EdgeInsets.zero,
                                      shrinkWrap: true,
                                      scrollDirection: Axis.vertical,
                                      itemCount: skillList.length,
                                      separatorBuilder: (_, __) =>
                                          SizedBox(height: 6.0),
                                      itemBuilder: (context, skillListIndex) {
                                        final skillListItem =
                                            skillList[skillListIndex];
                                        return Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 10.0, 0.0, 10.0),
                                          child: Text(
                                            getJsonField(
                                              skillListItem,
                                              r'''$.title''',
                                            ).toString(),
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily: 'primaryFont',
                                                  color: Colors.black,
                                                  fontSize: 15.0,
                                                  letterSpacing: 0.0,
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
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 10.0, 0.0, 0.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                FutureBuilder<ApiCallResponse>(
                                  future: (_model.apiRequestCompleter ??=
                                          Completer<ApiCallResponse>()
                                            ..complete(
                                              () async {
                                                final response =
                                                    await ClientHomePageGroup
                                                        .freelancerProfileCall
                                                        .call(
                                                  userId: widget.userId,
                                                  authToken:
                                                      FFAppState().apitoken,
                                                );
                                                return response;
                                              }(),
                                            ))
                                      .future,
                                  builder: (context, snapshot) {
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

                                    final listViewFreelancerProfileResponse =
                                        snapshot.data!;
                                    final serviceListRaw = getJsonField(
                                      ClientHomePageGroup.freelancerProfileCall
                                          .freelancerProfile(
                                        listViewFreelancerProfileResponse
                                            .jsonBody,
                                      ),
                                      r'''$.services''',
                                    );
                                    final serviceList = (serviceListRaw is List)
                                        ? serviceListRaw
                                        : <dynamic>[];

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

                                    return Expanded(
                                      child: RefreshIndicator(
                                        color: Color(0xFF6E2A87),
                                        onRefresh: () async {
                                          safeSetState(() => _model
                                              .apiRequestCompleter = null);
                                          await _model
                                              .waitForApiRequestCompleted();
                                        },
                                        child: ListView.separated(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 40.0, 0.0, 20.0),
                                          itemCount: serviceList.length,
                                          separatorBuilder: (_, __) =>
                                              SizedBox(height: 16.0),
                                          itemBuilder:
                                              (context, serviceListIndex) {
                                            final serviceListItem =
                                                serviceList[serviceListIndex];

                                            final imageUrl = getJsonField(
                                                        serviceListItem,
                                                        r'''$.gallery[0].url''')
                                                    ?.toString() ??
                                                getJsonField(serviceListItem,
                                                        r'''$.image.url''')
                                                    ?.toString() ??
                                                'https://fastly.picsum.photos/id/237/200/300.jpg?hmac=TmmQSbShHz9CdQm0NkEjx1Dyh_Y984R9LpNrpvH2D_U';
                                            final username =
                                                valueOrDefault<String>(
                                              getJsonField(serviceListItem,
                                                      r'''$.username''')
                                                  ?.toString(),
                                              'N/A',
                                            );
                                            final description =
                                                valueOrDefault<String>(
                                              getJsonField(serviceListItem,
                                                      r'''$.description''')
                                                  ?.toString(),
                                              'N/A',
                                            );
                                            final startFrom =
                                                valueOrDefault<String>(
                                              getJsonField(serviceListItem,
                                                      r'''$.start_from''')
                                                  ?.toString(),
                                              'N/A',
                                            );
                                            final averageReviews =
                                                valueOrDefault<String>(
                                              getJsonField(serviceListItem,
                                                      r'''$.average_reviews''')
                                                  ?.toString(),
                                              'N/A',
                                            );
                                            final isSaved = getJsonField(
                                                    serviceListItem,
                                                    r'''$.isSaved''') ??
                                                false;

                                            return InkWell(
                                              onTap: () {
                                                context.pushNamed(
                                                  ServiceDetailPageWidget
                                                      .routeName,
                                                  queryParameters: {
                                                    'serviceId': serializeParam(
                                                      getJsonField(
                                                              serviceListItem,
                                                              r'''$.id''')
                                                          .toString(),
                                                      ParamType.String,
                                                    ),
                                                  }.withoutNulls,
                                                );
                                              },
                                              child: Container(
                                                width: double.infinity,
                                                height: 125.0,
                                                decoration: BoxDecoration(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryBackground,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          16.0),
                                                ),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    // Image section
                                                    ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              16.0),
                                                      child: Image.network(
                                                        imageUrl,
                                                        width: 125.0,
                                                        height: 125.0,
                                                        fit: BoxFit.cover,
                                                        errorBuilder: (context,
                                                            error, stackTrace) {
                                                          return Container(
                                                            width: 125.0,
                                                            height: 125.0,
                                                            color: Colors
                                                                .grey[300],
                                                            child: Icon(
                                                              Icons.image,
                                                              size: 50.0,
                                                              color: Colors
                                                                  .grey[600],
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                    // Content section
                                                    Expanded(
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    16.0,
                                                                    16.0,
                                                                    16.0,
                                                                    16.0),
                                                        child: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            // Username row
                                                            Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              children: [
                                                                ClipRRect(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              8.0),
                                                                  child: Image
                                                                      .asset(
                                                                    'assets/images/user-01.png',
                                                                    width: 13.0,
                                                                    height:
                                                                        13.0,
                                                                    fit: BoxFit
                                                                        .cover,
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          4.0,
                                                                          0.0,
                                                                          0.0,
                                                                          0.0),
                                                                  child: Text(
                                                                    username,
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .override(
                                                                          fontFamily:
                                                                              'primaryFont',
                                                                          color:
                                                                              Color(0xFF898989),
                                                                          fontSize:
                                                                              10.0,
                                                                          letterSpacing:
                                                                              0.0,
                                                                        ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            // Description
                                                            Expanded(
                                                              child: Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0.0,
                                                                            8.0,
                                                                            0.0,
                                                                            0.0),
                                                                child: Text(
                                                                  description,
                                                                  maxLines: 2,
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .override(
                                                                        fontFamily:
                                                                            'primaryFont',
                                                                        fontSize:
                                                                            13.0,
                                                                        letterSpacing:
                                                                            0.0,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                      ),
                                                                ),
                                                              ),
                                                            ),
                                                            // Price and Rating row
                                                            Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Text(
                                                                  'Start From \$${startFrom}',
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
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
                                                                Row(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  children: [
                                                                    Icon(
                                                                      Icons
                                                                          .star,
                                                                      color: Color(
                                                                          0xFFFFCF26),
                                                                      size:
                                                                          16.0,
                                                                    ),
                                                                    Text(
                                                                      averageReviews,
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .override(
                                                                            fontFamily:
                                                                                'primaryFont',
                                                                            fontSize:
                                                                                12.0,
                                                                            letterSpacing:
                                                                                0.0,
                                                                          ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    // Bookmark section
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0.0,
                                                                  16.0,
                                                                  16.0,
                                                                  0.0),
                                                      child: Align(
                                                        alignment:
                                                            AlignmentDirectional(
                                                                0.0, -1.0),
                                                        child: InkWell(
                                                          onTap: () async {
                                                            final response =
                                                                await ClientHomePageGroup
                                                                    .addToFavouriteCall
                                                                    .call(
                                                              id: getJsonField(
                                                                      serviceListItem,
                                                                      r'''$.id''')
                                                                  .toString(),
                                                              authToken:
                                                                  FFAppState()
                                                                      .apitoken,
                                                            );

                                                            final apiMessage = getJsonField(
                                                                        response
                                                                            .jsonBody,
                                                                        r'''$.message''')
                                                                    ?.toString() ??
                                                                'No message';
                                                            ScaffoldMessenger
                                                                    .of(context)
                                                                .showSnackBar(
                                                              SnackBar(
                                                                content: Text(
                                                                  apiMessage,
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white),
                                                                ),
                                                                duration: Duration(
                                                                    milliseconds:
                                                                        4000),
                                                                backgroundColor:
                                                                    Color(
                                                                        0xFF6E2A87),
                                                              ),
                                                            );

                                                            if (response
                                                                .succeeded) {
                                                              safeSetState(() =>
                                                                  _model.apiRequestCompleter =
                                                                      null);
                                                              await _model
                                                                  .waitForApiRequestCompleted();
                                                            }
                                                          },
                                                          child: Icon(
                                                            isSaved
                                                                ? Icons.bookmark
                                                                : Icons
                                                                    .bookmark_border,
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .primaryText,
                                                            size: 24.0,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 10.0, 0.0, 0.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      20.0, 0.0, 20.0, 0.0),
                                  child: Builder(
                                    builder: (context) {
                                      final portfolioLastRaw = getJsonField(
                                        freelancerData,
                                        r'''$.portfolio''',
                                      );
                                      final portfolioLast =
                                          (portfolioLastRaw is List)
                                              ? portfolioLastRaw
                                              : <dynamic>[];

                                      if (portfolioLast.isEmpty) {
                                        return NoDataFoundWidget(
                                          title: 'No data found',
                                        );
                                      }

                                      return RefreshIndicator(
                                        color: Color(0xFF6E2A87),
                                        onRefresh: () async {
                                          safeSetState(() => _model
                                              .apiRequestCompleter = null);
                                          await _model
                                              .waitForApiRequestCompleted();
                                        },
                                        child: GridView.builder(
                                          padding: EdgeInsets.fromLTRB(
                                              0, 0, 0, 10.0),
                                          gridDelegate:
                                              SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            crossAxisSpacing: 10.0,
                                            mainAxisSpacing: 10.0,
                                            childAspectRatio: 1.0,
                                          ),
                                          primary: false,
                                          shrinkWrap: true,
                                          scrollDirection: Axis.vertical,
                                          itemCount: portfolioLast.length,
                                          itemBuilder:
                                              (context, portfolioLastIndex) {
                                            final portfolioLastItem =
                                                portfolioLast[
                                                    portfolioLastIndex];
                                            return InkWell(
                                              onTap: () {
                                                final galleryRaw = getJsonField(
                                                  portfolioLastItem,
                                                  r'''$.gallery''',
                                                );
                                                final gallery =
                                                    (galleryRaw is List)
                                                        ? galleryRaw
                                                        : <dynamic>[];
                                                final galleryUrls = gallery
                                                    .map((g) => getJsonField(
                                                            g, r'''$.url''')
                                                        .toString())
                                                    .toList();

                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (_) =>
                                                        PortfolioGalleryDetailPageWidget(
                                                      title: valueOrDefault<
                                                          String>(
                                                        getJsonField(
                                                          portfolioLastItem,
                                                          r'''$.title''',
                                                        )?.toString(),
                                                        '',
                                                      ),
                                                      galleryUrls: galleryUrls,
                                                    ),
                                                  ),
                                                );
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryBackground,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                  shape: BoxShape.rectangle,
                                                ),
                                                child: Padding(
                                                  padding: EdgeInsets.all(6.0),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Flexible(
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      8.0),
                                                          child: Image.network(
                                                            valueOrDefault<
                                                                String>(
                                                              getJsonField(
                                                                portfolioLastItem,
                                                                r'''$.gallery[0].url''',
                                                              )?.toString(),
                                                              'https://digitalstation.ezxdemo.com/storage/3/01J368C5WP2Y13A7Y1SVV0CXSF.png',
                                                            ),
                                                            width:
                                                                double.infinity,
                                                            height: 110.0,
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0.0,
                                                                    10.0,
                                                                    0.0,
                                                                    0.0),
                                                        child: Text(
                                                          valueOrDefault<
                                                              String>(
                                                            getJsonField(
                                                              portfolioLastItem,
                                                              r'''$.title''',
                                                            )?.toString(),
                                                            'N/A',
                                                          ),
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyMedium
                                                              .override(
                                                                fontFamily:
                                                                    'primaryFont',
                                                                color: Color(
                                                                    0xFF454545),
                                                                fontSize: 12.0,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                      ),
                                                      Row(
                                                        children: [
                                                          ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        0.0),
                                                            child: Image.asset(
                                                              'assets/images/Icon_(Stroke)_(17).png',
                                                              width: 11.0,
                                                              height: 11.0,
                                                              fit: BoxFit.cover,
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        4.0,
                                                                        0.0,
                                                                        0.0,
                                                                        0.0),
                                                            child: Text(
                                                              FFLocalizations.of(
                                                                      context)
                                                                  .getText(
                                                                      '5mhwux04' /* 1 */),
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyMedium
                                                                  .override(
                                                                    fontFamily:
                                                                        'primaryFont',
                                                                    fontSize:
                                                                        12.0,
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
                                              ),
                                            );
                                          },
                                        ),
                                      );
                                    },
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
            ],
          ),
        ),
      ),
    );
  }
}
