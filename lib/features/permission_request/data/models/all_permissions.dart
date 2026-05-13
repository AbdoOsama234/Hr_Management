import 'package:json_annotation/json_annotation.dart';
import '../../../../data/models/pagination_model.dart';
import 'permission_model.dart';

part 'all_permissions.g.dart';

@JsonSerializable()
class AllPermissions {
  Pagination? pagination;
  @JsonKey(name: 'permission')
  List<PermissionModel>? permissions;

  AllPermissions({this.pagination, this.permissions});

  factory AllPermissions.fromJson(Map<String, dynamic> json) =>
      _$AllPermissionsFromJson(json);

  Map<String, dynamic> toJson() => _$AllPermissionsToJson(this);
}
