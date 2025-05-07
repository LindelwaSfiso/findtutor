import 'package:avatars/avatars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/core/constants/app_constants.dart';
import '/core/models/profile.dart';
import '/core/navigation/app_navigator.dart';
import '/core/utils/utils.dart';
import '/core/widgets/appbar.dart';
import '/core/widgets/followers-count.dart';
import '/features/auth/presentation/pages/signin.dart';
import '/features/profile/bloc/profile_bloc.dart';
import '/features/profile/presentation/edit/edit_profile.dart';
import '/features/profile/presentation/edit/edit_tutor_profile.dart';
import '/features/profile/presentation/edit/change_password.dart';
import '/features/profile/presentation/activity/activity_history.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileBloc()..add(LoadProfileEvent()),
      child: BlocConsumer<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state.isSigningOut == false && state.signOutFailure != null) {
            showSnackBar(context, "${state.addingFailure?.message}");
          }

          if (state.isSigningOut == false && state.signOutFailure == null) {
            showSnackBar(context, "You have logged out successfully.");
            AppNavigator.pushAndRemove(context, const SignInPage());
          }
        },
        builder: (context, state) {
          if (state.failure != null) {
            return showFailedContainer();
          } else if (state.isLoading == true) {
            return buildLoadingScreen();
          } else if (state.userProfile != null) {
            final user = state.userProfile!;
            return Scaffold(
              appBar: AppBar(
                title: const Text("Profile"),
                centerTitle: false,
                actions: [
                  IconButton(
                    onPressed: () {
                      AppNavigator.push(context, const ChangePasswordScreen());
                    },
                    tooltip: "Change password",
                    icon: const Icon(Icons.lock_outline),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 4),
                    child: IconButton(
                      onPressed: () {
                        if (user.isTutor) {
                          AppNavigator.pushProfileBloc(
                            context,
                            const EditTutorProfile(),
                          );
                        } else {
                          AppNavigator.pushProfileBloc(
                            context,
                            const EditUserProfile(),
                          );
                        }
                      },
                      tooltip: "Edit your profile",
                      icon: const Icon(Icons.edit),
                    ),
                  ),
                ],
              ),
              body: buildProfileScreenBody(
                userProfile: user,
                onUserSignOut: () {
                  context.read<ProfileBloc>().add(UserSignOutEvent());
                },
              ),
            );
          }
          return buildLoadingScreen();
        },
      ),
    );
  }

  Widget buildLoadingScreen() {
    return const Scaffold(
      appBar: NamedAppBar(title: "Profile"),
      body: Center(child: CircularProgressIndicator()),
    );
  }

  Widget showFailedContainer() {
    return const Scaffold(
      appBar: NamedAppBar(title: "Profile"),
      body: Center(
        child: Text(
          "Failed to load your user profile. An error occurred.",
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget buildProfileScreenBody({
    required Profile userProfile,
    required VoidCallback onUserSignOut,
  }) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      children: [
        const SizedBox(height: 24),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              children: [
                GestureDetector(
                  onTap: () {
                    context.read<ProfileBloc>().add(
                      UpdateProfilePictureEvent(),
                    );
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(
                      AppConstants.profileRadius - 20,
                    ),
                    child: Image.network(
                      height: AppConstants.profileRadius * 2,
                      width: AppConstants.profileRadius * 2,
                      userProfile.profilePic ?? "",
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return const Center(child: CircularProgressIndicator());
                      },
                      errorBuilder: (context, error, stackTrace) {
                        return Avatar(
                          name: userProfile.user.fullName(),
                          shape: AvatarShape.rectangle(
                            AppConstants.profileRadius * 2,
                            AppConstants.profileRadius * 2,
                            BorderRadius.all(
                              Radius.circular(AppConstants.profileRadius - 20),
                            ),
                          ),
                          placeholderColors: [
                            Theme.of(context).colorScheme.onPrimary,
                          ],
                          textStyle: TextStyle(
                            color: Theme.of(context).colorScheme.onSurface,
                            fontSize: 24,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.inversePrimary,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.all(8),
                    child: const Icon(
                      Icons.add_a_photo_outlined,
                      size: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Text(
              userProfile.user.fullName(),
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.circle, color: Colors.green, size: 10),
                const SizedBox(width: 4),
                Text('Online', style: TextStyle(color: Colors.grey[600])),
              ],
            ),
          ],
        ),
        const SizedBox(height: 12),
        Text(
          textAlign: TextAlign.center,
          userProfile.bio?.isNotEmpty == true
              ? userProfile.bio!
              : "No Bio Yet. Add one soon.",
          style: const TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 4),
        const FollowersCount(followers: 0),
        const SizedBox(height: 24),
        buildUserPersonalInformation(userProfile),
        const SizedBox(height: 24),
        if (!userProfile.isTutor)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ElevatedButton.icon(
              onPressed: () {
                AppNavigator.pushProfileBloc(context, const EditTutorProfile());
              },
              icon: const Icon(Icons.school),
              label: const Text("Become a Tutor"),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
              ),
            ),
          ),
        const SizedBox(height: 16),
        ListTile(
          leading: const Icon(Icons.history),
          title: const Text("Activity History"),
          trailing: const Icon(Icons.chevron_right),
          onTap: () {
            AppNavigator.push(context, const ActivityHistoryScreen());
          },
        ),
        const SizedBox(height: 16),
        buildLogoutButton(onUserSignOut),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget buildUserPersonalInformation(Profile user) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Location',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(
                user.city ?? 'Not specified',
                style: const TextStyle(fontSize: 14),
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Country',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(
                user.userType ?? 'Not specified',
                style: const TextStyle(fontSize: 14),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildLogoutButton(VoidCallback onUserSignOut) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ElevatedButton.icon(
        onPressed: onUserSignOut,
        icon: const Icon(Icons.logout),
        label: const Text("Logout"),
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(double.infinity, 50),
          backgroundColor: Colors.red,
          foregroundColor: Colors.white,
        ),
      ),
    );
  }
}
