import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    this.firstName,
    this.lastName,
    this.email,
    this.password,
    this.confirmPassword,
    this.gender,
    this.phoneNo,
  });

  String firstName;
  String lastName;
  String email;
  String password;
  String confirmPassword;
  String gender;
  int phoneNo;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    firstName: json["first_name"],
    lastName: json["last_name"],
    email: json["email"],
    password: json["password"],
    confirmPassword: json["confirm_password"],
    gender: json["gender"],
    phoneNo: json["phone_no"],
  );

  Map<String, dynamic> toJson() => {
    "first_name": firstName,
    "last_name": lastName,
    "email": email,
    "password": password,
    "confirm_password": confirmPassword,
    "gender": gender,
    "phone_no": phoneNo,
  };
}
class ErrorModel {
  String message;
  String userMsg;

  ErrorModel({this.message, this.userMsg});

  ErrorModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    userMsg = json['user_msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['user_msg'] = this.userMsg;
    return data;
  }
}
class ResponseModel {
  String message;
  String userMsg;

  ResponseModel({this.message, this.userMsg});

  ResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    userMsg = json['user_msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['user_msg'] = this.userMsg;
    return data;
  }
}
class RegisterModel {
  String message;
  String userMsg;

  RegisterModel({this.message, this.userMsg});

  RegisterModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    userMsg = json['user_msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['user_msg'] = this.userMsg;
    return data;
  }
}

