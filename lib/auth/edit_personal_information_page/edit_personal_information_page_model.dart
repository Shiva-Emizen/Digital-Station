import '/flutter_flow/flutter_flow_util.dart';
import 'edit_personal_information_page_widget.dart'
    show EditPersonalInformationPageWidget;
import 'package:flutter/material.dart';

class EditPersonalInformationPageModel
    extends FlutterFlowModel<EditPersonalInformationPageWidget> {
  ///  Local state fields for this page.

  bool isAvatar = false;

  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // State field(s) for name widget.
  FocusNode? nameFocusNode;
  TextEditingController? nameTextController;
  String? Function(BuildContext, String?)? nameTextControllerValidator;
  String? _nameTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return FFLocalizations.of(context).getText(
        'tmvdqm0p' /* Display name is required */,
      );
    }

    if (!RegExp('^[a-zA-Z ]+\$').hasMatch(val)) {
      return FFLocalizations.of(context).getText(
        'd5qazuwc' /* Display name is required */,
      );
    }
    return null;
  }

  // State field(s) for about widget.
  FocusNode? aboutFocusNode;
  TextEditingController? aboutTextController;
  String? Function(BuildContext, String?)? aboutTextControllerValidator;
  String? _aboutTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return FFLocalizations.of(context).getText(
        'yyncnx5n' /* Description is required */,
      );
    }

    return null;
  }

  @override
  void initState(BuildContext context) {
    nameTextControllerValidator = _nameTextControllerValidator;
    aboutTextControllerValidator = _aboutTextControllerValidator;
  }

  @override
  void dispose() {
    nameFocusNode?.dispose();
    nameTextController?.dispose();

    aboutFocusNode?.dispose();
    aboutTextController?.dispose();
  }
}
