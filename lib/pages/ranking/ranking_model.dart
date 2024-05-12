import '/flutter_flow/flutter_flow_util.dart';
import 'ranking_widget.dart' show RankingWidget;
import 'package:flutter/material.dart';

class RankingModel extends FlutterFlowModel<RankingWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
  }
}
