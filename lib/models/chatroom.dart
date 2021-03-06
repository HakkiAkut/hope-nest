import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hope_nest/models/messages.dart';

class ChatRoom {
  late String id;
  late Messages? messages;
  String? last_message;
  late Timestamp time;
  late List<dynamic> users;
  late List<dynamic> names;

  ChatRoom(
      {required this.id,
        required this.time,
        required this.last_message,
        required this.users,
        required this.names,
        this.messages});

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "time": time,
      "users": users,
      "names": names,
      "last_message": last_message,
      "messages": messages,
    };
  }

  factory ChatRoom.fromMap(Map<String, dynamic> map) {
    return ChatRoom(
      id: map['id'] as String,
      //messages: map['messages'] as Messages,
      last_message: map['last_message'] as String,
      time: map['time'] as Timestamp,
      users: map['users'] as List<dynamic>,
      names: map['names'] as List<dynamic>,
    );
  }
}
