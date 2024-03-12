import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:music_app/core/theme/app_pallete.dart';
import 'package:music_app/core/utils/calculate_reading_time.dart';
import 'package:music_app/features/blog/domain/entities/blog.dart';

class BlogCard extends StatelessWidget {
  final Blog blog;
  final Color color;
  const BlogCard({super.key, required this.blog, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.all(16).copyWith(bottom: 4),
      height: 200,
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(10)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: blog.topics
                      .map((e) => Padding(
                            padding: const EdgeInsets.only(top: 5, right: 5),
                            child: Chip(
                              label: Text(e),
                              color: const MaterialStatePropertyAll(
                                AppPallete.backgroundColor,
                              ),
                              side: const BorderSide(
                                  color: AppPallete.borderColor),
                            ),
                          ))
                      .toList(),
                ),
              ),
              Text(
                blog.title,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
              ),
            ],
          ),
          Text("${calculateReadingTime(blog.content)} min"),
        ],
      ),
    );
  }
}
