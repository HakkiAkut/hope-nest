import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  String id;
  String uid;
  String? description;
  String? title;
  Timestamp date;
  String? url;
  bool? isBanned;

  Post(
      {required this.id,
      required this.uid,
      required this.date,
      this.description,
      this.url,
      this.title,
      this.isBanned});

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "userId": uid,
      "date": date,
      "url": url,
      "description": description,
      "title": title,
      "isBanned": isBanned
    };
  }

  factory Post.fromMap(Map<String, dynamic> map) {
    return Post(
      id: map['id'] as String,
      uid: map['userId'] as String,
      date: map['date'] as Timestamp,
      url: map['url'] as String,
      description: map['description'] as String,
      title: map['title'] as String,
      isBanned: map['isBanned'] as bool,
    );
  }
}
