import '/flutter_flow/flutter_flow_util.dart';
import 'mygift_widget.dart' show MygiftWidget;
import 'package:flutter/material.dart';

class MygiftModel extends FlutterFlowModel<MygiftWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
  }
}
