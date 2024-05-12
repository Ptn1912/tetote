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

Future doiQua(
  BuildContext context,
  DocumentReference gpCuaToi,
  DocumentReference costGP,
) async {
  // Truy vấn thông tin người gửi
  final myData = await gpCuaToi!.get();
  final myGP = (myData?.get('GP') as int?) ?? 0;
  final myCity = (myData?.get('city') as String?) ?? 0;
  final myEmail = (myData?.get('email') as String?) ?? 0;
  final myName = (myData?.get('display_name') as String?) ?? 0;

  final dataGP = await costGP!.get();
  final cGP = (dataGP?.get('costGP') as int?) ?? 0;
  final cPicture = (dataGP?.get('picture') as String?) ?? 0;
  final cProductID = dataGP?.id;
  final cProductName = (dataGP?.get('name') as String?) ?? 0;
  if (myGP <= cGP) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('You do not have enough GP to change.'),
      ),
    );
    return;
  }

  final batch = FirebaseFirestore.instance.batch();
  batch.update(gpCuaToi!, {'GP': myGP - cGP});

  final transferDoc = FirebaseFirestore.instance.collection('order').doc();
  batch.set(
    transferDoc,
    {
      'city': myCity,
      'costGP': cGP,
      'email': myEmail,
      'picture': cPicture,
      'productID': cProductID,
      'productName': cProductName,
      'user': myName,
    },
  );
  final ordersQuery = await FirebaseFirestore.instance
      .collection('order')
      .where('email', isEqualTo: myEmail)
      .get();

  final numberOfGifts = ordersQuery.docs.length;

  batch.update(gpCuaToi, {'gifts': numberOfGifts + 1});

  // Commit các cập nhật
  await batch.commit();

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text('GP transferred successfully '),
    ),
  );
}
