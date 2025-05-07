import 'package:json_annotation/json_annotation.dart';

part 'profile_response.g.dart';

@JsonSerializable()
class UpdateAboutErrors {
  final String? detail;
  final List<String>? about;

  const UpdateAboutErrors({this.detail, this.about});

  factory UpdateAboutErrors.fromJson(Map<String, dynamic> json) =>
      _$UpdateAboutErrorsFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateAboutErrorsToJson(this);
}

@JsonSerializable()
class UpdateUserErrors {
  @JsonKey(name: "first_name")
  final List<String>? firstName;
  @JsonKey(name: "last_name")
  final List<String>? lastName;
  final List<String>? email;

  UpdateUserErrors({
    this.firstName,
    this.lastName,
    this.email,
  });

  factory UpdateUserErrors.fromJson(Map<String, dynamic> json) =>
      _$UpdateUserErrorsFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateUserErrorsToJson(this);
}

@JsonSerializable()
class UpdateProfileErrors {
  final String? detail;
  final UpdateUserErrors? user;
  @JsonKey(name: "date_of_birth")
  final List<String>? dateOfBirth;
  final List<String>? city;
  final List<String>? country;
  final List<String>? bio;

  UpdateProfileErrors({
    this.detail,
    this.user,
    this.dateOfBirth,
    this.city,
    this.country,
    this.bio,
  });

  factory UpdateProfileErrors.fromJson(Map<String, dynamic> json) =>
      _$UpdateProfileErrorsFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateProfileErrorsToJson(this);
}

@JsonSerializable()
class AddExperienceErrors {
  final String? detail;
  final List<String>? user;
  final List<String>? company;
  final List<String>? role;
  final List<String>? location;
  @JsonKey(name: "location_type")
  final List<String>? locationType;
  @JsonKey(name: "employment_type")
  final List<String>? employmentType;
  @JsonKey(name: "is_current_role")
  final List<String>? isCurrentRole;
  @JsonKey(name: "start_date")
  final List<String>? startDate;
  @JsonKey(name: "end_date")
  final List<String>? endDate;
  final List<String>? description;

  const AddExperienceErrors({
    this.user,
    this.company,
    this.role,
    this.location,
    this.locationType,
    this.employmentType,
    this.isCurrentRole,
    this.startDate,
    this.endDate,
    this.description,
    this.detail,
  });

  factory AddExperienceErrors.fromJson(Map<String, dynamic> json) =>
      _$AddExperienceErrorsFromJson(json);

  Map<String, dynamic> toJson() => _$AddExperienceErrorsToJson(this);
}

@JsonSerializable()
class AddEducationErrors {
  final String? detail;
  final List<String>? user;
  final List<String>? school;
  final List<String>? degree;
  @JsonKey(name: "field_of_study")
  final List<String>? fieldOfStudy;
  @JsonKey(name: "start_date")
  final List<String>? startDate;
  @JsonKey(name: "end_date")
  final List<String>? endDate;
  final List<String>? grade;
  final List<String>? description;

  const AddEducationErrors({
    this.detail,
    this.user,
    this.school,
    this.degree,
    this.fieldOfStudy,
    this.startDate,
    this.endDate,
    this.grade,
    this.description,
  });

  factory AddEducationErrors.fromJson(Map<String, dynamic> json) =>
      _$AddEducationErrorsFromJson(json);

  Map<String, dynamic> toJson() => _$AddEducationErrorsToJson(this);
}

@JsonSerializable()
class AddSkillErrors {
  final String? detail;
  final List<String>? user;
  @JsonKey(name: "skill_name")
  final List<String>? skillName;

  const AddSkillErrors({
    this.detail,
    this.user,
    this.skillName,
  });

  factory AddSkillErrors.fromJson(Map<String, dynamic> json) =>
      _$AddSkillErrorsFromJson(json);

  Map<String, dynamic> toJson() => _$AddSkillErrorsToJson(this);
}
