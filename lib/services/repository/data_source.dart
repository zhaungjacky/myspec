import 'package:cloud_firestore/cloud_firestore.dart';

abstract interface class DataSource<T> {
  // Future<void> initialize();
  Stream<QuerySnapshot<Object?>> getItems();
  Future<bool> updateItem(T data);
  Future<bool> createItem(T data);
  Future<bool> delItem(String id);
  String? get userId;
}
