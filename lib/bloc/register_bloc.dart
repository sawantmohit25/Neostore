import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:neostore_app/model_classes/usermodel.dart';

class RegisterBloc{
  final stateStreamController=StreamController<String>();
  StreamSink<String> get registerSink =>stateStreamController.sink;
  Stream<String> get registerStream =>stateStreamController.stream;
  var statusCode;
  postData(String firstName,String lastName,String email,String password,String confirmPassword,String gender,String phoneNo) async {
    final String url = 'http://staging.php-dev.in:8844/trainingapp/api/users/register';
    final response = await http.post(url, body: {
      "first_name": firstName,
      "last_name":lastName,
      "email":email,
      "password":password,
      "confirm_password":confirmPassword,
      "gender":gender,
      "phone_no":phoneNo
    },);
    if(response.statusCode==200){
      print(response.statusCode);
      statusCode=response.statusCode;
      print(response.body);
      var success =SuccessModel.fromJson(json.decode(response.body));
      print(success.userMsg);
      registerSink.add(success.userMsg);
    }
    else if(response.statusCode==404){
      statusCode=response.statusCode;
      var error =ErrorModel.fromJson(json.decode(response.body));
      print(error.userMsg);
      registerSink.add(error.userMsg);
    }
  }
  void dispose(){
    stateStreamController.close();
  }
}