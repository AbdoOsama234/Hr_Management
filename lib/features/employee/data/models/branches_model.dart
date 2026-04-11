
import 'package:json_annotation/json_annotation.dart';

import '../../../../core/di/di.dart';
import '../../../../data/models/name_model.dart';
import '../../../../data/models/pagination_model.dart';
import '../../../../data/storage/local/app_prefs.dart';
part 'branches_model.g.dart';



@JsonSerializable()
class AllBranches {
  Pagination? pagination;
  List<BrancheModel>? branches;

  AllBranches({this.pagination, this.branches});

  factory AllBranches.fromJson(Map<String, dynamic> json) => _$AllBranchesFromJson(json);
  Map<String, dynamic> toJson() => _$AllBranchesToJson(this);

}

@JsonSerializable()
class BrancheModel {
  int? id;
  String? code;
  Name? name;
  String? status;
  String? desc;
  int? lastrecord;
  String? rootId;
  String? companyId;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;

  BrancheModel(
      {this.id,
        this.code,
        this.name,
        this.status,
        this.desc,
        this.lastrecord,
        this.rootId,
        this.companyId,
        this.deletedAt,
        this.createdAt,
        this.updatedAt});

  String get localName =>
      getIt<AppPreferences>().lang == "en" ? name?.en ?? "" : name?.ar ?? "";
  factory BrancheModel.fromJson(Map<String, dynamic> json) => _$BrancheModelFromJson(json);
  Map<String, dynamic> toJson() => _$BrancheModelToJson(this);


}





