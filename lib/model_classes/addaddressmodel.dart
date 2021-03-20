class AddAddressModel {
  int status;
  String message;
  String userMsg;

  AddAddressModel({this.status, this.message, this.userMsg});

  AddAddressModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    userMsg = json['user_msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['user_msg'] = this.userMsg;
    return data;
  }
}
