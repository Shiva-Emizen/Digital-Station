import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'add_occupation_widget.dart' show AddOccupationWidget;
import 'package:flutter/material.dart';

class AddOccupationModel extends FlutterFlowModel<AddOccupationWidget> {
  ///  State fields for stateful widgets in this component.

  final formKey = GlobalKey<FormState>();
  // State field(s) for DropDown widget.
  String? dropDownValue;
  FormFieldController<String>? dropDownValueController;
  // Stores action output result for [Backend Call - API (Occupation)] action in Button widget.
  ApiCallResponse? apiResultros;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
