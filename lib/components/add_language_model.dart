import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'add_language_widget.dart' show AddLanguageWidget;
import 'package:flutter/material.dart';

class AddLanguageModel extends FlutterFlowModel<AddLanguageWidget> {
  ///  State fields for stateful widgets in this component.

  final formKey = GlobalKey<FormState>();
  // State field(s) for DropDown widget.
  String? dropDownValue;
  FormFieldController<String>? dropDownValueController;
  // Stores action output result for [Backend Call - API (AddLanguage)] action in Button widget.
  ApiCallResponse? apiResultzgb;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
