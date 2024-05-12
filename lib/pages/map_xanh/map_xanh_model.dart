import '/flutter_flow/flutter_flow_util.dart';
import 'map_xanh_widget.dart' show MapXanhWidget;
import 'package:flutter/material.dart';

class MapXanhModel extends FlutterFlowModel<MapXanhWidget> {
  ///  Local state fields for this page.

  bool displayList = false;

  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;
  // Stores action output result for [Custom Action - getPlaces] action in TextField widget.
  List<dynamic>? placesJSON;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }
}
