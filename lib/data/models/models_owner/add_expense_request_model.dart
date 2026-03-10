class AddExpenseRequestModel {
  final String flatID;
  final String moneyMasrof;
  final String ownerID;
  final String  note;
  AddExpenseRequestModel({
    required this.flatID,
    required this.moneyMasrof,
    required this.ownerID,
  required this.note
  });

  Map<String, dynamic> toJson() {
    return {
      'FlatID': flatID,
      'MoneyMasrof': moneyMasrof,
      'OwnerID': ownerID,
      'Notess':note
    };
  }
}
