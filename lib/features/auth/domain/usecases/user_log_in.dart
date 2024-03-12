
import 'package:fpdart/fpdart.dart';
import 'package:music_app/core/error/failures.dart';
import 'package:music_app/core/usecase/usecase.dart';
import 'package:music_app/features/auth/domain/repository/auth_repository.dart';
import 'package:music_app/core/entities/user.dart';

class UserLogin implements UseCase<User, UserLoginParams> {
  final AuthRepository authRepository;
  const UserLogin(this.authRepository);

  @override
  Future<Either<Failure, User>> call(UserLoginParams params) async {
    return await authRepository.loginWithEmailandPassword(
        email: params.email, password: params.password);
  }
}

class UserLoginParams {
  final String email;
  final String password;

  UserLoginParams({required this.email, required this.password});
}
