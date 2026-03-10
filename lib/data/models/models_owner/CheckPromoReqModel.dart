class CheckPromoModel {
  final String ownerID;
  final String textt;
  final String price;
  final String bakatID;

  CheckPromoModel({
    required this.ownerID,
    required this.textt,
    required this.price,
    required this.bakatID,
  });

  Map<String, dynamic> toJson() {
    return {
      "OwnerID": ownerID,
      "Textt": textt,
      "Price": price,
      "BakatID": bakatID,
    };
  }
}
