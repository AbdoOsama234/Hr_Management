class NeedUpdateModel {
  bool? success;
  int? statusCode;
  String? message;
  String? data;

  NeedUpdateModel({this.success, this.statusCode, this.message, this.data});

  NeedUpdateModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    statusCode = json['status_code'];
    message = json['message'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['status_code'] = statusCode;
    data['message'] = message;
    data['data'] = this.data;
    return data;
  }
}
