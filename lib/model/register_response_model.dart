class RegisterResponseModel {
  int? success;
  Data? data;
  String? tokenCode;

  RegisterResponseModel({this.success, this.data, this.tokenCode});

  RegisterResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    tokenCode = json['token_code'];
  }

  
}

class Data {
  String? sId;
  String? emailId;
  String? password;
  String? name;
  String? otp;
  String? isVerified;
  String? isActive;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Data(
      {this.sId,
      this.emailId,
      this.password,
      this.name,
      this.otp,
      this.isVerified,
      this.isActive,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    emailId = json['emailId'];
    password = json['password'];
    name = json['name'];
    otp = json['otp'];
    isVerified = json['isVerified'];
    isActive = json['isActive'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  
}
