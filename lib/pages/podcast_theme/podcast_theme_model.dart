import '/flutter_flow/flutter_flow_util.dart';
import 'podcast_theme_widget.dart' show PodcastThemeWidget;
import 'package:flutter/material.dart';

class PodcastThemeModel extends FlutterFlowModel<PodcastThemeWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
  }
}
