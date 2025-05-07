import 'package:get_it/get_it.dart';
import '/core/api/api_client.dart';
import '/core/api/dio_client.dart';
import '/features/auth/data/repositories/auth.dart';
import '/features/auth/domain/repositories/auth.dart';
import '/features/auth/domain/usecases/is_logged_in.dart';
import '/features/auth/domain/usecases/signin.dart';
import '/features/auth/domain/usecases/signout_use_case.dart';
import '/features/auth/domain/usecases/signup.dart';
import '/features/notifications/domain/repositories/notifications.dart';
import '/features/notifications/domain/usecases/get_notifications.dart';
import '/features/forum/domain/usecases/get_forums.dart';
import '/features/forum/domain/usecases/create_forum.dart';
import '/features/forum/domain/usecases/join_forum.dart';
import '/features/forum/domain/usecases/leave_forum.dart';
import '/features/forum/domain/usecases/follow_forum.dart';
import '/features/forum/domain/usecases/unfollow_forum.dart';
import '/features/forum/domain/usecases/like_post.dart';
import '/features/forum/domain/usecases/unlike_post.dart';

import 'features/forum/data/repositories/forum.dart';
import 'features/forum/domain/repositories/forum.dart';
import 'features/home/data/repositories/dashboard.dart';
import 'features/home/domain/repositories/dashboard.dart';
import 'features/home/domain/usecases/get_dashboard_feed_use_case.dart';
import 'features/home/domain/usecases/get_user_avatar_use_case.dart';
import 'features/notifications/data/repositories/notifications.dart';
import 'features/profile/data/repositories/profile.dart';
import 'features/profile/domain/repositories/profile.dart';
import 'features/profile/domain/usecases/get_user_profile.dart';
import 'features/profile/domain/usecases/update_user_profile.dart';

final sl = GetIt.instance;

void setUpServiceLocator() {
  /* appwrite */
  final dio = buildDioClient();
  sl.registerLazySingleton<RestClient>(() => RestClient(dio));

  /* repositories */
  sl.registerSingleton<AuthRepository>(AuthRepositoryImpl());
  sl.registerSingleton<DashboardRepository>(DashboardRepositoryImpl());
  sl.registerSingleton<ProfileRepository>(ProfileRepositoryImpl());
  sl.registerSingleton<NotificationsRepository>(NotificationsRepositoryImpl());

  /* forum dependencies */
  sl.registerLazySingleton<ForumRepository>(() => ForumRepositoryImpl());
  sl.registerLazySingleton<GetForums>(() => GetForums());
  sl.registerLazySingleton<CreateForum>(() => CreateForum());
  sl.registerLazySingleton<JoinForum>(() => JoinForum());
  sl.registerLazySingleton<LeaveForum>(() => LeaveForum());
  sl.registerLazySingleton<FollowForum>(() => FollowForum());
  sl.registerLazySingleton<UnfollowForum>(() => UnfollowForum());
  sl.registerLazySingleton<LikePost>(() => LikePost());
  sl.registerLazySingleton<UnlikePost>(() => UnlikePost());

  /* use-cases */
  sl.registerSingleton<IsLoggedInUseCase>(IsLoggedInUseCase());
  sl.registerSingleton<SignInUseCase>(SignInUseCase());
  sl.registerSingleton<SignUpUseCase>(SignUpUseCase());
  sl.registerSingleton<SignOutUseCase>(SignOutUseCase());
  //
  sl.registerSingleton<GetUserAvatarUseCase>(GetUserAvatarUseCase());
  sl.registerSingleton<GetDashboardFeedUseCase>(GetDashboardFeedUseCase());
  //
  sl.registerSingleton<GetUserProfileUseCase>(GetUserProfileUseCase());
  sl.registerSingleton<UpdateUserProfileUseCase>(UpdateUserProfileUseCase());
  //
  sl.registerSingleton<GetNotificationsUseCase>(GetNotificationsUseCase());
}
