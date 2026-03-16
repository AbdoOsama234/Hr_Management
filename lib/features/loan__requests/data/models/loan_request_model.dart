enum LoanStatus { pending, approved, rejected }

class LoanRequestModel {
  final String id;
  DateTime date;
  double loan;
  String reason;
  LoanStatus status;

  LoanRequestModel({
    required this.id,
    required this.date,
    required this.loan,
    required this.reason,
    required this.status,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date.toIso8601String(),
      'loan': loan,
      'reason': reason,
      'status': status.index,
    };
  }

  factory LoanRequestModel.fromJson(Map<String, dynamic> json) {
    return LoanRequestModel(
      id: json['id'],
      date: DateTime.parse(json['date']),
      loan: (json['loan'] as num).toDouble(),
      reason: json['reason'],
      status: LoanStatus.values[json['status']],
    );
  }
}
