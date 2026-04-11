import 'package:json_annotation/json_annotation.dart';

part 'name_model.g.dart';

@JsonSerializable()
class Name {
  String? en;
  String? ar;

  Name({this.en, this.ar});

  factory Name.fromJson(Map<String, dynamic> json) => _$NameFromJson(json);
  Map<String, dynamic> toJson() => _$NameToJson(this);
}