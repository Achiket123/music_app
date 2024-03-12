import 'package:music_app/features/blog/domain/entities/blog.dart';

class BlogModel extends Blog {
  BlogModel({
    required super.id,
    required super.posterId,
    required super.title,
    required super.content,
    required super.imageURL,
    required super.topics,
    required super.updatedAt,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'posterId': posterId,
      'title': title,
      'content': content,
      'imageUrl': imageURL,
      'topics': topics,
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  factory BlogModel.fromjson(Map<String, dynamic> map) {
    return BlogModel(
        id: map['id'] as String,
        posterId: map['posterId'] as String,
        title: map['title'] as String,
        content: map['content'] as String,
        imageURL: map['imageURL'] as String,
        topics: List<String>.from(map['topics'] ?? []),
        updatedAt: map['updatedAt'] == null
            ? DateTime.now()
            : DateTime.parse(
                map['updateAt'])); // List. from // Blog Expected to find ')'.
  }


  
BlogModel copyWith({
String? id,
String? posterId,
String? title,
String? content,
String? imageURL,
List<String>? topics,
DateTime? updatedAt,
}) {
return BlogModel (
id: id ?? this.id,
posterId: posterId ?? this.posterId,
title: title ?? this.title,
content: content ?? this.content,
imageURL: imageURL ?? this.imageURL,
topics: topics ?? this.topics,
updatedAt: updatedAt ?? this.updatedAt,
);}
}
