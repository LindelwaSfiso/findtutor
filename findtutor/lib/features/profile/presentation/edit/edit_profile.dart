import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/core/constants/app_constants.dart';
import '/core/navigation/app_navigator.dart';
import '/core/utils/utils.dart';
import '/core/widgets/appbar.dart';
import '/core/widgets/button.dart';
import '/features/profile/bloc/profile_bloc.dart';
import 'package:intl/intl.dart';

class EditUserProfile extends StatefulWidget {
  const EditUserProfile({super.key});

  @override
  State<EditUserProfile> createState() => _EditUserProfileState();
}

class _EditUserProfileState extends State<EditUserProfile> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _dateOfBirthController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();

  @override
  void initState() {
    _firstNameController.text =
        context.read<ProfileBloc>().state.userProfile?.user.firstName ?? "";
    _lastNameController.text =
        context.read<ProfileBloc>().state.userProfile?.user.lastName ?? "";
    _emailController.text =
        context.read<ProfileBloc>().state.userProfile?.user.email ?? "";
    _countryController.text =
        context.read<ProfileBloc>().state.userProfile?.address ?? "";
    _cityController.text =
        context.read<ProfileBloc>().state.userProfile?.city ?? "";
    _bioController.text =
        context.read<ProfileBloc>().state.userProfile?.bio ?? "";
    _dateOfBirthController.text =
        context.read<ProfileBloc>().state.userProfile?.address ??"";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileBloc, ProfileState>(
      bloc: context.read<ProfileBloc>(),
      listener: (context, state) {
        if (state.isUpdating == false && state.updateProfileFailure != null) {
          showSnackBar(context, "Failed to update profile. Try again.");
        }

        if (state.isUpdating == false && state.updateProfileFailure == null) {
          showSnackBar(context, "Updated your user profile successfully.");
          AppNavigator.back(context);
        }
      },
      builder: (BuildContext context, state) {
        return Placeholder();
        /*return Scaffold(
          appBar: const GenericAppBar(title: "Edit Your Profile"),
          body: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //
                    //
                    const SizedBox(height: 16),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Field is required.";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: "First Name*",
                        errorText:
                            state.updateProfileFailure?.user?.lastName?.first ??
                                state.updateProfileFailure?.detail,
                      ),
                      autofocus: true,
                      controller: _firstNameController,
                      enabled: state.isUpdating != true,
                      textCapitalization: TextCapitalization.words,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    ),
                    //
                    //
                    const SizedBox(height: 16),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Field is required.";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: "Last Name*",
                        errorText:
                            state.updateProfileFailure?.user?.lastName?.first,
                      ),
                      autofocus: true,
                      controller: _lastNameController,
                      enabled: state.isUpdating != true,
                      textCapitalization: TextCapitalization.words,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    ),
                    //
                    //
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: "Email",
                              errorText: state
                                  .updateProfileFailure?.user?.email?.first,
                            ),
                            autofocus: true,
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            enabled: state.isUpdating != true,
                            textCapitalization: TextCapitalization.none,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                          ),
                        ),
                        //
                        //
                        const SizedBox(width: 24),
                        //
                        //
                        Expanded(
                          child: TextFormField(
                            validator: (value) {
                              try {
                                if (value != null && value.isNotEmpty) {
                                  DateFormat("yyyy-MM-dd")
                                      .parseStrict(value.trim(), true)
                                      .toUtc()
                                      .toIso8601String();
                                }
                              } catch (e) {
                                return "Enter valid date";
                              }

                              return null;
                            },
                            decoration: InputDecoration(
                              labelText: "Date Of Birth",
                              hintText: "YYYY-MM-DD",
                              errorText: state
                                  .updateProfileFailure?.dateOfBirth?.first,
                            ),
                            autofocus: true,
                            controller: _dateOfBirthController,
                            enabled: state.isUpdating != true,
                            textCapitalization: TextCapitalization.sentences,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                          ),
                        ),
                      ],
                    ),
                    //
                    //
                    //
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            validator: (value) {
                              return null;
                            },
                            decoration: InputDecoration(
                              labelText: "City",
                              errorText:
                                  state.updateProfileFailure?.city?.first,
                            ),
                            autofocus: true,
                            controller: _cityController,
                            enabled: state.isUpdating != true,
                            textCapitalization: TextCapitalization.words,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                          ),
                        ),
                        //
                        //
                        const SizedBox(width: 24),
                        //
                        //
                        Expanded(
                          child: TextFormField(
                            validator: (value) {
                              return null;
                            },
                            decoration: InputDecoration(
                              labelText: "Country",
                              errorText:
                                  state.updateProfileFailure?.country?.first,
                            ),
                            autofocus: true,
                            controller: _countryController,
                            enabled: state.isUpdating != true,
                            textCapitalization: TextCapitalization.words,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                          ),
                        ),
                      ],
                    ),
                    //
                    const SizedBox(height: 16),
                    TextFormField(
                      validator: (value) {
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: "Enter your bio",
                        errorText: state.updateProfileFailure?.bio?.first,
                      ),
                      autofocus: true,
                      controller: _bioController,
                      enabled: state.isUpdating != true,
                      textCapitalization: TextCapitalization.sentences,
                      maxLength: 300,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    ),
                    //
                    //
                    const SizedBox(height: 16),
                    DefaultButton(
                      isLoading: state.isUpdating == true,
                      label: "Save Profile",
                      backgroundColor: AppConstants.primaryColor,
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          context.read<ProfileBloc>().add(
                                UpdateUserProfileEvent(
                                  firstName: _firstNameController.text.trim(),
                                  lastName: _lastNameController.text.trim(),
                                  email: _emailController.text.trim(),
                                  city: _cityController.text.trim().isEmpty
                                      ? null
                                      : _cityController.text.trim(),
                                  country:
                                      _countryController.text.trim().isEmpty
                                          ? null
                                          : _countryController.text.trim(),
                                  dateOfBirth: _dateOfBirthController.text.trim().isEmpty?null: _dateOfBirthController.text.trim(),
                                  bio:
                                      _bioController.text.trim().isEmpty
                                          ? null
                                          : _bioController.text.trim(),
                                ),
                              );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );*/
      },
    );
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _dateOfBirthController.dispose();
    _cityController.dispose();
    _countryController.dispose();
    _bioController.dispose();
    super.dispose();
  }
}
