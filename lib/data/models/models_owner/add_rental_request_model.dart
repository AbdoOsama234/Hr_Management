class AddRentalPriceRequestModel {
  final String ownerId;
  final String flatId;
  final String price;

  AddRentalPriceRequestModel({
    required this.ownerId,
    required this.flatId,
    required this.price,
  });

  /// للتحويل من JSON إلى Object
  factory AddRentalPriceRequestModel.fromJson(Map<String, dynamic> json) {
    return AddRentalPriceRequestModel(
      ownerId: json['OwnerID'] ?? '',
      flatId: json['FlatID'] ?? '',
      price: json['Price'] ?? '',
    );
  }

  /// للتحويل من Object إلى JSON
  Map<String, dynamic> toJson() {
    return {
      'OwnerID': ownerId,
      'FlatID': flatId,
      'Price': price,
    };
  }
}
