import 'package:flutter/material.dart';
import 'package:hope_nest/models/post.dart';
import 'package:hope_nest/util/constants/navigation_constants.dart';
import 'package:hope_nest/util/methods/dynamic_size.dart';
import 'package:intl/intl.dart';

class PostListContainer extends StatelessWidget {
  final Post post;

  const PostListContainer({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: Container(
          margin: EdgeInsets.only(bottom: DynamicSize.height(context, 0.036)),
          height: DynamicSize.height(context, 0.097),
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.orangeAccent),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(width: 1, color: Colors.orangeAccent),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.network(
                        post.url!,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    "${post.title}",
                    style: const TextStyle(fontSize: 18),
                  ),
                ],
              ),
              Text(
                DateFormat('dd/MM/yyyy').format(post.date.toDate()),
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
        onTap: () {
          Navigator.pushNamed(context, NavigationConstants.POST_PAGE,
              arguments: post);
        });
  }
}
