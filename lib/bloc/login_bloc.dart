import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:neostore_app/usermodel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginBloc{
  final stateStreamController=StreamController<String>.broadcast();//broadcast use while login navigation since showing error
  var statusCode,firstName;
  String key1,key2,key3,key4,get1,get2,get3,get4;
  StreamSink<String> get loginSink =>stateStreamController.sink;
  Stream<String> get loginStream =>stateStreamController.stream;

  final drawStreamController=StreamController<UserData>.broadcast();//broadcast use while login navigation since showing error
  StreamSink<UserData> get drawSink =>drawStreamController.sink;
  Stream<UserData> get drawStream =>drawStreamController.stream;

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
      var success =SuccessModel.fromJson(json.decode(response.body));
      print(success.userMsg);
      SharedPreferences prefs= await SharedPreferences.getInstance();
      prefs.setString(key1,success.data.firstName);
      prefs.setString(key2,success.data.lastName);
      prefs.setString(key3,success.data.email);
      prefs.setString(key4,success.data.profilePic);
       get1 = prefs.getString(key1);
       get2 = prefs.getString(key2);
       get3 = prefs.getString(key3);
       get4 = prefs.getString(key4);
      print('mohit ${success.data.firstName}');
      print('rohit ${get1}');
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