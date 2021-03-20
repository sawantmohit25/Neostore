import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:neostore_app/model_classes/addaddressmodel.dart';
class AddAddressBloc{
  final stateStreamController=StreamController<AddAddressModel>.broadcast();
  StreamSink<AddAddressModel> get addAddressSink =>stateStreamController.sink;
  Stream<AddAddressModel> get addAddressStream =>stateStreamController.stream;
  var statusCode;
  postData(String address,String accessToken) async {
    final String url = 'http://staging.php-dev.in:8844/trainingapp/api/order';
    final response = await http.post(url, body: {
      "address":address,
    },headers: {"access_token" :accessToken});
    print(response.statusCode);
    if(response.statusCode==200){
      statusCode=response.statusCode;
      print(response.statusCode);
      var success =AddAddressModel.fromJson(json.decode(response.body));
      addAddressSink.add(success);
    }
    else {
      statusCode=response.statusCode;
      var error =AddAddressModel.fromJson(json.decode(response.body));
      addAddressSink.add(error);
    }
  }
  void dispose(){
    stateStreamController.close();
  }
}