import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'create_order_widget.dart' show CreateOrderWidget;
import 'package:flutter/material.dart';

class CreateOrderModel extends FlutterFlowModel<CreateOrderWidget> {
  ///  Local state fields for this page.

  FFUploadedFile? selectedPath;

  bool extraPay = false;

  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;
  String? _textControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return FFLocalizations.of(context).getText(
        'lhygjie0' /* Please add description here */,
      );
    }

    return null;
  }

  bool isDataUploading_uploadDataY0u = false;
  FFUploadedFile uploadedLocalFile_uploadDataY0u =
      FFUploadedFile(bytes: Uint8List.fromList([]));

  // State field(s) for Switch widget.
  bool? switchValue;
  // Stores action output result for [Backend Call - API (CreateOrder)] action in Button widget.
  ApiCallResponse? orderCreatedResponse;
  // Stores action output result for [Braintree Payment] action in Button widget.
  String? transactionId;

  @override
  void initState(BuildContext context) {
    textControllerValidator = _textControllerValidator;
  }

  @override
  void dispose() {
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }
}
