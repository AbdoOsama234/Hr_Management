class FlatWalletRequestModel {
   String? flatID;
   String? dateStart;
   String? dateEnd;

  FlatWalletRequestModel({
    this.flatID,
    this.dateStart,
    this.dateEnd,
  });

  Map<String, dynamic> toJson() {
    return {
      'FlatID': flatID,
      'DateeStart': dateStart,
      'DateeEnd': dateEnd,
    };
  }
}
