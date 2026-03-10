class StopRentalRequestModel {
  final String ownerID;
  final String flatAndRentalID;

  StopRentalRequestModel({
    required this.ownerID,
    required this.flatAndRentalID,
  });

  // fromJson factory constructor
  factory StopRentalRequestModel.fromJson(Map<String, dynamic> json) {
    return StopRentalRequestModel(
      ownerID: json['OwnerID'] ?? '',
      flatAndRentalID: json['FlatAndRentalID'] ?? '',
    );
  }

  // toJson method
  Map<String, dynamic> toJson() {
    return {
      'OwnerID': ownerID,
      'FlatAndRentalID': flatAndRentalID,
    };
  }

  @override
  String toString() {
    return 'StopRentalRequestModel(ownerID: $ownerID, flatAndRentalID: $flatAndRentalID)';
  }
}
