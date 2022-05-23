class SearchAdvert {
  String? id;
  String? location;
  String? kind;

  SearchAdvert({this.id, this.location, this.kind});

  @override
  String toString() {
    String str = "";

    if (location != null && location != "") {
      str = str + "location:" + location! + ",";
    }
    if (kind != null && kind != "") {
      str = str + "kind:" + kind! + ",";
    }
    print(str);
    return str;
  }
}

class SearchPost {
  String? id;
  String? title;

  SearchPost({this.id, this.title,});

  @override
  String toString() {
    return title ?? "";
  }
}
