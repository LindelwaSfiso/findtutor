import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '/core/constants/app_constants.dart';
import '/core/utils/utils.dart';
import '/core/widgets/button.dart';
import '/core/widgets/input_text.dart';
import '/core/widgets/powered_by.dart';
import '/core/constants/app_images.dart';
import '/core/navigation/app_navigator.dart';
import '/features/auth/data/models/signin_req_params.dart';
import '/features/auth/domain/usecases/signin.dart';
import '/features/auth/presentation/pages/signup.dart';
import '/features/home/presentation/pages/home.dart';
import '/service_locator.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isLoading = false;
  String? _usernameError = "";
  String? _passwordError = "";

  final signInUseCase = sl<SignInUseCase>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Image(
          image: const AssetImage(AppImages.logoImage),
          width: 56,
          height: 50,
        ),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 36.0),
            //
            //
            const Text(
              "Welcome to ${AppConstants.appName}",
              style: TextStyle(fontSize: 30),
            ),
            //
            //
            const Text(
              "Welcome back! Please enter your credentials.",
              style: TextStyle(fontSize: 14),
            ),
            //
            //
            const SizedBox(height: 36.0),
            //
            //
            InputText(
              keyboardType: TextInputType.text,
              inputController: _usernameController,
              isLoading: _isLoading,
              label: "Username",
              inputError: _usernameError,
              prefixIcon: const Icon(Icons.person_outlined),
            ),
            //
            //
            const SizedBox(height: 20.0),
            //
            //
            InputText(
              inputController: _passwordController,
              isLoading: _isLoading,
              label: "Password",
              inputError: _passwordError,
              prefixIcon: const Icon(Icons.password),
              isPassword: true,
              showPasswordToggle: true,
            ),
            //
            //
            const SizedBox(height: 20.0),
            //
            //
            DefaultButton(
              isLoading: _isLoading,
              label: "Sign In",
              backgroundColor: AppConstants.primaryColor,
              onPressed: performLogin,
            ),
            //
            //
            const SizedBox(height: 8.0),
            _disclaimerText(),
            //
            //
            const SizedBox(height: 16.0),
            _signupText(context),
            //
            const Spacer(),
            //
            //
            const PoweredBy(),
            //
            //
            const SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> performLogin() async {
    if (isLoginDataValid()) {
      final response = await signInUseCase.call(
        params: SignInReqParams(
          username: _usernameController.text.trim(),
          password: _passwordController.text.trim(),
        ),
      );

      response.fold(
        (left) {
          showSnackBar(context, "Failed to authenticate");
          setState(() {
            _usernameError = left.username?.first ?? left.detail;
          });
        },
        (right) {
          AppNavigator.pushReplacement(context, const HomeScreen());
        },
      );

      setState(() {
        _isLoading = false;
      });
    }
  }

  bool isLoginDataValid() {
    // clear state first
    setState(() {
      _isLoading = true;
      _usernameError = null;
      _passwordError = null;
    });

    final username = _usernameController.text.trim();
    final password = _passwordController.text.trim();

    var error = false;

    if (username.isEmpty) {
      setState(() {
        _usernameError = "This field is required.";
      });
      error = true;
    }

    if (password.isEmpty) {
      setState(() {
        _passwordError = "This field is required";
      });
      error = true;
    }

    if (error) {
      setState(() {
        _isLoading = false;
      });
      return false;
    }

    return true;
  }

  Widget _signupText(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          const TextSpan(text: "Don't you have an account?"),
          TextSpan(
            text: ' Sign Up',
            style: const TextStyle(color: Colors.blue),
            recognizer:
                TapGestureRecognizer()
                  ..onTap = () {
                    AppNavigator.pushReplacement(context, const SignUpPage());
                  },
          ),
        ],
      ),
    );
  }

  Widget _disclaimerText() {
    return Text(
      'By continuing, you agree to our Terms of Service and Privacy Policy',
      textAlign: TextAlign.center,
      style: Theme.of(
        context,
      ).textTheme.bodySmall!.copyWith(color: Colors.grey[600]),
    );
  }
}
