import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '/core/constants/app_constants.dart';
import '/core/utils/utils.dart';
import '/core/widgets/button.dart';
import '/core/widgets/input_text.dart';
import '/core/widgets/powered_by.dart';
import '/core/constants/app_images.dart';
import '/core/navigation/app_navigator.dart';
import '/features/auth/data/models/signup_req_params.dart';
import '/features/auth/domain/usecases/signup.dart';
import '/features/auth/presentation/pages/signin.dart';
import '/service_locator.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isLoading = false;
  String? _firstNameError = "";
  String? _lastNameError = "";
  String? _usernameError = "";
  String? _passwordError = "";

  final signUpUseCase = sl<SignUpUseCase>();

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
              "Welcome, enter your details to create your account.",
              style: TextStyle(fontSize: 14),
            ),
            //
            //
            const SizedBox(height: 36.0),
            //
            //
            Row(
              children: [
                Expanded(
                  child: InputText(
                    textCapitalization: TextCapitalization.words,
                    inputController: _firstNameController,
                    isLoading: _isLoading,
                    label: "First Name",
                    inputError: _firstNameError,
                  ),
                ),
                //
                const SizedBox(width: 8.0),
                //
                Expanded(
                  child: InputText(
                    textCapitalization: TextCapitalization.words,
                    inputController: _lastNameController,
                    isLoading: _isLoading,
                    label: "Last Name",
                    inputError: _lastNameError,
                  ),
                ),
              ],
            ),
            //
            //
            const SizedBox(height: 16.0),
            //
            //
            InputText(
              keyboardType: TextInputType.text,
              inputController: _usernameController,
              isLoading: _isLoading,
              label: "Username",
              inputError: _usernameError,
              prefixIcon: const Icon(Icons.alternate_email_rounded),
            ),
            //
            //
            const SizedBox(height: 16.0),
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
              label: "Create Account",
              backgroundColor: AppConstants.primaryColor,
              onPressed: performRegisterAccount,
            ),
            //
            //
            const SizedBox(height: 16.0),
            _signInText(context),
            //
            const Spacer(),
            //
            //
            const PoweredBy(hyperLinkColor: AppConstants.primaryColor),
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
    _firstNameController.dispose();
    _lastNameController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> performRegisterAccount() async {
    if (isLoginDataValid()) {
      final userResponse = await signUpUseCase.call(
        params: SignUpReqParams(
          username: _usernameController.text.trim(),
          password: _passwordController.text.trim(),
          firstName: _firstNameController.text.trim(),
          lastName: _lastNameController.text.trim(),
        ),
      );

      userResponse.fold(
        (left) {
          showSnackBar(context, "Failed to create user account");
          setState(() {
            _firstNameError = left.user?.firstName?.first ?? left.detail;
            _lastNameError = left.user?.lastName?.first;
            _usernameError = left.user?.username?.first;
            _passwordError = left.user?.password?.first;
          });
        },
        (right) {
          showSnackBar(
            context,
            "Account created successfully. Please login with your credentials.",
          );
          AppNavigator.pushReplacement(context, const SignInPage());
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
      _firstNameError = null;
      _lastNameError = null;
      _usernameError = null;
      _passwordError = null;
    });

    final firstName = _firstNameController.text.trim();
    final lastName = _lastNameController.text.trim();
    final username = _usernameController.text.trim();
    final password = _passwordController.text.trim();

    var error = false;

    if (firstName.isEmpty) {
      setState(() {
        _firstNameError = "This field is required.";
      });
      error = true;
    }

    if (lastName.isEmpty) {
      setState(() {
        _lastNameError = "This field is required.";
      });
      error = true;
    }

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

  Widget _signInText(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          const TextSpan(text: "Already have an account?"),
          TextSpan(
            text: ' Sign In.',
            style: const TextStyle(color: AppConstants.primaryColor),
            recognizer:
                TapGestureRecognizer()
                  ..onTap = () {
                    AppNavigator.pushReplacement(context, const SignInPage());
                  },
          ),
        ],
      ),
    );
  }
}
