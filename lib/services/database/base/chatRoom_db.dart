import 'package:hope_nest/models/chatroom.dart';

abstract class ChatRoomMethod {
  Stream<List<ChatRoom>>? getChatRoom({required String id});
  Future<bool?> setChatRoom({required ChatRoom chatroom});
}
