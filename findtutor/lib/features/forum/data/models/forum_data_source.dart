import 'package:json_annotation/json_annotation.dart';

part 'forum_data_source.g.dart';

@JsonSerializable()
class GetForumsParams {
  final String? search;
  final bool? isPrivate;
  final int page;
  final int pageSize;

  GetForumsParams({
    required this.search,
    required this.isPrivate,
    this.page = 1,
    this.pageSize = 10,
  });

  factory GetForumsParams.fromJson(Map<String, dynamic> json) =>
      _$GetForumsParamsFromJson(json);

  Map<String, dynamic> toJson() => _$GetForumsParamsToJson(this);
}

@JsonSerializable()
class CreateForumRequestParams {
  final String name;
  final String description;
  final int admin;
  @JsonKey(name: "is_private")
  final bool isPrivate;

  CreateForumRequestParams({
    required this.name,
    required this.description,
    required this.admin,
    required this.isPrivate,
  });

  factory CreateForumRequestParams.fromJson(Map<String, dynamic> json) =>
      _$CreateForumRequestParamsFromJson(json);

  Map<String, dynamic> toJson() => _$CreateForumRequestParamsToJson(this);
}

@JsonSerializable()
class GetForumPostsParams {
  @JsonKey(name: "id")
  final int forumId;
  final int page;
  final int pageSize;

  GetForumPostsParams({
    required this.forumId,
    this.page = 1,
    this.pageSize = 10,
  });

  factory GetForumPostsParams.fromJson(Map<String, dynamic> json) =>
      _$GetForumPostsParamsFromJson(json);

  Map<String, dynamic> toJson() => _$GetForumPostsParamsToJson(this);
}

@JsonSerializable()
class CreateForumPostParams {
  @JsonKey(name: "id")
  final int forumId;
  final String title;
  final String content;
  final List<String> imageUrls;
  final List<String> linkUrls;

  CreateForumPostParams({
    required this.forumId,
    required this.title,
    required this.content,
    this.imageUrls = const [],
    this.linkUrls = const [],
  });

  factory CreateForumPostParams.fromJson(Map<String, dynamic> json) =>
      _$CreateForumPostParamsFromJson(json);

  Map<String, dynamic> toJson() => _$CreateForumPostParamsToJson(this);
}

/// errors

@JsonSerializable()
class CreateForumErrors {
  final String? detail;
  final List<String>? name;
  final List<String>? description;
  final List<String>? admin;
  @JsonKey(name: "is_private")
  final List<String>? isPrivate;

  CreateForumErrors({
    this.detail,
    this.name,
    this.description,
    this.admin,
    this.isPrivate,
  });

  factory CreateForumErrors.fromJson(Map<String, dynamic> json) =>
      _$CreateForumErrorsFromJson(json);

  Map<String, dynamic> toJson() => _$CreateForumErrorsToJson(this);
}
