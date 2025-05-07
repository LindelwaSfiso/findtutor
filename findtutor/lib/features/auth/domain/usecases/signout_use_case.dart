import 'package:dartz/dartz.dart';
import '/core/usecase/use_case.dart';
import '/features/auth/domain/repositories/auth.dart';
import '/service_locator.dart';

class SignOutUseCase extends UseCase<Either, dynamic> {
  @override
  Future<Either> call({params}) async {
    return await sl<AuthRepository>().signOut();
  }
}
