import '/flutter_flow/flutter_flow_util.dart';
import 'gioi_thieu_widget.dart' show GioiThieuWidget;
import 'package:flutter/material.dart';

class GioiThieuModel extends FlutterFlowModel<GioiThieuWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
  }
}
