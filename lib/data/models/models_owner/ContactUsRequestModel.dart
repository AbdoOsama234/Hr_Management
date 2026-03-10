class ContactUsRequestModel {
  final String email;
  final String message;
  final String phone;
  final String name;

  ContactUsRequestModel({
    required this.email,
    required this.message,
    required this.phone,
    required this.name,
  });

  Map<String, dynamic> toJson() {
    return {
      'Email': email,
      'Message': message,
      'Phone': phone,
      'Name': name,
    };
  }

  factory ContactUsRequestModel.fromJson(Map<String, dynamic> json) {
    return ContactUsRequestModel(
      email: json['Email'] ?? '',
      message: json['Message'] ?? '',
      phone: json['Phone'] ?? '',
      name: json['Name'] ?? '',
    );
  }
}
