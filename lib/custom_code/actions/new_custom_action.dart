// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/actions/actions.dart' as action_blocks;
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

Future newCustomAction(
  BuildContext context,
  int transferGP,
  String? message,
  String userEmail,
  DocumentReference? me,
  String otherUserEmail, // Thêm thông tin về địa chỉ email của người nhận
) async {
  // Truy vấn thông tin người gửi
  final myData = await me!.get();
  final myGP = (myData?.get('GP') as int?) ?? 0;

  if (myGP <= transferGP) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('You do not have enough GP to transfer.'),
      ),
    );
    return;
  }

  // Truy vấn thông tin người nhận dựa trên địa chỉ email
  final otherUserData = await FirebaseFirestore.instance
      .collection('users')
      .where('email', isEqualTo: otherUserEmail)
      .limit(1)
      .get();

  if (otherUserData.docs.isNotEmpty) {
    final otherUserDoc = otherUserData.docs.first;
    final otherUserReference = otherUserDoc.reference;

    // Bắt đầu quá trình cập nhật dữ liệu
    final batch = FirebaseFirestore.instance.batch();
    batch.update(me!, {'GP': myGP - transferGP});
    batch.update(otherUserReference, {'GP': FieldValue.increment(transferGP)});

    // Nếu có tin nhắn, thêm vào tài liệu chuyển tiền
    if (message != null) {
      final transferDoc =
          FirebaseFirestore.instance.collection('transaction').doc();
      batch.set(
        transferDoc,
        {
          'from': me,
          'to': otherUserReference,
          'GP': transferGP,
          'message': message,
          'timestamp': FieldValue.serverTimestamp(),
        },
      );
    }

    // Commit các cập nhật
    await batch.commit();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('GP transferred successfully to $otherUserEmail.'),
      ),
    );
  } else {
    // Xử lý trường hợp không tìm thấy người nhận
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Recipient user not found.'),
      ),
    );
  }
}
