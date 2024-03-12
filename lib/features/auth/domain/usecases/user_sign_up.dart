import 'package:fpdart/fpdart.dart';
import 'package:music_app/core/error/failures.dart';
import 'package:music_app/core/usecase/usecase.dart';
import 'package:music_app/features/auth/domain/repository/auth_repository.dart';
import 'package:music_app/core/entities/user.dart';

class UserSignUp implements UseCase<User, SignupParams> {
  final AuthRepository authRepository;
  UserSignUp(this.authRepository);

  @override
  Future<Either<Failure, User>> call(SignupParams params) async {
    return await authRepository.signUpwithEmailandPassword(
        name: params.name, email: params.email, password: params.password);
  }
}

class SignupParams {
  final String email;
  final String password;
  final String name;
  SignupParams(
      {required this.email, required this.name, required this.password});
}
