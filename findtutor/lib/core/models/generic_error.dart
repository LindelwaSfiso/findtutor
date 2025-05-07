import 'package:json_annotation/json_annotation.dart';

part 'generic_error.g.dart';

@JsonSerializable()
class GenericError {
  final String? detail;

  const GenericError({this.detail});

  factory GenericError.fromJson(Map<String, dynamic> json) =>
      _$GenericErrorFromJson(json);

  Map<String, dynamic> toJson() => _$GenericErrorToJson(this);
}
