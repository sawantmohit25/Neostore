import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:neostore_app/model_classes/usermodel.dart';
class ForgotPassBloc{
  final stateStreamController=StreamController<String>();
  StreamSink<String> get forgotSink =>stateStreamController.sink;
  Stream<String> get forgotStream =>stateStreamController.stream;
  var statusCode;
   postData(String email) async {
    final String url = 'http://staging.php-dev.in:8844/trainingapp/api/users/forgot';
    final response = await http.post(url, body: {
      "email": email,
    });
    print(response.statusCode);
    if(response.statusCode==200){
      statusCode=response.statusCode;
      print(response.statusCode);
      print(response.body);
      print(email);
      var success =SuccessModel.fromJson(json.decode(response.body));
      print(success.userMsg);
      forgotSink.add(success.userMsg);
      // _scaffoldKey.currentState.showSnackBar(
      //     SnackBar(
      //       content:Text(success.userMsg),
      //       backgroundColor: Colors.blue,
      //       duration:Duration(seconds: 5),
      //       action: SnackBarAction(
      //         label: 'Ok',
      //         textColor: Colors.white,
      //         onPressed: () {
      //           Navigator.of(context).pop();
      //         },
      //       ),
      //     )
      // );
    }
    else if(response.statusCode==404){
      statusCode=response.statusCode;
      var error =ErrorModel.fromJson(json.decode(response.body));
      print(error.userMsg);
      forgotSink.add(error.userMsg);
      // _scaffoldKey.currentState.showSnackBar(
      //     SnackBar(
      //       content:Text(error.userMsg),
      //       backgroundColor: Colors.blue,
      //       duration:Duration(seconds: 2),
      //     )
      // );
      // print(response.statusCode);
      // return null;
    }
  }
  void dispose(){
    stateStreamController.close();
  }
}