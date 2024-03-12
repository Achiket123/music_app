import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:music_app/core/error/failures.dart';
import 'package:music_app/core/usecase/usecase.dart';
import 'package:music_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:music_app/features/blog/domain/entities/blog.dart';
import 'package:music_app/features/blog/domain/usecases/get_all_blogs.dart';
import 'package:music_app/features/blog/domain/usecases/upload_blog.dart';

part 'blog_event.dart';
part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final UploadBlog _uploadBlog;
  final GetAllBlogs _allBlogs;
  BlogBloc({required UploadBlog uploadBlog, required GetAllBlogs allBlog})
      : _allBlogs = allBlog,
        _uploadBlog = uploadBlog,
        super(BlogInitial()) {
    on<BlogEvent>((event, emit) => emit(BlogLoading()));

    on<BlogUpload>(_onBlogUpload);

    on<FetchAllBlogs>(_onFetchAllBlogs);
  }

  void _onBlogUpload(BlogUpload event, Emitter<BlogState> emit) async {
    final res = await _uploadBlog(UploadBlogParams(
        posterId: event.posterId,
        title: event.title,
        content: event.content,
        image: event.image,
        topics: event.topics));
    print('object');
    res.fold((l) => emit(BlogFailure(error: l.message)),
        (r) => emit(BlogUploadSuccess()));
  }

  void _onFetchAllBlogs(FetchAllBlogs event, Emitter<BlogState> emit) async {
    final res = await _allBlogs(NoParams());
    res.fold((l) => emit(BlogFailure(error: l.message)),
        (r) => emit(BlogDisplaySuccess(r)));
  }
}
