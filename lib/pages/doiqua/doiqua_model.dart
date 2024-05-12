import '/flutter_flow/flutter_flow_util.dart';
import 'doiqua_widget.dart' show DoiquaWidget;
import 'package:flutter/material.dart';

class DoiquaModel extends FlutterFlowModel<DoiquaWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
  }
}
