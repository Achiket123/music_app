import 'dart:io';
import 'package:fpdart/fpdart.dart';
import 'package:music_app/core/error/exceptions.dart';
import 'package:music_app/core/error/failures.dart';
import 'package:music_app/features/blog/data/datasources/blog_remot_data_source.dart';
import 'package:music_app/features/blog/data/model/blog_model.dart';
import 'package:music_app/features/blog/domain/entities/blog.dart';
import 'package:music_app/features/blog/domain/repositories/blog_repositories.dart';
import 'package:uuid/uuid.dart';

class BlogRepositoryImpl implements BlogRepository {
  final BlogRemoteDataSource blogRemoteDataSource;

  BlogRepositoryImpl({required this.blogRemoteDataSource});
  @override
  Future<Either<Failure, Blog>> uploadBlog(
      {required File image,
      required String title,
      required String content,
      required String posterId,
      required List<String> topics}) async {
    try {
      BlogModel blogModel = BlogModel(
          id: const Uuid().v1(),
          posterId: posterId,
          title: title,
          content: content,
          imageURL: '',
          topics: topics,
          updatedAt: DateTime.now());

      final imageURL = await blogRemoteDataSource.uploadBlogImage(
          image: image, blogModel: blogModel);
      blogModel = blogModel.copyWith(imageURL: imageURL);
      final uploadedBlog = await blogRemoteDataSource.uploadBlog(blogModel);

      return right(uploadedBlog);
    } on ServerException catch (e) {
      return left(Failure(message:e.message));
    }
  }
}
