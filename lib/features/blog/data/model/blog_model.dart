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
    super.posterName,
  });

  Map<String, dynamic> toJson() {
    print(' kya ho ');
    return <String, dynamic>{
      'id': id,
      'poster_id': posterId,
      'title': title,
      'content': content,
      'image_url': imageURL,
      'topics': topics,
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  factory BlogModel.fromjson(Map<String, dynamic> map) {
    return BlogModel(
        id: "${map['id']}",
        posterId: "${map['poster_id']}",
        title: "${map['title']}",
        content: "${map['content']}",
        imageURL: "${map['image_url']}",
        topics: List<String>.from(map['topics'] ?? []),
        updatedAt: map['updated_at'] == null
            ? DateTime.parse(map['update_at'])
            : DateTime.now()); // List. from // Blog Expected to find ')'.
  }

  BlogModel copyWith({
    String? id,
    String? posterId,
    String? title,
    String? content,
    String? imageURL,
    List<String>? topics,
    DateTime? updatedAt,
    String? posterName,
  }) {
    print('erroe');
    return BlogModel(
      id: id ?? this.id,
      posterId: posterId ?? this.posterId,
      title: title ?? this.title,
      content: content ?? this.content,
      imageURL: imageURL ?? this.imageURL,
      topics: topics ?? this.topics,
      updatedAt: updatedAt ?? this.updatedAt,
      posterName: posterName?? this.posterName,
    );
  }
}
