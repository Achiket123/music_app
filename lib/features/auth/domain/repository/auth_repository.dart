import 'package:fpdart/fpdart.dart';
import 'package:music_app/core/error/failures.dart';
import 'package:music_app/core/entities/user.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, User>> signUpwithEmailandPassword(
      {required String name, required String email, required String password});

  Future<Either<Failure, User>> loginWithEmailandPassword(
      {required String email, required String password});

  Future<Either<Failure, User>> currentUser();
}
