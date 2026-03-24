import 'dart:io';

enum IdeaStatus { pending, approved, rejected }

enum IdeaType { programming, marketing }

class IdeaModel {
  final String id;
  DateTime date;
  String ideaExplain;
  String ideaLink;
  File? ideaFile;
  IdeaStatus status;
  IdeaType type;

  IdeaModel({
    required this.id,
    required this.date,
    required this.ideaExplain,
    required this.ideaLink,
    this.ideaFile,
    required this.status,
    required this.type,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date.toIso8601String(),
      'ideaExplain': ideaExplain,
      'ideaLink': ideaLink,
      'status': status.index,
      'type': type.index,
    };
  }

  factory IdeaModel.fromJson(Map<String, dynamic> json) {
    return IdeaModel(
      id: json['id'],
      date: DateTime.parse(json['date']),
      ideaExplain: json['ideaExplain'],
      ideaLink: json['ideaLink'],
      status: IdeaStatus.values[json['status']],
      type: IdeaType.values[json['type']],
      // ideaFile is not handled in JSON because File is a local object
      // In a real app, this would be a URL or local path string
    );
  }

  IdeaModel copyWith({
    String? id,
    DateTime? date,
    String? ideaExplain,
    String? ideaLink,
    File? ideaFile,
    IdeaStatus? status,
    IdeaType? type,
  }) {
    return IdeaModel(
      id: id ?? this.id,
      date: date ?? this.date,
      ideaExplain: ideaExplain ?? this.ideaExplain,
      ideaLink: ideaLink ?? this.ideaLink,
      ideaFile: ideaFile ?? this.ideaFile,
      status: status ?? this.status,
      type: type ?? this.type,
    );
  }
}
