// import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class CustomerInfo {
  final String? id;
  final String? name;
  final String? email;
  final String? phone;
  final List<SampleInfo>? samples;

  CustomerInfo({this.id, this.name, this.email, this.phone, this.samples});

  factory CustomerInfo.fromMap(QueryDocumentSnapshot<Object?> json) {
    return CustomerInfo(
      id: json.id,
      name: json['name'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      samples: (json['samples'] as List<dynamic>?)
          ?.map((e) => SampleInfo.fromMap(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'samples': samples?.map((e) => e.toMap()).toList(),
    };
  }
}

class SampleInfo {
  String sampleName;
  String testContent;
  String description;
  String testType;
  String keypoint;
  int cost;

  SampleInfo({
    required this.sampleName,
    required this.testContent,
    required this.description,
    required this.testType,
    required this.keypoint,
    required this.cost,
  });

  factory SampleInfo.fromMap(Map<String, dynamic> json) {
    return SampleInfo(
      sampleName: json['sampleName'] as String,
      cost: json['cost'] as int,
      testContent: json['testContent'] as String,
      description: json['description'] as String,
      testType: json['testType'] as String,
      keypoint: json['keypoint'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'sampleName': sampleName,
      'cost': cost,
      'testContent': testContent,
      'description': description,
      'testType': testType,
      'keypoint': keypoint,
    };
  }
}
