import 'package:certispec/models/customer_info.dart';
import 'package:certispec/services/repository/data_source.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CustomerInfoImpl implements DataSource<CustomerInfo> {
  static String mainCollection() => "customers";
  static String secondaryCollection() => "customer";
  static String doc() => "customerData";

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  @override
  String? get userId => _firebaseAuth.currentUser?.uid;
  @override
  Future<bool> createItem(CustomerInfo data) async {
    try {
      await FirebaseFirestore.instance
          .collection(mainCollection())
          .doc(doc())
          .collection(secondaryCollection())
          .add(data.toMap());
      return true;
    } catch (e) {
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
  Future<bool> updateItem(CustomerInfo data) async {
    try {
      final query = await _firebaseFirestore
          .collection(mainCollection())
          .doc(doc())
          .collection(secondaryCollection())
          .where('email', isEqualTo: data.email)
          .get();

      if (query.docs.isNotEmpty) {
        final docId = query.docs.first.id;
        await _firebaseFirestore
            .collection(mainCollection())
            .doc(doc())
            .collection(secondaryCollection())
            .doc(docId)
            .update(data.toMap());
        return true;
      } else {
        return false;
      }
    } on FirebaseException catch (_) {
      return false;
    }
  }
}
