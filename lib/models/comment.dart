import 'package:cloud_firestore/cloud_firestore.dart';

class Comment {
  String id;
  String uid;
  String? text;
  Timestamp? date;

  Comment({required this.id, required this.uid, this.text, this.date});

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "userId": uid,
      "description": text,
      "date": date,
    };
  }

  factory Comment.fromMap(Map<String, dynamic> map) {
    return Comment(
      id: map['id'] as String,
      uid: map['userId'] as String,
      text: map['text'] as String,
      date: map['date'] as Timestamp,
    );
  }
}