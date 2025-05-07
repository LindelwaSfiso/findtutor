import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/core/navigation/app_navigator.dart';
import '/core/utils/utils.dart';
import '/core/widgets/appbar.dart';
import '/core/widgets/button.dart';
import '/features/profile/bloc/profile_bloc.dart';

class EditTutorProfile extends StatefulWidget {
  const EditTutorProfile({super.key});

  @override
  State<EditTutorProfile> createState() => _EditTutorProfileState();
}

class _EditTutorProfileState extends State<EditTutorProfile> {
  final _formKey = GlobalKey<FormState>();
  final _subjectsController = TextEditingController();
  final _qualificationsController = TextEditingController();
  final _experienceController = TextEditingController();
  final _hourlyRateController = TextEditingController();
  final _availabilityController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final state = context.read<ProfileBloc>().state;
    if (state.userProfile?.tutorProfile != null) {
      final tutorProfile = state.userProfile!.tutorProfile!;
      _subjectsController.text = tutorProfile.subjects ?? '';
      _qualificationsController.text = tutorProfile.qualifications ?? '';
      _experienceController.text = tutorProfile.experience ?? '';
      _hourlyRateController.text = tutorProfile.hourlyRate?.toString() ?? '';
      _availabilityController.text = tutorProfile.availability ?? '';
    }
  }

  @override
  void dispose() {
    _subjectsController.dispose();
    _qualificationsController.dispose();
    _experienceController.dispose();
    _hourlyRateController.dispose();
    _availabilityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const NamedAppBar(title: "Edit Tutor Profile"),
      body: BlocConsumer<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state.updateTutorProfileFailure != null) {
            showSnackBar(
              context,
              state.updateTutorProfileFailure!.detail ?? "",
            );
          }
          if (state.userProfile != null) {
            showSnackBar(context, "Profile updated successfully");
            AppNavigator.back(context);
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    controller: _subjectsController,
                    decoration: const InputDecoration(
                      labelText: 'Subjects',
                      border: OutlineInputBorder(),
                      hintText: 'Enter subjects you teach (comma-separated)',
                    ),
                    maxLines: 2,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the subjects you teach';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _qualificationsController,
                    decoration: const InputDecoration(
                      labelText: 'Qualifications',
                      border: OutlineInputBorder(),
                      hintText: 'Enter your qualifications (comma-separated)',
                    ),
                    maxLines: 2,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your qualifications';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _experienceController,
                    decoration: const InputDecoration(
                      labelText: 'Experience',
                      border: OutlineInputBorder(),
                      hintText: 'Describe your teaching experience',
                    ),
                    maxLines: 3,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your teaching experience';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _hourlyRateController,
                    decoration: const InputDecoration(
                      labelText: 'Hourly Rate (SZL)',
                      border: OutlineInputBorder(),
                      hintText: 'Enter your hourly rate in SZL',
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your hourly rate';
                      }
                      if (double.tryParse(value) == null) {
                        return 'Please enter a valid number';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _availabilityController,
                    decoration: const InputDecoration(
                      labelText: 'Availability',
                      border: OutlineInputBorder(),
                      hintText:
                          'Enter your availability (e.g., Mon-Fri 9AM-5PM)',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your availability';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 24),
                  DefaultButton(
                    isLoading: state.isUpdatingTutorProfile,
                    label: "Save Changes",
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        context.read<ProfileBloc>().add(
                          UpdateTutorProfileEvent(
                            subjects: _subjectsController.text,
                            qualifications: _qualificationsController.text,
                            experience: _experienceController.text,
                            hourlyRate: double.parse(
                              _hourlyRateController.text,
                            ),
                            availability: _availabilityController.text,
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
