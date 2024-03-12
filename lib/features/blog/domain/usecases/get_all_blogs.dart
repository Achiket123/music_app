import 'package:fpdart/src/either.dart';
import 'package:music_app/core/error/failures.dart';
import 'package:music_app/core/usecase/usecase.dart';
import 'package:music_app/features/blog/domain/entities/blog.dart';
import 'package:music_app/features/blog/domain/repositories/blog_repositories.dart';

class GetAllBlogs implements UseCase<List<Blog>, NoParams> {
  final BlogRepository blogRepository;

  GetAllBlogs({required this.blogRepository});

  @override
  Future<Either<Failure, List<Blog>>> call(NoParams params) async {
    return await blogRepository.getAllBlog();
  }
}
