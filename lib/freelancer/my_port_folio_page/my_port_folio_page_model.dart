import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'my_port_folio_page_widget.dart' show MyPortFolioPageWidget;
import 'package:flutter/material.dart';

class MyPortFolioPageModel extends FlutterFlowModel<MyPortFolioPageWidget> {
  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // Stores action output result for [Backend Call - API (AddPortfolio)] action in Text widget.
  ApiCallResponse? apiResultks3;
  // State field(s) for name widget.
  FocusNode? nameFocusNode;
  TextEditingController? nameTextController;
  String? Function(BuildContext, String?)? nameTextControllerValidator;
  String? _nameTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return FFLocalizations.of(context).getText(
        'xgjjm5ak' /* Title is required */,
      );
    }

    return null;
  }

  bool isDataUploading_uploadDataEx6 = false;
  List<FFUploadedFile> uploadedLocalFiles_uploadDataEx6 = [];

  @override
  void initState(BuildContext context) {
    nameTextControllerValidator = _nameTextControllerValidator;
  }

  @override
  void dispose() {
    nameFocusNode?.dispose();
    nameTextController?.dispose();
  }
}
