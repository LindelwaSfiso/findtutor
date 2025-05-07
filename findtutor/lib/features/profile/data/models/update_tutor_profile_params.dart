class UpdateTutorProfileParams {
  final String id;
  final String subjects;
  final String qualifications;
  final String experience;
  final double hourlyRate;
  final String availability;

  const UpdateTutorProfileParams({
    required this.id,
    required this.subjects,
    required this.qualifications,
    required this.experience,
    required this.hourlyRate,
    required this.availability,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'subjects': subjects,
      'qualifications': qualifications,
      'experience': experience,
      'hourly_rate': hourlyRate,
      'availability': availability,
    };
  }
}
