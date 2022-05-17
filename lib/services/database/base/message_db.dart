import 'package:hope_nest/models/chatroom.dart';

abstract class ChatRoomMethod {
  Stream<List<ChatRoom>>? getMessage({required String Cid}); // cid: chatroom id
}
