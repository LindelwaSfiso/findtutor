import 'package:dartz/dartz.dart';
import '/core/api/api_client.dart';
import '/core/models/avatar_profile.dart';
import '/core/types/types.dart';
import '/features/home/data/models/dashboard_feed_response.dart';
import '/features/home/domain/repositories/dashboard.dart';
import '/service_locator.dart';

class DashboardRepositoryImpl extends DashboardRepository {
  final restClient = sl<RestClient>();

  @override
  FutureEither<DashboardFeed> getDashboardFeed() async {
    try {
      final dashboardFeed = await restClient.getDashboardFeed();
      return Right(dashboardFeed);
    } catch (_) {
      return const Left(Failure("Failed to get dashboard feed. Try again later.", null));
    }
  }

  @override
  Future<Either<Failure, AvatarProfile>> getUserAvatar() async {
    try {
      final avatar = await restClient.getUserAvatar();
      return Right(avatar);
    } catch (_) {
      return const Left(
        Failure("Failed to load user profile. Try to refresh.", null),
      );
    }
  }
}
