import 'package:in_app_purchase/in_app_purchase.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'select_plan_page_model.dart';
export 'select_plan_page_model.dart';

class SelectPlanPageWidget extends StatefulWidget {
  const SelectPlanPageWidget({super.key});

  static String routeName = 'SelectPlanPage';
  static String routePath = '/selectPlanPage';

  @override
  State<SelectPlanPageWidget> createState() => _SelectPlanPageWidgetState();
}

class _SelectPlanPageWidgetState extends State<SelectPlanPageWidget> {
  late SelectPlanPageModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SelectPlanPageModel());
    _initialize();
  }

  Future<void> _initialize() async {
    final bool available = await _model.iap.isAvailable();
    if (!available) {
      setState(() {
        _model.loading = false;
        _model.error = 'Store not available';
      });
      return;
    }
    final ProductDetailsResponse response =
        await _model.iap.queryProductDetails(_model.kProductIds.toSet());
    setState(() {
      _model.products = response.productDetails;
      _model.loading = false;
      _model.error = response.error?.message;
    });
    _model.iap.purchaseStream
        .listen(_listenToPurchaseUpdated, onDone: () {}, onError: (error) {});
  }

  void _listenToPurchaseUpdated(List<PurchaseDetails> purchases) async {
    for (final purchase in purchases) {
      if (purchase.status == PurchaseStatus.purchased ||
          purchase.status == PurchaseStatus.restored) {
        await _model.iap.completePurchase(purchase);
        if (mounted) {
          Navigator.of(context).pushReplacementNamed('/homePage');
        }
      } else if (purchase.status == PurchaseStatus.error) {
        setState(() {
          _model.error = purchase.error?.message;
        });
      }
      setState(() {
        _model.purchasePending = purchase.status == PurchaseStatus.pending;
      });
    }
  }

  Future<void> _buyProduct(ProductDetails product) async {
    final PurchaseParam purchaseParam = PurchaseParam(productDetails: product);
    await _model.iap.buyNonConsumable(purchaseParam: purchaseParam);
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                // Your existing UI
                Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 0.0),
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
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 20.0, 0.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  FFLocalizations.of(context)
                                      .getText('bpdqo8uc' /* Select Plan */),
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
                              color: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(20.0, 10.0, 20.0, 0.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.asset(
                          'assets/images/Register_Progress_(1).png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(
                          100.0, 80.0, 100.0, 0.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.asset(
                          'assets/images/Done-rafiki_1.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Text(
                      FFLocalizations.of(context)
                          .getText('xzmkupcv' /* You are almost done */),
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'primaryFont',
                            fontSize: 20.0,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(20.0, 200.0, 0.0, 0.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Theme(
                            data: ThemeData(
                              checkboxTheme: CheckboxThemeData(
                                visualDensity: VisualDensity.compact,
                                materialTapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4.0),
                                ),
                              ),
                              unselectedWidgetColor:
                                  FlutterFlowTheme.of(context).alternate,
                            ),
                            child: Checkbox(
                              value: _model.checkboxValue ??= true,
                              onChanged: (newValue) async {
                                setState(
                                    () => _model.checkboxValue = newValue!);
                              },
                              side: (FlutterFlowTheme.of(context).alternate !=
                                      null)
                                  ? BorderSide(
                                      width: 2,
                                      color: FlutterFlowTheme.of(context)
                                          .alternate,
                                    )
                                  : null,
                              activeColor: Color(0xFF16AFE6),
                              checkColor: FlutterFlowTheme.of(context).info,
                            ),
                          ),
                          Text(
                            FFLocalizations.of(context)
                                .getText('5yfzc59t' /* Agree with  */),
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'primaryFont',
                                  color: Color(0xFF252525),
                                  letterSpacing: 0.0,
                                ),
                          ),
                          Text(
                            FFLocalizations.of(context)
                                .getText('gn4tktvr' /*  Terms & Conditions */),
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'primaryFont',
                                  color: Color(0xFF16AFE6),
                                  letterSpacing: 0.0,
                                ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(20.0, 40.0, 20.0, 0.0),
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
                            FFLocalizations.of(context)
                                .getText('e7akbp0q' /* Sign up */),
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
                  ],
                ),
                // Subscription plans UI
                Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(20.0, 40.0, 20.0, 0.0),
                  child: _model.loading
                      ? Center(child: CircularProgressIndicator())
                      : _model.error != null
                          ? Text(_model.error!,
                              style: TextStyle(color: Colors.red))
                          : Column(
                              children: _model.products.map((product) {
                                return Card(
                                  margin: EdgeInsets.symmetric(vertical: 8),
                                  child: ListTile(
                                    title: Text(product.title),
                                    subtitle: Text(product.description),
                                    trailing: Text(product.price),
                                    onTap: _model.purchasePending
                                        ? null
                                        : () => _buyProduct(product),
                                  ),
                                );
                              }).toList(),
                            ),
                ),
                if (_model.purchasePending)
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: CircularProgressIndicator(),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
