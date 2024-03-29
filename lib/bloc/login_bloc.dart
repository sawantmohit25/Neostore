import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:neostore_app/model_classes/usermodel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginBloc{
  final stateStreamController=StreamController<String>.broadcast();//broadcast use while login navigation since showing error
  var statusCode,val1;
  StreamSink<String> get loginSink =>stateStreamController.sink;
  Stream<String> get loginStream =>stateStreamController.stream;

  final drawStreamController=StreamController<UserData>.broadcast();//broadcast use while login navigation since showing error
  StreamSink<UserData> get drawSink =>drawStreamController.sink;
  Stream<UserData> get drawStream =>drawStreamController.stream;

  postData(String email,String password) async {
    String val;
    final String url = 'http://staging.php-dev.in:8844/trainingapp/api/users/login';
    final response = await http.post(url, body: {
      "email": email,
      "password": password,
    },);
    if(response.statusCode==200){
      print(response.statusCode);
      statusCode=response.statusCode;
      print(response.body);
      print(email);
      var success =SuccessModel.fromJson(json.decode(response.body));
      print(success.userMsg);
      SharedPreferences loginData = await SharedPreferences.getInstance();
      loginData.setString('login',email);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("firstName",success.data.firstName);
      prefs.setString('lastName',success.data.lastName);
      prefs.setString('email',success.data.email);
      // prefs.setString('key4',success.data.profilePic);
      prefs.setString('phoneNo',success.data.phoneNo);
      prefs.setString('dob',success.data.dob);
      prefs.setString("accessToken",success.data.accessToken);
      prefs.setString("profilePic",success.data.profilePic);
      print('mohit ${success.data.firstName}');
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
    drawStreamController.close();
  }
}