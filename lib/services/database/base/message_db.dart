import 'package:hope_nest/models/chatroom.dart';
import 'package:hope_nest/models/messages.dart';

abstract class ChatRoomMethod {
  Stream<List<Messages>>? getMessage({required String id,required String Cid}); // cid: chatroom id,  id:: user id
}
