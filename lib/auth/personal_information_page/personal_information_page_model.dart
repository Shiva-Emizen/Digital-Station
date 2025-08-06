import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'personal_information_page_widget.dart'
    show PersonalInformationPageWidget;
import 'package:flutter/material.dart';

class PersonalInformationPageModel
    extends FlutterFlowModel<PersonalInformationPageWidget> {
  ///  Local state fields for this page.

  bool isAvatar = false;

  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  bool isDataUploading_uploadDataByk = false;
  FFUploadedFile uploadedLocalFile_uploadDataByk =
      FFUploadedFile(bytes: Uint8List.fromList([]));

  // Stores action output result for [Backend Call - API (Avatar)] action in Image widget.
  ApiCallResponse? apiResultxpj;
  bool isDataUploading_uploadedMedia = false;
  FFUploadedFile uploadedLocalFile_uploadedMedia =
      FFUploadedFile(bytes: Uint8List.fromList([]));

  // Stores action output result for [Backend Call - API (Avatar)] action in CircleImage widget.
  ApiCallResponse? apiResultklx;
  // State field(s) for name widget.
  FocusNode? nameFocusNode;
  TextEditingController? nameTextController;
  String? Function(BuildContext, String?)? nameTextControllerValidator;
  String? _nameTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return FFLocalizations.of(context).getText(
        '7dcivv59' /* Display name is required */,
      );
    }

    if (!RegExp('^[a-zA-Z ]+\$').hasMatch(val)) {
      return FFLocalizations.of(context).getText(
        'ww3ig3zz' /* Only alphabetic characters (A–... */,
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
        'tmekk5co' /* Description is required */,
      );
    }

    return null;
  }

  // Stores action output result for [Backend Call - API (PersonalInfoUpdate)] action in Button widget.
  ApiCallResponse? apiResulttl8;

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
