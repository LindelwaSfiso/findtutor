import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '/core/api/api_client.dart';
import '/core/api/dio_client.dart';
import '/core/types/types.dart';
import '/features/auth/data/models/signin_response.dart';
import '/features/auth/data/models/signin_req_params.dart';
import '/features/auth/data/models/signup_req_params.dart';
import '/features/auth/data/models/signup_response.dart';
import '/features/auth/domain/repositories/auth.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class AuthRepositoryImpl extends AuthRepository {
  final authClient = RestClient(buildAuthDioClient());

  @override
  Future<bool> isLoggedIn() async {
    try {
      const storage = FlutterSecureStorage();
      var token = await storage.read(key: "access");

      if (token != null) {
        final bool isExpired = JwtDecoder.isExpired(token);

        if (!isExpired) {
          // user has a valid token, automatically log user in
          return Future(() => true);
        }
      }
      return Future(() => false);
    } on Exception catch (_) {
      return Future(() => false);
    }
  }

  @override
  Future<Either<SignInErrors, SignInResponse>> signIn(
    SignInReqParams params,
  ) async {
    try {
      final response = await authClient.authenticate(params);
      const storage = FlutterSecureStorage();
      await storage.write(key: "access", value: response.access);
      await storage.write(key: "refresh", value: response.refresh);
      return Right(response);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        return const Left(
          SignInErrors(username: ["Connection timeout. Please try again."]),
        );
      }
      if (e.response?.data != null &&
          e.response?.data is Map<String, dynamic>) {
        return Left(
          SignInErrors.fromJson(e.response?.data as Map<String, dynamic>),
        );
      }
      return const Left(SignInErrors(username: ["Failed to authenticate."]));
    } on Exception catch (_) {
      return const Left(SignInErrors(username: ["Failed to authenticate."]));
    }
  }

  @override
  Future<Either<SignUpErrors, SignUpResponse>> signUp(
    SignUpReqParams params,
  ) async {
    try {
      final response = await authClient.signUp(params);
      return Right(response);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        return Left(
          SignUpErrors(
            user: SignUpUserError(
              username: ["Connection timeout. Please try again."],
            ),
          ),
        );
      }
      if (e.response?.data != null &&
          e.response?.data is Map<String, dynamic>) {
        return Left(
          SignUpErrors.fromJson(e.response?.data as Map<String, dynamic>),
        );
      }
      return Left(
        SignUpErrors(
          user: SignUpUserError(username: ["Failed to create account."]),
        ),
      );
    } on Exception catch (_) {
      return Left(
        SignUpErrors(
          user: SignUpUserError(username: ["Failed to create account."]),
        ),
      );
    }
  }

  @override
  FutureEitherVoid signOut() async {
    try {
      const storage = FlutterSecureStorage();
      await storage.deleteAll();
    } on Exception catch (_) {}

    return Future(() => const Right(null));
  }
}
