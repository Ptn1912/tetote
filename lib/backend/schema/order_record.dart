import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class OrderRecord extends FirestoreRecord {
  OrderRecord._(
    super.reference,
    super.data,
  ) {
    _initializeFields();
  }

  // "user" field.
  String? _user;
  String get user => _user ?? '';
  bool hasUser() => _user != null;

  // "productID" field.
  String? _productID;
  String get productID => _productID ?? '';
  bool hasProductID() => _productID != null;

  // "city" field.
  String? _city;
  String get city => _city ?? '';
  bool hasCity() => _city != null;

  // "email" field.
  String? _email;
  String get email => _email ?? '';
  bool hasEmail() => _email != null;

  // "costGP" field.
  int? _costGP;
  int get costGP => _costGP ?? 0;
  bool hasCostGP() => _costGP != null;

  // "productName" field.
  String? _productName;
  String get productName => _productName ?? '';
  bool hasProductName() => _productName != null;

  // "picture" field.
  String? _picture;
  String get picture => _picture ?? '';
  bool hasPicture() => _picture != null;

  void _initializeFields() {
    _user = snapshotData['user'] as String?;
    _productID = snapshotData['productID'] as String?;
    _city = snapshotData['city'] as String?;
    _email = snapshotData['email'] as String?;
    _costGP = castToType<int>(snapshotData['costGP']);
    _productName = snapshotData['productName'] as String?;
    _picture = snapshotData['picture'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('order');

  static Stream<OrderRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => OrderRecord.fromSnapshot(s));

  static Future<OrderRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => OrderRecord.fromSnapshot(s));

  static OrderRecord fromSnapshot(DocumentSnapshot snapshot) => OrderRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static OrderRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      OrderRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'OrderRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is OrderRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createOrderRecordData({
  String? user,
  String? productID,
  String? city,
  String? email,
  int? costGP,
  String? productName,
  String? picture,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'user': user,
      'productID': productID,
      'city': city,
      'email': email,
      'costGP': costGP,
      'productName': productName,
      'picture': picture,
    }.withoutNulls,
  );

  return firestoreData;
}

class OrderRecordDocumentEquality implements Equality<OrderRecord> {
  const OrderRecordDocumentEquality();

  @override
  bool equals(OrderRecord? e1, OrderRecord? e2) {
    return e1?.user == e2?.user &&
        e1?.productID == e2?.productID &&
        e1?.city == e2?.city &&
        e1?.email == e2?.email &&
        e1?.costGP == e2?.costGP &&
        e1?.productName == e2?.productName &&
        e1?.picture == e2?.picture;
  }

  @override
  int hash(OrderRecord? e) => const ListEquality().hash([
        e?.user,
        e?.productID,
        e?.city,
        e?.email,
        e?.costGP,
        e?.productName,
        e?.picture
      ]);

  @override
  bool isValidKey(Object? o) => o is OrderRecord;
}
