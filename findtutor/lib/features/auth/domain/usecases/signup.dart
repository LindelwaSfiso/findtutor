import 'package:dartz/dartz.dart';
import '/core/usecase/use_case.dart';
import '/features/auth/data/models/signup_req_params.dart';
import '/features/auth/data/models/signup_response.dart';
import '/features/auth/domain/repositories/auth.dart';
import '/service_locator.dart';

class SignUpUseCase
    extends UseCase<Either<SignUpErrors, SignUpResponse>, SignUpReqParams> {
  @override
  Future<Either<SignUpErrors, SignUpResponse>> call({
    SignUpReqParams? params,
  }) async {
    return await sl<AuthRepository>().signUp(params!);
  }
}
