import 'package:dartz/dartz.dart';
import '/core/usecase/use_case.dart';
import '/features/auth/data/models/signin_response.dart';
import '/features/auth/data/models/signin_req_params.dart';
import '/features/auth/domain/repositories/auth.dart';
import '/service_locator.dart';

class SignInUseCase
    extends UseCase<Either<SignInErrors, SignInResponse>, SignInReqParams> {
  @override
  Future<Either<SignInErrors, SignInResponse>> call({
    SignInReqParams? params,
  }) async {
    return await sl<AuthRepository>().signIn(params!);
  }
}
