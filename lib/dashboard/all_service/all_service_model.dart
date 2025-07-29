import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'all_service_widget.dart' show AllServiceWidget;
import 'dart:async';
import 'package:flutter/material.dart';

class AllServiceModel extends FlutterFlowModel<AllServiceWidget> {
  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - API (AddToFavourite)] action in Icon widget.
  ApiCallResponse? apiResultp7f;
  Completer<ApiCallResponse>? apiRequestCompleter;
  // Stores action output result for [Backend Call - API (AddToFavourite)] action in Icon widget.
  ApiCallResponse? apiResultd05;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}

  /// Additional helper methods.
  Future waitForApiRequestCompleted({
    double minWait = 0,
    double maxWait = double.infinity,
  }) async {
    final stopwatch = Stopwatch()..start();
    while (true) {
      await Future.delayed(Duration(milliseconds: 50));
      final timeElapsed = stopwatch.elapsedMilliseconds;
      final requestComplete = apiRequestCompleter?.isCompleted ?? false;
      if (timeElapsed > maxWait || (requestComplete && timeElapsed > minWait)) {
        break;
      }
    }
  }
}
