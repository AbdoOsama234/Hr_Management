import 'package:json_annotation/json_annotation.dart';

part 'pagination_model.g.dart';

@JsonSerializable()
class Pagination {
  int? count;
  int? pages;
  int? currentPage;
  bool? hasNext;

  Pagination({this.count, this.pages, this.currentPage, this.hasNext});

  factory Pagination.fromJson(Map<String, dynamic> json) =>
      _$PaginationFromJson(json);
  Map<String, dynamic> toJson() => _$PaginationToJson(this);
}