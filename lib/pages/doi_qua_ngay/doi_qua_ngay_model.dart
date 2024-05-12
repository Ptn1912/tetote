import '/flutter_flow/flutter_flow_util.dart';
import 'doi_qua_ngay_widget.dart' show DoiQuaNgayWidget;
import 'package:flutter/material.dart';

class DoiQuaNgayModel extends FlutterFlowModel<DoiQuaNgayWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
  }
}
