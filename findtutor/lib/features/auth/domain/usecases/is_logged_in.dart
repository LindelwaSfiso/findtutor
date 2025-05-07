import '/core/usecase/use_case.dart';
import '/features/auth/domain/repositories/auth.dart';
import '/service_locator.dart';

class IsLoggedInUseCase extends UseCase<bool, dynamic> {
  @override
  Future<bool> call({params}) async {
    return await sl<AuthRepository>().isLoggedIn();
  }
}
