import 'package:hope_nest/models/comment.dart';

abstract class CommentMethods {
  Future<List<Comment>?>? getCommentByPID({required String pid});// pid : post id
}
