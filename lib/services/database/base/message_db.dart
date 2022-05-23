import 'package:hope_nest/models/chatroom.dart';
import 'package:hope_nest/models/messages.dart';

abstract class MessageMethod {
  Stream<List<Messages>>? getMessage({required String cid}); // cid: chatroom id
  Future<bool?> setMessage({required String cid ,required Messages message});
}
