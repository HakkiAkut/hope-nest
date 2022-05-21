import 'package:hope_nest/models/post.dart';

abstract class BlogMethods {
  Stream<List<Post>>? getPosts();
  Future<Post?> getPostByID({required String id});
  Future<bool?> setPost({required Post post});
}
