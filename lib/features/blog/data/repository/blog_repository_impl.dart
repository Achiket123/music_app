import 'dart:io';
import 'package:fpdart/fpdart.dart';
import 'package:music_app/core/error/exceptions.dart';
import 'package:music_app/core/error/failures.dart';
import 'package:music_app/core/network/connection_checker.dart';
import 'package:music_app/features/auth/data/datasources/blog_local_data_source.dart';
import 'package:music_app/features/blog/data/datasources/blog_remot_data_source.dart';
import 'package:music_app/features/blog/data/model/blog_model.dart';
import 'package:music_app/features/blog/domain/entities/blog.dart';
import 'package:music_app/features/blog/domain/repositories/blog_repositories.dart';
import 'package:uuid/uuid.dart';

class BlogRepositoryImpl implements BlogRepository {
  final BlogRemoteDataSource blogRemoteDataSource;
  final ConnectionChecker connectionChecker;
  BlogRepositoryImpl(this.connectionChecker, this.blogRemoteDataSource);
  @override
  Future<Either<Failure, Blog>> uploadBlog(
      {required File image,
      required String title,
      required String content,
      required String posterId,
      required List<String> topics}) async {
    try {
      if (!await (connectionChecker.isConnected)) {
        return left(Failure(message: 'No Internet'));
      }
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
      return left(Failure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, List<Blog>>> getAllBlog() async {
    try {
      if (!await (connectionChecker.isConnected)) {
        return right([
          Blog(
              id: '1',
              posterId: '',
              title: 'Internet Not Connected',
              content: 'Connect to the internet and try again',
              imageURL: '',
              topics: ['Internet', ' Missing'],
              updatedAt: DateTime.now()),
        ]);
      }
      final blogs = await blogRemoteDataSource.getAllBlogs();
      return right(blogs);
    } on ServerException catch (e) {
      return left(Failure(message: e.toString()));
    }
  }
}
