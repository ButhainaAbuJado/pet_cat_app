import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/task_model.dart';
import '../model/user_model.dart';

class TaskManagement {
  static final TaskManagement _instance = TaskManagement._private();

  TaskManagement._private();

  factory TaskManagement() {
    return _instance;
  }

  Future<List<QueryDocumentSnapshot<Object?>>> _getTasksResponse() async {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(UserModel.shared.userId)
        .collection('tasks')
        .get()
        .then((value) => value.docs);
  }

  Future<List<Task>> getTasks() async {
    final taskSnapshots = await _getTasksResponse();
    List<Task> tasks = [];
    for (var taskSnapshot in taskSnapshots) {
      tasks.add(Task.fromSnapshot(snapshot: taskSnapshot));
    }
    return tasks;
  }

  delete(String taskId) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(UserModel.shared.userId)
        .collection('tasks')
        .doc(taskId)
        .delete();
  }

// To remove all todos  when clicking on "delete" icon in the appBar
  deleteAll() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(UserModel.shared.userId)
        .collection('tasks')
        .get()
        .then(
      (value) {
        for (var element in value.docs) {
          element.reference.delete();
        }
      },
    );
  }

  changeStatus(bool status, String taskId) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(UserModel.shared.userId)
        .collection('tasks')
        .doc(taskId)
        .update({
      'isCompleted': !status,
    });
  }

  addNewTask(Task task) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(UserModel.shared.userId)
        .collection('tasks')
        .doc(task.id)
        .set({
      'id': task.id,
      'title': task.title,
      'isCompleted': task.status,
    });
  }
}
