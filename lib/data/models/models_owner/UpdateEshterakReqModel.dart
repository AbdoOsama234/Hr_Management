class UpdateEshterakReqModel {
  final String aqarID;
  final String price;
  final String ownerID;
  final String bakatID;

  UpdateEshterakReqModel({
    required this.aqarID,
    required this.price,
    required this.ownerID,
    required this.bakatID,
  });

  Map<String, dynamic> toJson() {
    return {
      "AqarID": aqarID,
      "Price": price,
      "OwnerID": ownerID,
      "BakatID": bakatID,
    };
  }
}
