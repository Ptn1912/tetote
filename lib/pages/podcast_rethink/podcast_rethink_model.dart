import '/flutter_flow/flutter_flow_util.dart';
import 'podcast_rethink_widget.dart' show PodcastRethinkWidget;
import 'package:flutter/material.dart';

class PodcastRethinkModel extends FlutterFlowModel<PodcastRethinkWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
  }
}
