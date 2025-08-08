import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'create_order_widget.dart' show CreateOrderWidget;
import 'package:flutter/material.dart';

class CreateOrderModel extends FlutterFlowModel<CreateOrderWidget> {
  ///  Local state fields for this page.

  FFUploadedFile? selectedPath;

  bool extraPay = false;

  dynamic amountDetails;

  List<dynamic> productList = [];
  void addToProductList(dynamic item) => productList.add(item);
  void removeFromProductList(dynamic item) => productList.remove(item);
  void removeAtIndexFromProductList(int index) => productList.removeAt(index);
  void insertAtIndexInProductList(int index, dynamic item) =>
      productList.insert(index, item);
  void updateProductListAtIndex(int index, Function(dynamic) updateFn) =>
      productList[index] = updateFn(productList[index]);

  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;
  bool isDataUploading_uploadDataY0u = false;
  FFUploadedFile uploadedLocalFile_uploadDataY0u =
      FFUploadedFile(bytes: Uint8List.fromList([]));

  // State field(s) for Switch widget.
  bool? switchValue;
  // Stores action output result for [Backend Call - API (CreateOrder)] action in Button widget.
  ApiCallResponse? orderCreatedResponse;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }
}
