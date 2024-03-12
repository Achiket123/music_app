import 'package:fpdart/fpdart.dart';
import 'package:music_app/core/error/failures.dart';
import 'package:music_app/core/usecase/usecase.dart';
import 'package:music_app/core/entities/user.dart';
import 'package:music_app/features/auth/domain/repository/auth_repository.dart';

class CurrentUser implements UseCase<User, NoParams> {
  final AuthRepository authRepository;

  CurrentUser( this.authRepository);

  @override
  Future<Either<Failure, User>> call(NoParams params) async {
    return await authRepository.currentUser();
  }
}
