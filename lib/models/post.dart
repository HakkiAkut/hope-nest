class Post {
  String id;
  String uid;
  String? description;
  String? title;

  Post({required this.id, required this.uid, this.description, this.title});

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "userId": uid,
      "description": description,
      "name": title,
    };
  }

  factory Post.fromMap(Map<String, dynamic> map) {
    return Post(
      id: map['id'] as String,
      uid: map['userId'] as String,
      description: map['description'] as String,
      title: map['title'] as String,
    );
  }
}
