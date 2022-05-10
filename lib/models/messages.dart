import 'package:cloud_firestore/cloud_firestore.dart';

class Messages {
  String id;
  String from;
  String to;
  String? message;
  Timestamp time;

  Messages(
      {required this.id,
        required this.from,
        required this.time,
        required this.to,
        this.message});

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "from": from,
      "time": time,
      "message": message,
      "to": to,
    };
  }

  factory Messages.fromMap(Map<String, dynamic> map) {
    return Messages(
      id: map['id'] as String,
      from: map['from'] as String,
      to: map['to'] as String,
      time: map['time'] as Timestamp,
      message: map['message'] as String,
    );
  }
}
