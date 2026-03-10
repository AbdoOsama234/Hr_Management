class UpdateRentalRequestModel {
  final String betakaHaweya;
  final String price;
  final String phone;
  final String uName;
  final String flatAndRentalID;

  UpdateRentalRequestModel({
    required this.betakaHaweya,
    required this.price,
    required this.phone,
    required this.uName,
    required this.flatAndRentalID,
  });

  factory UpdateRentalRequestModel.fromJson(Map<String, dynamic> json) {
    return UpdateRentalRequestModel(
      betakaHaweya: json['BetakaHaweya'] ?? '',
      price: json['Price']?.toString() ?? '',
      phone: json['Phone'] ?? '',
      uName: json['UName'] ?? '',
      flatAndRentalID: json['FlatAndRentalID']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "BetakaHaweya": betakaHaweya,
      "Price": price,
      "Phone": phone,
      "UName": uName,
      "FlatAndRentalID": flatAndRentalID,
    };
  }
}
