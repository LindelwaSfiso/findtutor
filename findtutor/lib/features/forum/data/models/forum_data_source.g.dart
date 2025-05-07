// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forum_data_source.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetForumsParams _$GetForumsParamsFromJson(Map<String, dynamic> json) =>
    GetForumsParams(
      search: json['search'] as String?,
      isPrivate: json['isPrivate'] as bool?,
      page: (json['page'] as num?)?.toInt() ?? 1,
      pageSize: (json['pageSize'] as num?)?.toInt() ?? 10,
    );

Map<String, dynamic> _$GetForumsParamsToJson(GetForumsParams instance) =>
    <String, dynamic>{
      'search': instance.search,
      'isPrivate': instance.isPrivate,
      'page': instance.page,
      'pageSize': instance.pageSize,
    };

CreateForumRequestParams _$CreateForumRequestParamsFromJson(
  Map<String, dynamic> json,
) => CreateForumRequestParams(
  name: json['name'] as String,
  description: json['description'] as String,
  admin: (json['admin'] as num).toInt(),
  isPrivate: json['is_private'] as bool,
);

Map<String, dynamic> _$CreateForumRequestParamsToJson(
  CreateForumRequestParams instance,
) => <String, dynamic>{
  'name': instance.name,
  'description': instance.description,
  'admin': instance.admin,
  'is_private': instance.isPrivate,
};

GetForumPostsParams _$GetForumPostsParamsFromJson(Map<String, dynamic> json) =>
    GetForumPostsParams(
      forumId: (json['id'] as num).toInt(),
      page: (json['page'] as num?)?.toInt() ?? 1,
      pageSize: (json['pageSize'] as num?)?.toInt() ?? 10,
    );

Map<String, dynamic> _$GetForumPostsParamsToJson(
  GetForumPostsParams instance,
) => <String, dynamic>{
  'id': instance.forumId,
  'page': instance.page,
  'pageSize': instance.pageSize,
};

CreateForumPostParams _$CreateForumPostParamsFromJson(
  Map<String, dynamic> json,
) => CreateForumPostParams(
  forumId: (json['id'] as num).toInt(),
  title: json['title'] as String,
  content: json['content'] as String,
  imageUrls:
      (json['imageUrls'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  linkUrls:
      (json['linkUrls'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
);

Map<String, dynamic> _$CreateForumPostParamsToJson(
  CreateForumPostParams instance,
) => <String, dynamic>{
  'id': instance.forumId,
  'title': instance.title,
  'content': instance.content,
  'imageUrls': instance.imageUrls,
  'linkUrls': instance.linkUrls,
};

CreateForumErrors _$CreateForumErrorsFromJson(
  Map<String, dynamic> json,
) => CreateForumErrors(
  detail: json['detail'] as String?,
  name: (json['name'] as List<dynamic>?)?.map((e) => e as String).toList(),
  description:
      (json['description'] as List<dynamic>?)?.map((e) => e as String).toList(),
  admin: (json['admin'] as List<dynamic>?)?.map((e) => e as String).toList(),
  isPrivate:
      (json['is_private'] as List<dynamic>?)?.map((e) => e as String).toList(),
);

Map<String, dynamic> _$CreateForumErrorsToJson(CreateForumErrors instance) =>
    <String, dynamic>{
      'detail': instance.detail,
      'name': instance.name,
      'description': instance.description,
      'admin': instance.admin,
      'is_private': instance.isPrivate,
    };
