import 'dart:io';

import 'package:music_app/core/error/exceptions.dart';
import 'package:music_app/features/blog/data/model/blog_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class BlogRemoteDataSource {
  Future<BlogModel> uploadBlog(BlogModel blog);
  Future<String> uploadBlogImage(
      {required File image, required BlogModel blogModel});

  Future<List<BlogModel>> getAllBlogs();
}

class BlogRemoteDataSourceImpl implements BlogRemoteDataSource {
  final SupabaseClient supabaseClient;

  BlogRemoteDataSourceImpl({required this.supabaseClient});

  @override
  Future<BlogModel> uploadBlog(BlogModel blog) async {
    try {
      final blogData =
          await supabaseClient.from('blogs').insert(blog.toJson()).select();
      return BlogModel.fromjson(blogData.first);
    } on PostgrestException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<String> uploadBlogImage(
      {required File image, required BlogModel blogModel}) async {
    try {
      await supabaseClient.storage
          .from('blog_images')
          .upload(blogModel.id, image);
      return supabaseClient.storage
          .from('blog_images')
          .getPublicUrl(blogModel.id);
    } on StorageException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<BlogModel>> getAllBlogs() async {
    try {
      final blogs =
          await supabaseClient.from('blogs').select('*,profiles (name)');
      return blogs
          .map((blog) => BlogModel.fromjson(blog)
              .copyWith(posterName: blog['profiles']['name']))
          .toList();
    } on PostgrestException catch (e) {
      throw ServerException(e.toString());
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
