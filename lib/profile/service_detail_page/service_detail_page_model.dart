import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'service_detail_page_widget.dart' show ServiceDetailPageWidget;
import 'package:flutter/material.dart';

class ServiceDetailPageModel extends FlutterFlowModel<ServiceDetailPageWidget> {
  ///  Local state fields for this page.

  dynamic selectedPackage;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - API (serviceDetail)] action in ServiceDetailPage widget.
  ApiCallResponse? detailsResponse;
  // State field(s) for RatingBar widget.
  double? ratingBarValue;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
