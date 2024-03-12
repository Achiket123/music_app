import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:music_app/features/blog/domain/entities/blog.dart';

class BlogViewerPage extends StatelessWidget {
  static route(Blog blog) =>
      MaterialPageRoute(builder: (builder) => BlogViewerPage(blog: blog));

  final Blog blog;
  const BlogViewerPage({super.key, required this.blog});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          blog.posterName!,
        ),
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              blog.title,
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 30),
            ),
          ],
        ),
      )),
    );
  }
}
