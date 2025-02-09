import 'package:cloud_firestore/cloud_firestore.dart';

class TaskModel {
  String id;
  String name;
  DateTime createDate;
  DateTime updatedDate;
  bool isUpdated;

  TaskModel({
    required this.id,
    required this.name,
    required this.createDate,
    required this.updatedDate,
    required this.isUpdated,
  });

  factory TaskModel.formJson(Map<String, dynamic> doc, String id) {
    return TaskModel(
      id: id,
      name: doc["name"],
      createDate: (doc["cretedDate"] as Timestamp).toDate(),
      updatedDate: (doc["updatedDate"] as Timestamp).toDate(),
      isUpdated: doc["isUpdate"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "cretedDate": createDate,
      "updatedDate": updatedDate,
      "isUpdate": isUpdated,
    };
  }
}
