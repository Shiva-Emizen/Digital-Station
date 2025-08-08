import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'dart:async';
import 'order_page_widget.dart' show OrderPageWidget;
import 'package:flutter/material.dart';

class OrderPageModel extends FlutterFlowModel<OrderPageWidget> {
  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - API (ChangeStatus)] action in Button widget.
  ApiCallResponse? apiResultn5n;
  Completer<ApiCallResponse>? apiRequestCompleter1;
  // Stores action output result for [Backend Call - API (ChangeStatus)] action in Button widget.
  ApiCallResponse? apiResultmhn;
  // Stores action output result for [Backend Call - API (ChangeStatus)] action in Button widget.
  ApiCallResponse? apiResultgth;
  // Stores action output result for [Backend Call - API (ChangeStatus)] action in Button widget.
  ApiCallResponse? apiResult3ts;
  // Stores action output result for [Backend Call - API (ChangeOrder)] action in Button widget.
  ApiCallResponse? apiResulthtk;
  Completer<ApiCallResponse>? apiRequestCompleter2;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}

  /// Additional helper methods.
  Future waitForApiRequestCompleted1({
    double minWait = 0,
    double maxWait = double.infinity,
  }) async {
    final stopwatch = Stopwatch()..start();
    while (true) {
      await Future.delayed(Duration(milliseconds: 50));
      final timeElapsed = stopwatch.elapsedMilliseconds;
      final requestComplete = apiRequestCompleter1?.isCompleted ?? false;
      if (timeElapsed > maxWait || (requestComplete && timeElapsed > minWait)) {
        break;
      }
    }
  }

  Future waitForApiRequestCompleted2({
    double minWait = 0,
    double maxWait = double.infinity,
  }) async {
    final stopwatch = Stopwatch()..start();
    while (true) {
      await Future.delayed(Duration(milliseconds: 50));
      final timeElapsed = stopwatch.elapsedMilliseconds;
      final requestComplete = apiRequestCompleter2?.isCompleted ?? false;
      if (timeElapsed > maxWait || (requestComplete && timeElapsed > minWait)) {
        break;
      }
    }
  }
}
