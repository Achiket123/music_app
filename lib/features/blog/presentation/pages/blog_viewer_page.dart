import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:music_app/core/utils/calculate_reading_time.dart';
import 'package:music_app/core/utils/date_formatting.dart';
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
          blog.posterName ?? 'Developer',
        ),
      ),
      body: Scrollbar(
        child: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    blog.title,
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 30),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "- By ${blog.posterName.toString()}",
                style:
                    const TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
              ),
              Text(
                  '${formatDatebydMMMYYYY(blog.updatedAt)}  .  ${calculateReadingTime(blog.content)} min'),
              const SizedBox(
                height: 20,
              ),
              blog.imageURL.isEmpty
                  ? const SizedBox()
                  : Image.network(blog.imageURL),
              const SizedBox(
                height: 20,
              ),
              Text(
                blog.content,
                style: const TextStyle(fontSize: 16, height: 2),
              )
            ],
          ),
        )),
      ),
    );
  }
}
