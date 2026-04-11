// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pagination_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Pagination _$PaginationFromJson(Map<String, dynamic> json) => Pagination(
  count: (json['count'] as num?)?.toInt(),
  pages: (json['pages'] as num?)?.toInt(),
  currentPage: (json['current_page'] as num?)?.toInt(),
  hasNext: json['has_next'] as bool?,
);

Map<String, dynamic> _$PaginationToJson(Pagination instance) =>
    <String, dynamic>{
      'count': ?instance.count,
      'pages': ?instance.pages,
      'current_page': ?instance.currentPage,
      'has_next': ?instance.hasNext,
    };
