import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'login_page_freelancer_widget.dart' show LoginPageFreelancerWidget;
import 'package:flutter/material.dart';

class LoginPageFreelancerModel
    extends FlutterFlowModel<LoginPageFreelancerWidget> {
  ///  Local state fields for this page.

  bool rememberMe = false;

  String fcmToken = 'test';

  bool isLoading = false;

  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // State field(s) for email widget.
  FocusNode? emailFocusNode;
  TextEditingController? emailTextController;
  String? Function(BuildContext, String?)? emailTextControllerValidator;
  String? _emailTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return FFLocalizations.of(context).getText(
        'unhnwhxm' /* Email is required */,
      );
    }

    if (!RegExp(kTextValidatorEmailRegex).hasMatch(val)) {
      return FFLocalizations.of(context).getText(
        'xhtc37eg' /* Please enter valid email */,
      );
    }
    return null;
  }

  // State field(s) for name widget.
  FocusNode? nameFocusNode;
  TextEditingController? nameTextController;
  late bool nameVisibility;
  String? Function(BuildContext, String?)? nameTextControllerValidator;
  String? _nameTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return FFLocalizations.of(context).getText(
        'c5mh65af' /* Password is required */,
      );
    }

    return null;
  }

  // State field(s) for Checkbox widget.
  bool? checkboxValue;
  // Stores action output result for [Backend Call - API (FreelancerLogin)] action in Button widget.
  ApiCallResponse? loginResponse;
  // Stores action output result for [Backend Call - API (LoginWithSocial)] action in Container widget.
  ApiCallResponse? apiResult1rsApple;
  // Stores action output result for [Backend Call - API (LoginWithSocial)] action in Container widget.
  ApiCallResponse? apiResult1rs;

  @override
  void initState(BuildContext context) {
    emailTextControllerValidator = _emailTextControllerValidator;
    nameVisibility = false;
    nameTextControllerValidator = _nameTextControllerValidator;
  }

  @override
  void dispose() {
    emailFocusNode?.dispose();
    emailTextController?.dispose();

    nameFocusNode?.dispose();
    nameTextController?.dispose();
  }
}
