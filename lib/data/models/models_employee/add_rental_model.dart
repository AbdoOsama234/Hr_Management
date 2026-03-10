class AddRentalRequestModel{
  String? phoneNumber;
  String? flatID;
  String? employeeID;
  String? uName;
  String? rentType;
  String? price;
  String? startDate;
  String? numberOfDays;
  String? numberOfDaysSamah;
  String? idNumber;
  AddRentalRequestModel({required this.employeeID,required this.idNumber,required this.numberOfDaysSamah,required this.startDate,required this.numberOfDays,required this.phoneNumber,required this.flatID,required this.price,required this.rentType,required this.uName});


  Map<String, dynamic> toJson() {
    return {
      'EmployeeID': employeeID,
      'FlatID': flatID,
      'Phone': phoneNumber,
      'UName': uName,
      'RentType': rentType,
      'Price': price,
      'StartDate': startDate,
      'Daysw': numberOfDays,
      'DaysSamah': numberOfDaysSamah,
      'BetakaHaweya': idNumber,
    };
  }
}