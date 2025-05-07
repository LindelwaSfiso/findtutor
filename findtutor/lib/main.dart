import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/core/constants/app_constants.dart';
import '/features/home/presentation/pages/home.dart' show HomeScreen;
import '/service_locator.dart';

import 'core/constants/app_images.dart';
import 'core/navigation/app_navigator.dart';
import 'core/theme/theme.dart';
import 'features/auth/bloc/auth_cubit.dart';
import 'features/auth/bloc/auth_state.dart';
import 'features/auth/presentation/pages/signin.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setUpServiceLocator();
  runApp(const MainApplication());
}

class MainApplication extends StatelessWidget {
  const MainApplication({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit()..appStarted(),
      child: MaterialApp(
        title: AppConstants.appName,
        darkTheme: MaterialTheme(ThemeData.dark().textTheme).darkMediumContrast(),
        themeMode: ThemeMode.dark,
        debugShowCheckedModeBanner: false,
        home: BlocListener<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is UserUnAuthenticated) {
              AppNavigator.pushAndRemove(context, const SignInPage());
            }

            if (state is UserAuthenticated) {
              AppNavigator.pushAndRemove(context, const HomeScreen());
            }
          },
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              title: const Image(
                image: AssetImage(AppImages.logoImage),
                width: 100,
                height: 48,
              ),
              centerTitle: true,
            ),
            body: const Center(child: CircularProgressIndicator()),
          ),
        ),
      ),
    );
  }
}
