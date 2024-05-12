import '/flutter_flow/flutter_flow_util.dart';
import 'shop_gift_widget.dart' show ShopGiftWidget;
import 'package:flutter/material.dart';

class ShopGiftModel extends FlutterFlowModel<ShopGiftWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
  }
}
