import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:neostore_app/usermodel.dart';

class LoginBloc{
  final stateStreamController=StreamController<String>();
  var statusCode;
  StreamSink<String> get loginSink =>stateStreamController.sink;
  Stream<String> get loginStream =>stateStreamController.stream;

  postData(String email,String password) async {
    final String url = 'http://staging.php-dev.in:8844/trainingapp/api/users/login';
    final response = await http.post(url, body: {
      "email": email,
      "password": password,
    });
    if(response.statusCode==200){
      print(response.statusCode);
      statusCode=response.statusCode;
      print(response.body);
      print(email);
      var success =ResponseModel.fromJson(json.decode(response.body));
      print(success.userMsg);
      loginSink.add(success.userMsg);
    }
    else if(response.statusCode==401){
      statusCode=response.statusCode;
      var error =ErrorModel.fromJson(json.decode(response.body));
      print(error.userMsg);
      loginSink.add(error.userMsg);
    }
  }
  void dispose(){
    stateStreamController.close();
  }
}