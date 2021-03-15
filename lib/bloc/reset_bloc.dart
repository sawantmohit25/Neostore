import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:neostore_app/model_classes/usermodel.dart';

class ResetBloc{

  var statusCode;
  final stateStreamController = StreamController<String>.broadcast(); //broadcast use while login navigation since showing error
  StreamSink<String> get resetSink => stateStreamController.sink;
  Stream<String> get resetStream => stateStreamController.stream;

  postData(String currentPassword,String newPassword,String confirmPassword,String accessToken) async {
    print('hi${accessToken}');
    print('hi${newPassword}');
    final String url = 'http://staging.php-dev.in:8844/trainingapp/api/users/change';
    final response = await http.post(url, body: {
      "old_password":currentPassword,
      "password":newPassword,
      "confirm_password": confirmPassword,
    }, headers: {"access_token":accessToken});

    if (response.statusCode == 200) {
      statusCode = response.statusCode;
      print(response.body);
      var success = SuccessModel.fromJson(json.decode(response.body));
      resetSink.add(success.userMsg);
    }
    else if (response.statusCode == 401) {
      statusCode = response.statusCode;
      var error = ErrorModel.fromJson(json.decode(response.body));
      resetSink.add(error.userMsg);
    }
  }
}