import 'package:dartz/dartz.dart';
import '/core/types/types.dart';
import '/core/usecase/use_case.dart';
import '/features/home/data/models/dashboard_feed_response.dart';
import '/features/home/domain/repositories/dashboard.dart';
import '/service_locator.dart';

class GetDashboardFeedUseCase extends UseCase<Either<Failure, DashboardFeed>, dynamic> {
  @override
  FutureEither<DashboardFeed> call({params}) {
    return sl<DashboardRepository>().getDashboardFeed();
  }
}
