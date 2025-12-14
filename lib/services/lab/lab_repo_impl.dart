import 'package:certispec/models/lab_test.dart';
import 'package:certispec/services/repository/data_source.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LabDataImpl implements DataSource<LabTest> {
  static String mainCollection() => "labs";
  static String secondaryCollection() => "lab";
  static String doc() => "petroleum";

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  @override
  String? get userId => _firebaseAuth.currentUser?.uid;

  @override
  Stream<QuerySnapshot<Object?>> getItems() {
    try {
      final res = _firebaseFirestore
          .collection(mainCollection())
          .doc(doc())
          .collection(secondaryCollection())
          // .equalTo()
          .orderBy("name", descending: false)
          .snapshots();
      return res;
    } on FirebaseException catch (err) {
      throw Exception(err.message);
    }
  }

  @override
  Future<bool> createItem(LabTest data) async {
    try {
      final res = await _firebaseFirestore
          .collection(mainCollection())
          .doc(doc())
          .collection(secondaryCollection())
          .add(data.toJson());
      if (res.id.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } on FirebaseException catch (_) {
      return false;
    }
  }

  @override
  Future<bool> delItem(String id) async {
    try {
      await _firebaseFirestore
          .collection(mainCollection())
          .doc(doc())
          .collection(secondaryCollection())
          .doc(id)
          .delete();
      return true;
    } on FirebaseException catch (_) {
      return false;
    }
  }

  @override
  Future<bool> updateItem(LabTest data) async {
    try {
      await _firebaseFirestore
          .collection(mainCollection())
          .doc(doc())
          .collection(secondaryCollection())
          .doc()
          .set(data.toJson());
      return true;
    } on FirebaseException catch (_) {
      return false;
    }
  }
}
