class FlatRentalsModel {
  String? totalPaid;
  String? betakaHaweya;
  String? flatAndRentalID;
  String? employeeID;
  String? flatID;
  String? phone;
  String? uName;
  String? lastUpdatedFlatAndRental;
  String? createdAtFlatAndRental;
  String? rentType;
  String? price;
  String? moneyPlusOrrMin;
  String? startTime;
  String? lastTime;
  String? rentStatus;
  String? flatTypesArab;
  String? flatTypesEng;
  String? startDate;
  String? endDate;
  String? rentStates;

  FlatRentalsModel(
      {this.betakaHaweya,
        this.flatAndRentalID,
        this.totalPaid,
      this.rentStates,
      this.employeeID,
      this.flatID,
      this.phone,
      this.uName,
      this.lastUpdatedFlatAndRental,
      this.createdAtFlatAndRental,
      this.rentType,
      this.price,
      this.startTime,
      this.lastTime,
      this.rentStatus,
      this.flatTypesArab,
      this.startDate,
      this.endDate,
        this.moneyPlusOrrMin,
      this.flatTypesEng});

  FlatRentalsModel.fromJson(Map<String, dynamic> json) {
    moneyPlusOrrMin = json['MoneyPlusOrrMin'];
    totalPaid = json['TotalPaid'];
    betakaHaweya = json['BetakaHaweya'];
    rentStates = json['RentStatus'];
    print("rentStates : $rentStates");
    startDate = json['CreatedAtFlatAndRental'];
    endDate = json['lastUpdatedFlatAndRental'];
    flatAndRentalID = json['FlatAndRentalID'];
    employeeID = json['EmployeeID'];
    flatID = json['FlatID'];
    phone = json['Phone'];
    uName = json['UName'];
    lastUpdatedFlatAndRental = json['lastUpdatedFlatAndRental'];
    createdAtFlatAndRental = json['CreatedAtFlatAndRental'];
    rentType = json['RentType'];
    price = json['Price'];
    startTime = json['StartTime'];
    lastTime = json['LastTime'];
    rentStatus = json['RentStatus'];
    flatTypesArab = json['FlatTypesArab'];
    flatTypesEng = json['FlatTypesEng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['MoneyPlusOrrMin'] = moneyPlusOrrMin;
    data['TotalPaid'] = totalPaid;
    data['FlatAndRentalID'] = flatAndRentalID;
    data['EmployeeID'] = employeeID;
    data['FlatID'] = flatID;
    data['Phone'] = phone;
    data['UName'] = uName;
    data['BetakaHaweya'] = betakaHaweya;
    data['lastUpdatedFlatAndRental'] = lastUpdatedFlatAndRental;
    data['CreatedAtFlatAndRental'] = createdAtFlatAndRental;
    data['RentType'] = rentType;
    data['Price'] = price;
    data['StartTime'] = startTime;
    data['LastTime'] = lastTime;
    data['RentStatus'] = rentStatus;
    data['FlatTypesArab'] = flatTypesArab;
    data['FlatTypesEng'] = flatTypesEng;
    return data;
  }
}
