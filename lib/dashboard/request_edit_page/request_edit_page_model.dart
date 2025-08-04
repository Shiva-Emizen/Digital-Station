import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'request_edit_page_widget.dart' show RequestEditPageWidget;
import 'package:flutter/material.dart';

class RequestEditPageModel extends FlutterFlowModel<RequestEditPageWidget> {
  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;
  bool isDataUploading_uploadDataCsz = false;
  FFUploadedFile uploadedLocalFile_uploadDataCsz =
      FFUploadedFile(bytes: Uint8List.fromList([]));

  // Stores action output result for [Backend Call - API (UpdateOrder)] action in Button widget.
  ApiCallResponse? orderCreatedResponse;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }
}
