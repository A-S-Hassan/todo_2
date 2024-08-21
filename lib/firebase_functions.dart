import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_2/bottom_sheet/add_task_bottom_sheet.dart';
import 'package:todo_2/models/task_model.dart';

class firebaseFunctions {
 static CollectionReference<TaskModel> getTaskCollection() {
    return FirebaseFirestore.instance
        .collection("tasks")
        .withConverter<TaskModel>(
      fromFirestore: (snapshot, _) {
        return TaskModel.fromJson(snapshot.data()!);
      },
      toFirestore: (task, _) {
        return task.toJson();
      },
    );
  }

  static Future<void> addTask(TaskModel task) {
    var collection = getTaskCollection();
    var docRef = collection.doc();
    task.id = docRef.id;
    return docRef.set(task);
  }

 static Stream<QuerySnapshot<TaskModel>> getTasks(DateTime date){
    var collection = getTaskCollection();
    return collection.where("date" , isEqualTo:DateUtils.dateOnly(date).millisecondsSinceEpoch).snapshots();
  }

  static  Future<void> deleteTask(String id ){
  return getTaskCollection().doc(id).delete();
  }

  static Future<void> updateTask(TaskModel taskModel){
   return getTaskCollection().doc(taskModel.id).update(taskModel.toJson());
  }

}
