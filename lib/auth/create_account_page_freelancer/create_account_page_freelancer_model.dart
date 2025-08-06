import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import '/index.dart';
import 'create_account_page_freelancer_widget.dart'
    show CreateAccountPageFreelancerWidget;
import 'package:flutter/material.dart';

class CreateAccountPageFreelancerModel
    extends FlutterFlowModel<CreateAccountPageFreelancerWidget> {
  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // State field(s) for name widget.
  FocusNode? nameFocusNode;
  TextEditingController? nameTextController;
  String? Function(BuildContext, String?)? nameTextControllerValidator;
  String? _nameTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return FFLocalizations.of(context).getText(
        'k1zpk9g8' /* Only alphabetic characters (A–... */,
      );
    }

    if (!RegExp('^[a-zA-Z ]+\$').hasMatch(val)) {
      return FFLocalizations.of(context).getText(
        '78x7vg53' /* Only alphabetic characters (A–... */,
      );
    }
    return null;
  }

  // State field(s) for email widget.
  FocusNode? emailFocusNode;
  TextEditingController? emailTextController;
  String? Function(BuildContext, String?)? emailTextControllerValidator;
  String? _emailTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return FFLocalizations.of(context).getText(
        'ckbmblx6' /* Email is required */,
      );
    }

    if (!RegExp(kTextValidatorEmailRegex).hasMatch(val)) {
      return FFLocalizations.of(context).getText(
        '387gh9sk' /* please enter valid email */,
      );
    }
    return null;
  }

  // State field(s) for DropDown widget.
  String? dropDownValue;
  FormFieldController<String>? dropDownValueController;
  // State field(s) for title widget.
  FocusNode? titleFocusNode;
  TextEditingController? titleTextController;
  String? Function(BuildContext, String?)? titleTextControllerValidator;
  String? _titleTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return FFLocalizations.of(context).getText(
        'wyh44ppl' /* Job Title is required */,
      );
    }

    if (!RegExp('^[a-zA-Z ]+\$').hasMatch(val)) {
      return FFLocalizations.of(context).getText(
        'npu8tw0v' /* Only alphabetic characters (A–... */,
      );
    }
    return null;
  }

  // State field(s) for password widget.
  FocusNode? passwordFocusNode;
  TextEditingController? passwordTextController;
  late bool passwordVisibility;
  String? Function(BuildContext, String?)? passwordTextControllerValidator;
  String? _passwordTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return FFLocalizations.of(context).getText(
        'ubl35j72' /* Password is required */,
      );
    }

    if (!RegExp('^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[\\W_]).{8,}\$')
        .hasMatch(val)) {
      return FFLocalizations.of(context).getText(
        'umqea9m8' /* Min 8 chars, 1 upper, 1 lower,... */,
      );
    }
    return null;
  }

  // State field(s) for confirm widget.
  FocusNode? confirmFocusNode;
  TextEditingController? confirmTextController;
  late bool confirmVisibility;
  String? Function(BuildContext, String?)? confirmTextControllerValidator;
  // Stores action output result for [Backend Call - API (FreelancerRegistration)] action in Button widget.
  ApiCallResponse? apiResultoe5;

  @override
  void initState(BuildContext context) {
    nameTextControllerValidator = _nameTextControllerValidator;
    emailTextControllerValidator = _emailTextControllerValidator;
    titleTextControllerValidator = _titleTextControllerValidator;
    passwordVisibility = false;
    passwordTextControllerValidator = _passwordTextControllerValidator;
    confirmVisibility = false;
  }

  @override
  void dispose() {
    nameFocusNode?.dispose();
    nameTextController?.dispose();

    emailFocusNode?.dispose();
    emailTextController?.dispose();

    titleFocusNode?.dispose();
    titleTextController?.dispose();

    passwordFocusNode?.dispose();
    passwordTextController?.dispose();

    confirmFocusNode?.dispose();
    confirmTextController?.dispose();
  }
}
