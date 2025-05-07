import 'package:dartz/dartz.dart';
import '/core/types/types.dart';
import '/features/auth/data/models/signin_response.dart';
import '/features/auth/data/models/signin_req_params.dart';
import '/features/auth/data/models/signup_req_params.dart';
import '/features/auth/data/models/signup_response.dart';

abstract class AuthRepository {
  Future<Either<SignInErrors, SignInResponse>> signIn(SignInReqParams params);

  Future<Either<SignUpErrors, SignUpResponse>> signUp(SignUpReqParams params);

  Future<bool> isLoggedIn();

  FutureEitherVoid signOut();
}
