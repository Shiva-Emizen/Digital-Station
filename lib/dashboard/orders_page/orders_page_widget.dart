import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'orders_page_model.dart';
export 'orders_page_model.dart';

class OrdersPageWidget extends StatefulWidget {
  const OrdersPageWidget({
    super.key,
    required this.orderId,
  });

  final String? orderId;

  static String routeName = 'OrdersPage';
  static String routePath = '/ordersPage';

  @override
  State<OrdersPageWidget> createState() => _OrdersPageWidgetState();
}

class _OrdersPageWidgetState extends State<OrdersPageWidget> {
  late OrdersPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isLoading = false;
  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => OrdersPageModel());

    SchedulerBinding.instance.addPostFrameCallback((_) {
      _fetchOrderDetailsIfReady();
    });
  }

  Future<void> _fetchOrderDetailsIfReady() async {
    final orderId = widget.orderId;
    final apiToken = FFAppState().apitoken;

    print('OrderId: $orderId');
    print('APIToken: $apiToken');

    if (orderId != null && orderId.isNotEmpty && apiToken.isNotEmpty) {
      setState(() {
        _isLoading = true;
      });

      final result = await ClientHomePageGroup.orderDetailCall.call(
        orderId: orderId,
        authToken: apiToken,
      );

      setState(() {
        _model.apiResultmh7 = result;
        _isLoading = false;
      });

      if (!(result?.succeeded ?? false)) {
        print('API call failed');
        // Optionally show snackbar or dialog here
      }
    } else {
      print('OrderId or API token not ready yet.');
      // Optionally retry or listen for token/orderId changes
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

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body:_isLoading
            ? Center(child: CircularProgressIndicator())
            :  Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(20.0, 20, 20.0, 20),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                      context.safePop();
                    },
                  ),
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 20.0, 0.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          FFLocalizations.of(context).getText(
                            'lur27yvo' /* Orders */,
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
              padding: EdgeInsets.all(20.0),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            0.0, 6.0, 0.0, 0.0),
                        child: Text(
                          valueOrDefault<String>(
                            getJsonField(
                              ClientHomePageGroup.orderDetailCall.orderDetail(
                                (_model.apiResultmh7?.jsonBody ?? ''),
                              ),
                              r'''$.service.title''',
                            )?.toString(),
                            'N/A',
                          ),
                          style: FlutterFlowTheme.of(context)
                              .bodyMedium
                              .override(
                                fontFamily: 'primaryFont',
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            0.0, 10.0, 0.0, 0.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(0.0),
                              child: Image.asset(
                                'assets/images/Icon_(Stroke)_(10).png',
                                width: 15.0,
                                height: 15.0,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  5.0, 0.0, 0.0, 0.0),
                              child: Text(
                                FFLocalizations.of(context).getText(
                                  '4w4x139b' /* Service by : */,
                                ),
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
                                      fontSize: 11.0,
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
                            Text(
                              valueOrDefault<String>(
                                getJsonField(
                                  ClientHomePageGroup.orderDetailCall
                                      .orderDetail(
                                    (_model.apiResultmh7?.jsonBody ?? ''),
                                  ),
                                  r'''$.service.username''',
                                )?.toString(),
                                'N/A',
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'primaryFont',
                                    fontSize: 11.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            0.0, 10.0, 0.0, 0.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(0.0),
                              child: Image.asset(
                                'assets/images/Icon_(Stroke)_(11).png',
                                width: 15.0,
                                height: 15.0,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  5.0, 0.0, 0.0, 0.0),
                              child: Text(
                                FFLocalizations.of(context).getText(
                                  'cdd7sh8w' /* Package : */,
                                ),
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
                                      fontSize: 11.0,
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
                            Text(
                              valueOrDefault<String>(
                                getJsonField(
                                  ClientHomePageGroup.orderDetailCall
                                      .orderDetail(
                                    (_model.apiResultmh7?.jsonBody ?? ''),
                                  ),
                                  r'''$.package.title''',
                                )?.toString(),
                                'N/A',
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'primaryFont',
                                    fontSize: 11.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            0.0, 10.0, 0.0, 0.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(0.0),
                              child: Image.asset(
                                'assets/images/Icon_(Stroke)_(12).png',
                                width: 15.0,
                                height: 16.0,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  5.0, 0.0, 0.0, 0.0),
                              child: Text(
                                FFLocalizations.of(context).getText(
                                  'xlfh7nwo' /* Delivery time : */,
                                ),
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
                                      fontSize: 11.0,
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
                            Text(
                              valueOrDefault<String>(
                                getJsonField(
                                  ClientHomePageGroup.orderDetailCall
                                      .orderDetail(
                                    (_model.apiResultmh7?.jsonBody ?? ''),
                                  ),
                                  r'''$.package.delivery_time''',
                                )?.toString(),
                                'N/A',
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'primaryFont',
                                    fontSize: 11.0,
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
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            0.0, 5.0, 0.0, 0.0),
                        child: Text(
                          FFLocalizations.of(context).getText(
                            's3ndfd7x' /* Comments */,
                          ),
                          style: FlutterFlowTheme.of(context)
                              .bodyMedium
                              .override(
                                fontFamily: 'primaryFont',
                                fontSize: 11.0,
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
                              ClientHomePageGroup.orderDetailCall.orderDetail(
                                (_model.apiResultmh7?.jsonBody ?? ''),
                              ),
                              r'''$.service.description''',
                            )?.toString(),
                            'N/A',
                          ),
                          style: FlutterFlowTheme.of(context)
                              .bodyMedium
                              .override(
                                fontFamily: 'primaryFont',
                                color: Color(0xFF454545),
                                fontSize: 10.0,
                                letterSpacing: 0.0,
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
