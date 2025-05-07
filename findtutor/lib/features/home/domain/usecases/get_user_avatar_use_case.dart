import 'package:dartz/dartz.dart';
import '/core/models/avatar_profile.dart';
import '/core/types/types.dart';
import '/core/usecase/use_case.dart';
import '/features/home/domain/repositories/dashboard.dart';
import '/service_locator.dart';

class GetUserAvatarUseCase
    extends UseCase<Either<Failure, AvatarProfile>, dynamic> {
  @override
  Future<Either<Failure, AvatarProfile>> call({params}) {
    return sl<DashboardRepository>().getUserAvatar();
  }
}
