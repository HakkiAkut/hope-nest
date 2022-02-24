import 'package:cloud_firestore/cloud_firestore.dart';

class Comment {
  String id;
  String uid;
  String pid; // post id
  String? text;
  Timestamp? date;

  Comment(
      {required this.id,
      required this.uid,
      required this.pid,
      this.text,
      this.date});

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "userId": uid,
      "postId": pid,
      "text": text,
      "date": date,
    };
  }

  factory Comment.fromMap(Map<String, dynamic> map) {
    return Comment(
      id: map['id'] as String,
      uid: map['userId'] as String,
      pid: map['postId'] as String,
      text: map['text'] as String,
      date: map['date'] as Timestamp,
    );
  }
}
