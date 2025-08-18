import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'edit_portfolio_widget.dart' show EditPortfolioWidget;
import 'package:flutter/material.dart';

class EditPortfolioModel extends FlutterFlowModel<EditPortfolioWidget> {
  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // Stores action output result for [Backend Call - API (updatePortfolio)] action in Text widget.
  ApiCallResponse? apiResultbgr;
  // State field(s) for name widget.
  FocusNode? nameFocusNode;
  TextEditingController? nameTextController;
  String? Function(BuildContext, String?)? nameTextControllerValidator;
  String? _nameTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return FFLocalizations.of(context).getText(
        'gdbcbiil' /* Title is required */,
      );
    }

    if (!RegExp('^[a-zA-Z ]+\$').hasMatch(val)) {
      return FFLocalizations.of(context).getText(
        'ldpy8bs8' /* 
Only alphabetic characters (... */
        ,
      );
    }
    return null;
  }

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
