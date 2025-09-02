import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import '/index.dart';
import 'add_pakage_page_widget.dart' show AddPakagePageWidget;
import 'package:flutter/material.dart';

class AddPakagePageModel extends FlutterFlowModel<AddPakagePageWidget> {
  ///  Local state fields for this page.

  String expDelivery = '0';

  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // State field(s) for title widget.
  FocusNode? titleFocusNode;
  TextEditingController? titleTextController;
  String? Function(BuildContext, String?)? titleTextControllerValidator;
  String? _titleTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return FFLocalizations.of(context).getText(
        '5k2nyf8g' /* Pakage title is required */,
      );
    }

    return null;
  }

  // State field(s) for description widget.
  FocusNode? descriptionFocusNode;
  TextEditingController? descriptionTextController;
  String? Function(BuildContext, String?)? descriptionTextControllerValidator;
  String? _descriptionTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return FFLocalizations.of(context).getText(
        'ics8n1dy' /* Description is required */,
      );
    }

    return null;
  }

  // State field(s) for price widget.
  FocusNode? priceFocusNode;
  TextEditingController? priceTextController;
  String? Function(BuildContext, String?)? priceTextControllerValidator;
  String? _priceTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return FFLocalizations.of(context).getText(
        '67lfin7i' /* Price is required */,
      );
    }

    return null;
  }

  // State field(s) for DropDown widget.
  String? dropDownValue;
  FormFieldController<String>? dropDownValueController;
  // State field(s) for Switch widget.
  bool? switchValue;
  // State field(s) for amount widget.
  FocusNode? amountFocusNode;
  TextEditingController? amountTextController;
  String? Function(BuildContext, String?)? amountTextControllerValidator;
  String? _amountTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return FFLocalizations.of(context).getText(
        'z4huyg7f' /* Price is required */,
      );
    }

    return null;
  }


  FocusNode? deliveryFocusNode;
  TextEditingController? deliveryTextController;
  String? Function(BuildContext, String?)? deliveryTextControllerValidator;
  String? _deliveryTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return FFLocalizations.of(context).getText(
        'z4huyg7g' /* Price is required */,
      );
    }

    return null;
  }






  // State field(s) for revision widget.
  FocusNode? revisionFocusNode;
  TextEditingController? revisionTextController;
  String? Function(BuildContext, String?)? revisionTextControllerValidator;
  String? _revisionTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return FFLocalizations.of(context).getText(
        '8wcog162' /* Revisions is required */,
      );
    }

    return null;
  }

  // Stores action output result for [Backend Call - API (AddPackages)] action in Button widget.
  ApiCallResponse? apiResultlvw;

  @override
  void initState(BuildContext context) {
    titleTextControllerValidator = _titleTextControllerValidator;
    descriptionTextControllerValidator = _descriptionTextControllerValidator;
    priceTextControllerValidator = _priceTextControllerValidator;
    amountTextControllerValidator = _amountTextControllerValidator;
    deliveryTextControllerValidator = _deliveryTextControllerValidator;
    revisionTextControllerValidator = _revisionTextControllerValidator;
  }

  @override
  void dispose() {
    titleFocusNode?.dispose();
    titleTextController?.dispose();

    descriptionFocusNode?.dispose();
    descriptionTextController?.dispose();

    priceFocusNode?.dispose();
    priceTextController?.dispose();

    amountFocusNode?.dispose();
    amountTextController?.dispose();

    revisionFocusNode?.dispose();
    revisionTextController?.dispose();
  }
}
