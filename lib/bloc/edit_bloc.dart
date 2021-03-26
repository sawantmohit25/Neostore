import 'dart:convert';

import 'package:http/http.dart' as http;
import 'dart:async';

import 'package:neostore_app/model_classes/usermodel.dart';
import 'package:shared_preferences/shared_preferences.dart';
class EditBloc {
  var statusCode;
  final stateStreamController = StreamController<String>.broadcast(); //broadcast use while login navigation since showing error
  StreamSink<String> get editSink => stateStreamController.sink;
  Stream<String> get editStream => stateStreamController.stream;

  postData(String firstName, String lastName, String email, String phoneNo, String dob, String img,String accessToken) async {
    String val;
    print('hi${dob}');
    print('hi${img}');
    print('hi${accessToken}');
    final String url = 'http://staging.php-dev.in:8844/trainingapp/api/users/update';
    final response = await http.post(url, body: {
      "first_name": firstName,
      "last_name": lastName,
      "email": email,
      "phone_no": phoneNo,
      "dob": dob,
      "profile_pic":img,
    },headers: {"access_token":accessToken});
    if (response.statusCode == 200) {
      print(response.statusCode);
      statusCode = response.statusCode;
      print(response.body);
      print(email);
      var success = SuccessModel.fromJson(json.decode(response.body));
      // SharedPreferences editData = await SharedPreferences.getInstance();
      // editData.setString('key9', success.data.);
      editSink.add(success.userMsg);
    }
    else if (response.statusCode == 401) {
      statusCode = response.statusCode;
      var error = ErrorModel.fromJson(json.decode(response.body));
      print('mandar${error.userMsg}');
      editSink.add(error.userMsg);
    }
  }
}