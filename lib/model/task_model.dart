import 'package:cloud_firestore/cloud_firestore.dart';

class Task {
  String id;
  String title;
  bool status;

  Task({
    required this.id,
    required this.title,
    required this.status,
  });

  factory Task.fromSnapshot({required QueryDocumentSnapshot snapshot}) {
    return Task(
      id: snapshot.get('id'),
      title: snapshot.get('title'),
      status: snapshot.get('isCompleted'),
    );
  }
}