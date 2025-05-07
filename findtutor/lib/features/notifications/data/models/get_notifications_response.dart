import '/core/models/pagination.dart';
import 'package:json_annotation/json_annotation.dart';
import '/core/models/notification.dart';

part 'get_notifications_response.g.dart';

@JsonSerializable()
class GetNotificationsResponse {
  final Links links;
  final int total;
  @JsonKey(name: "total_pages")
  final int totalPages;
  @JsonKey(name: "current_page")
  final int currentPage;
  @JsonKey(name: "page_size")
  final int pageSize;
  final List<Notification> results;

  GetNotificationsResponse({
    required this.links,
    required this.total,
    required this.totalPages,
    required this.currentPage,
    required this.pageSize,
    required this.results,
  });

  factory GetNotificationsResponse.fromJson(Map<String, dynamic> json) =>
      _$GetNotificationsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetNotificationsResponseToJson(this);
}
