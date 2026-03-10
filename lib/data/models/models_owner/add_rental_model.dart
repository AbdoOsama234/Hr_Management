class AddRentalRequestModel{
  String? phoneNumber;
  String? flatID;
  String? ownerID;
  String? uName;
  String? rentType;
  String? price;
  String? paidValue;
  //String? token;
  String? startDate;
  String? numberOfDays;
  String? numberOfDaysSamah;
  String idNumber;
  AddRentalRequestModel({required this.paidValue,required this.idNumber,required this.numberOfDaysSamah,required this.startDate,required this.numberOfDays,required this.phoneNumber,required this.ownerID,required this.flatID,required this.price,required this.rentType,required this.uName});


  Map<String, dynamic> toJson() {
    return {
      'Madfoa':paidValue,
      'OwnerID': ownerID,
      'FlatID': flatID,
      'Phone': phoneNumber,
      'UName': uName,
      'RentType': rentType,
      'Price': price,
      'StartDate': startDate,
      'Daysw': numberOfDays,
      'Samah': numberOfDaysSamah,
      'BetakaHaweya': idNumber,
      //'Token': token,
    };
  }
}