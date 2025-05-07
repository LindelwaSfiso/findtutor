import '/core/models/pagination.dart';
import 'package:json_annotation/json_annotation.dart';
import '/core/models/profile.dart';

part 'dashboard_feed_response.g.dart';

@JsonSerializable()
class DashboardFeed {
  final Links links;
  final int total;
  @JsonKey(name: "total_pages")
  final int totalPages;
  @JsonKey(name: "current_page")
  final int currentPage;
  @JsonKey(name: "page_size")
  final int pageSize;
  final List<Profile> results;

  DashboardFeed({
    required this.links,
    required this.total,
    required this.totalPages,
    required this.currentPage,
    required this.pageSize,
    required this.results,
  });

  factory DashboardFeed.fromJson(Map<String, dynamic> json) =>
      _$DashboardFeedFromJson(json);

  Map<String, dynamic> toJson() => _$DashboardFeedToJson(this);
}
