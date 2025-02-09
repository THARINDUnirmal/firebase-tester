import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_fire_base_app/models/task_model.dart';

class DatabaseServices {
  //add Data to firestore !
  Future<void> addTask(String name) async {
    try {
      final CollectionReference ref =
          FirebaseFirestore.instance.collection("task");

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
}
