import 'package:dartz/dartz.dart';
import '/core/models/avatar_profile.dart';
import '/core/types/types.dart';
import '/features/home/data/models/dashboard_feed_response.dart';

abstract class DashboardRepository {
  Future<Either<Failure, AvatarProfile>> getUserAvatar();

  FutureEither<DashboardFeed> getDashboardFeed();
}
