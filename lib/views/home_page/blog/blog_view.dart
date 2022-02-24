import 'package:flutter/material.dart';
import 'package:hope_nest/models/post.dart';
import 'package:hope_nest/util/constants/navigation_constants.dart';
import 'package:hope_nest/util/constants/palette.dart';
import 'package:provider/provider.dart';

class BlogView extends StatefulWidget {
  const BlogView({Key? key}) : super(key: key);

  @override
  _BlogViewState createState() => _BlogViewState();
}

class _BlogViewState extends State<BlogView> {
  @override
  Widget build(BuildContext context) {
    final _postsVM = Provider.of<List<Post>>(context);
    return Scaffold(
      body: ListView.builder(
          itemCount: _postsVM.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              color: Palette.MAIN_COLOR_BLUE,
              child: ListTile(
                title: Text("${_postsVM[index].title}"),
                trailing: Text("${_postsVM[index].date}"),
                onTap: () {
                  Navigator.pushNamed(context, NavigationConstants.POST_PAGE,
                      arguments: _postsVM[index]);
                },
              ),
            );
          }),
    );
  }
}
