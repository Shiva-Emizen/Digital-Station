import '/flutter_flow/flutter_flow_util.dart';
import 'select_plan_page_widget.dart' show SelectPlanPageWidget;
import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

class SelectPlanPageModel extends FlutterFlowModel<SelectPlanPageWidget> {
  // Checkbox state
  bool? checkboxValue;

  // In-app purchase state
  final InAppPurchase iap = InAppPurchase.instance;
  List<ProductDetails> products = [];
  bool loading = true;
  bool purchasePending = false;
  String? error;

  // Your product IDs from App Store/Play Console
  final List<String> kProductIds = <String>[
    'monthly_subscription', // Example
    'yearly_subscription',  // Example
  ];

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}