import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_fire_base_app/models/task_model.dart';
import 'package:flutter/material.dart';

class DatabaseServices {
  final CollectionReference ref = FirebaseFirestore.instance.collection("task");
  //add Data to firestore !
  Future<void> addTask(String name) async {
    try {
      final data = TaskModel(
        id: "",
        name: name,
        createDate: DateTime.now(),
        updatedDate: DateTime.now(),
        isUpdated: false,
      );

      final sentData = data.toJson();
      await ref.add(sentData);
    } catch (e) {
      throw Exception("Faild to add data !");
    }
  }

  //fetch all data from fire base using stream
  Stream<List<TaskModel>> fetchAllTask() {
    return ref.snapshots().map(
          (snapshot) => snapshot.docs
              .map((doc) => TaskModel.formJson(
                  doc.data() as Map<String, dynamic>, doc.id))
              .toList(),
        );
  }

  //delete task from data base
  Future<void> deleteData(String id) async {
    try {
      await ref.doc(id).delete();
    } catch (e) {
      print(e.toString());
    }
  }
}
