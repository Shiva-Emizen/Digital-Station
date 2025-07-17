import '/flutter_flow/flutter_flow_util.dart';
import 'request_edit_page_widget.dart' show RequestEditPageWidget;
import 'package:flutter/material.dart';

class RequestEditPageModel extends FlutterFlowModel<RequestEditPageWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }
}
