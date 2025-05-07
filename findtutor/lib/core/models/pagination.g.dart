// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pagination.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaginatedResponse<T> _$PaginatedResponseFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) => PaginatedResponse<T>(
  links: Links.fromJson(json['links'] as Map<String, dynamic>),
  total: (json['total'] as num).toInt(),
  totalPages: (json['total_pages'] as num).toInt(),
  currentPage: (json['current_page'] as num).toInt(),
  pageSize: (json['page_size'] as num).toInt(),
  results: (json['results'] as List<dynamic>).map(fromJsonT).toList(),
);

Map<String, dynamic> _$PaginatedResponseToJson<T>(
  PaginatedResponse<T> instance,
  Object? Function(T value) toJsonT,
) => <String, dynamic>{
  'links': instance.links,
  'total': instance.total,
  'total_pages': instance.totalPages,
  'current_page': instance.currentPage,
  'page_size': instance.pageSize,
  'results': instance.results.map(toJsonT).toList(),
};

Links _$LinksFromJson(Map<String, dynamic> json) =>
    Links(next: json['next'] as String?, previous: json['previous'] as String?);

Map<String, dynamic> _$LinksToJson(Links instance) => <String, dynamic>{
  'next': instance.next,
  'previous': instance.previous,
};
