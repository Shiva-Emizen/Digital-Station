import '/backend/api_requests/api_calls.dart';
import '/components/no_data_found_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'dart:async';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'EditPortfolioPageWidget.dart';
import 'PortfolioGalleryDetailPageWidget.dart';
import 'portfolio_page_model.dart';
export 'portfolio_page_model.dart';

class PortfolioPageWidget extends StatefulWidget {
  const PortfolioPageWidget({super.key});

  static String routeName = 'PortfolioPage';
  static String routePath = '/portfolioPage';

  @override
  State<PortfolioPageWidget> createState() => _PortfolioPageWidgetState();
}

class _PortfolioPageWidgetState extends State<PortfolioPageWidget> {
  late PortfolioPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PortfolioPageModel());
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
            padding: EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 0.0),
            child: Stack(
              children: [
                Padding(
                  padding:
                  EdgeInsetsDirectional.fromSTEB(20.0, 20.0, 20.0, 0.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 20.0, 0.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              FFLocalizations.of(context).getText(
                                'g08jczif' /* My Portfolio */,
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
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 60.0, 0.0, 0.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            20.0, 0.0, 20.0, 0.0),
                        child: Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0.0, 20.0, 0.0, 0.0),
                              child: SizedBox(
                                height: 160.0,
                                // Ensures the area has real height
                                width: double.infinity,
                                child: Material(
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.circular(16.0),
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(16.0),
                                    onTap: () {
                                      context.pushNamed(
                                          MyPortFolioPageWidget.routeName);
                                    },
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(16.0),
                                      child: Image.asset(
                                        'assets/images/Rectangle_188.png',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Align(
                              alignment: AlignmentDirectional(0.0, 0.0),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 36.0, 0.0, 0.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(0.0),
                                        bottomRight: Radius.circular(0.0),
                                        topLeft: Radius.circular(0.0),
                                        topRight: Radius.circular(0.0),
                                      ),
                                      child: Image.asset(
                                        'assets/images/Icon_(Stroke)_(16).png',
                                        width: 22.0,
                                        height: 22.0,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 15.0, 0.0, 0.0),
                                      child: Text(
                                        FFLocalizations.of(context).getText(
                                          'm2g2xlwp' /* Add New Gallery */,
                                        ),
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
                            ),
                          ],
                        ),
                      ),
                    ].divide(SizedBox(height: 8.0)),
                  ),
                ),
                Padding(
                  padding:
                  EdgeInsetsDirectional.fromSTEB(20.0, 260.0, 20.0, 0.0),
                  child: FutureBuilder<ApiCallResponse>(
                    future: (_model.apiRequestCompleter ??= Completer<
                        ApiCallResponse>()
                      ..complete(FreelancerHomePageGroup.portfolioCall.call(
                        authToken: FFAppState().apitoken,
                      )))
                        .future,
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
                      final gridViewPortfolioResponse = snapshot.data!;

                      return Builder(
                        builder: (context) {
                          final portfolioLast =
                              FreelancerHomePageGroup.portfolioCall
                                  .portfolioList(
                                gridViewPortfolioResponse.jsonBody,
                              )
                                  ?.toList() ??
                                  [];
                          if (portfolioLast.isEmpty) {
                            return NoDataFoundWidget(
                              title: 'No data found',
                            );
                          }

                          return RefreshIndicator(
                            color: Color(0xFF6E2A87),
                            onRefresh: () async {
                              safeSetState(
                                      () => _model.apiRequestCompleter = null);
                              await _model.waitForApiRequestCompleted();
                            },
                            child: GridView.builder(
                              padding: EdgeInsets.fromLTRB(
                                0,
                                0,
                                0,
                                10.0,
                              ),
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
                              itemBuilder: (context, portfolioLastIndex) {
                                final portfolioLastItem =
                                portfolioLast[portfolioLastIndex];

                                return Stack(
                                  children: [
                                    InkWell(
                                      borderRadius: BorderRadius.circular(10.0),
                                      onTap: () {
                                        final galleryList = (getJsonField(
                                            portfolioLastItem,
                                            r'''$.gallery''') as List?)
                                            ?.map((img) => getJsonField(
                                            img, r'''$.url''')
                                            .toString())
                                            .where((url) => url.isNotEmpty)
                                            .toList() ??
                                            [];

                                        final title = valueOrDefault<String>(
                                          getJsonField(portfolioLastItem,
                                              r'''$.title''')
                                              ?.toString(),
                                          'N/A',
                                        );

                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                PortfolioGalleryDetailPageWidget(
                                                  title: title,
                                                  galleryUrls: galleryList,
                                                ),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryBackground,
                                          borderRadius:
                                          BorderRadius.circular(10.0),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.all(6.0),
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                BorderRadius.circular(8.0),
                                                child: Image.network(
                                                  valueOrDefault<String>(
                                                    getJsonField(
                                                      portfolioLastItem,
                                                      r'''$.gallery[0].url''',
                                                    )?.toString(),
                                                    'https://digitalstation.ezxdemo.com/storage/3/01J368C5WP2Y13A7Y1SVV0CXSF.png',
                                                  ),
                                                  width: 155.0,
                                                  height: 110.0,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              SizedBox(height: 10),
                                              Text(
                                                valueOrDefault<String>(
                                                  getJsonField(
                                                      portfolioLastItem,
                                                      r'''$.title''')
                                                      ?.toString(),
                                                  'N/A',
                                                ).maybeHandleOverflow(
                                                    maxChars: 10,
                                                    replacement: '…'),
                                                style: FlutterFlowTheme.of(
                                                    context)
                                                    .bodyMedium
                                                    .override(
                                                  fontFamily: 'primaryFont',
                                                  color: Color(0xFF454545),
                                                  fontSize: 12.0,
                                                  fontWeight:
                                                  FontWeight.bold,
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  Image.asset(
                                                    'assets/images/Icon_(Stroke)_(17).png',
                                                    width: 11.0,
                                                    height: 11.0,
                                                    fit: BoxFit.cover,
                                                  ),
                                                  SizedBox(width: 4),
                                                  Text(
                                                    (getJsonField(portfolioLastItem,
                                                        r'''$.gallery''')
                                                    as List?)
                                                        ?.length
                                                        .toString() ??
                                                        '0',
                                                    style: FlutterFlowTheme.of(
                                                        context)
                                                        .bodyMedium
                                                        .override(
                                                      fontFamily:
                                                      'primaryFont',
                                                      fontSize: 12.0,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),

                                    // Top-left Edit Icon
                                    Positioned(
                                      top: 8,
                                      left: 8,
                                      child: GestureDetector(
                                        onTap: () {
                                          final galleryList = (getJsonField(
                                              portfolioLastItem,
                                              r'''$.gallery''')
                                          as List?)
                                              ?.map((img) => getJsonField(
                                              img, r'''$.url''')
                                              .toString())
                                              .where(
                                                  (url) => url.isNotEmpty)
                                              .toList() ??
                                              [];
                                          final title = valueOrDefault<String>(
                                            getJsonField(portfolioLastItem,
                                                r'''$.title''')
                                                ?.toString(),
                                            'N/A',
                                          );
                                          final portfolioId = getJsonField(
                                              portfolioLastItem,
                                              r'''$.id''')
                                              .toString();

                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  EditPortfolioPageWidget(
                                                    initialTitle: title,
                                                    galleryUrls: galleryList,
                                                    portfolioId: portfolioId,
                                                  ),
                                            ),
                                          );
                                        },
                                        child: Container(
                                          padding: EdgeInsets.all(4),
                                          decoration: BoxDecoration(
                                            color:
                                            Colors.white.withOpacity(0.8),
                                            shape: BoxShape.circle,
                                          ),
                                          child: Icon(
                                            Icons.edit,
                                            size: 16,
                                            color: Colors.black87,
                                          ),
                                        ),
                                      ),
                                    ),

                                    // Top-right Delete Icon
                                    Positioned(
                                      top: 8,
                                      right: 8,
                                      child: GestureDetector(
                                        onTap: () async {
                                          final confirm =
                                          await showDialog<bool>(
                                            context: context,
                                            builder: (_) => AlertDialog(
                                              title: Text('Delete Portfolio'),
                                              content: Text(
                                                  'Are you sure you want to delete this item?'),
                                              actions: [
                                                TextButton(
                                                  onPressed: () =>
                                                      Navigator.pop(
                                                          context, false),
                                                  child: Text('Cancel'),
                                                ),
                                                TextButton(
                                                  onPressed: () =>
                                                      Navigator.pop(
                                                          context, true),
                                                  child: Text('Delete'),
                                                ),
                                              ],
                                            ),
                                          );

                                          if (confirm == true) {
                                            _model.apiResultpah =
                                            await FreelancerHomePageGroup
                                                .deletePortfolioCall
                                                .call(
                                              id: getJsonField(
                                                portfolioLastItem,
                                                r'''$.id''',
                                              ).toString(),
                                              authToken: FFAppState().apitoken,
                                            );

                                            if ((_model
                                                .apiResultpah?.succeeded ??
                                                true)) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                    getJsonField(
                                                      (_model.apiResultpah
                                                          ?.jsonBody ??
                                                          ''),
                                                      r'''$.message''',
                                                    ).toString(),
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  duration: Duration(
                                                      milliseconds: 4000),
                                                  backgroundColor:
                                                  Color(0xFF6E2A87),
                                                ),
                                              );
                                              safeSetState(() => _model
                                                  .apiRequestCompleter = null);
                                            } else {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                    getJsonField(
                                                      (_model.apiResultpah
                                                          ?.jsonBody ??
                                                          ''),
                                                      r'''$.message''',
                                                    ).toString(),
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  duration: Duration(
                                                      milliseconds: 4000),
                                                  backgroundColor:
                                                  Color(0xFF6E2A87),
                                                ),
                                              );
                                            }

                                            safeSetState(() {});
                                          }
                                        },
                                        child: Container(
                                          padding: EdgeInsets.all(4),
                                          decoration: BoxDecoration(
                                            color:
                                            Colors.white.withOpacity(0.8),
                                            shape: BoxShape.circle,
                                          ),
                                          child: Icon(
                                            Icons.delete,
                                            size: 16,
                                            color: Colors.redAccent,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
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
      ),
    );
  }
}
