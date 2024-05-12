import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class GiftRecord extends FirestoreRecord {
  GiftRecord._(
    super.reference,
    super.data,
  ) {
    _initializeFields();
  }

  // "picture" field.
  String? _picture;
  String get picture => _picture ?? '';
  bool hasPicture() => _picture != null;

  // "costGP" field.
  int? _costGP;
  int get costGP => _costGP ?? 0;
  bool hasCostGP() => _costGP != null;

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  bool hasName() => _name != null;

  void _initializeFields() {
    _picture = snapshotData['picture'] as String?;
    _costGP = castToType<int>(snapshotData['costGP']);
    _name = snapshotData['name'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('gift');

  static Stream<GiftRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => GiftRecord.fromSnapshot(s));

  static Future<GiftRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => GiftRecord.fromSnapshot(s));

  static GiftRecord fromSnapshot(DocumentSnapshot snapshot) => GiftRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static GiftRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      GiftRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'GiftRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is GiftRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createGiftRecordData({
  String? picture,
  int? costGP,
  String? name,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'picture': picture,
      'costGP': costGP,
      'name': name,
    }.withoutNulls,
  );

  return firestoreData;
}

class GiftRecordDocumentEquality implements Equality<GiftRecord> {
  const GiftRecordDocumentEquality();

  @override
  bool equals(GiftRecord? e1, GiftRecord? e2) {
    return e1?.picture == e2?.picture &&
        e1?.costGP == e2?.costGP &&
        e1?.name == e2?.name;
  }

  @override
  int hash(GiftRecord? e) =>
      const ListEquality().hash([e?.picture, e?.costGP, e?.name]);

  @override
  bool isValidKey(Object? o) => o is GiftRecord;
}
