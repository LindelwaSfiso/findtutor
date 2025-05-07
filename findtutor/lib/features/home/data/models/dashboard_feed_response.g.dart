// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_feed_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DashboardFeed _$DashboardFeedFromJson(Map<String, dynamic> json) =>
    DashboardFeed(
      links: Links.fromJson(json['links'] as Map<String, dynamic>),
      total: (json['total'] as num).toInt(),
      totalPages: (json['total_pages'] as num).toInt(),
      currentPage: (json['current_page'] as num).toInt(),
      pageSize: (json['page_size'] as num).toInt(),
      results:
          (json['results'] as List<dynamic>)
              .map((e) => Profile.fromJson(e as Map<String, dynamic>))
              .toList(),
    );

Map<String, dynamic> _$DashboardFeedToJson(DashboardFeed instance) =>
    <String, dynamic>{
      'links': instance.links,
      'total': instance.total,
      'total_pages': instance.totalPages,
      'current_page': instance.currentPage,
      'page_size': instance.pageSize,
      'results': instance.results,
    };
