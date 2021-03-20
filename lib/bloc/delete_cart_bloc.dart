import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:neostore_app/model_classes/deletecartmodel.dart';
class DeleteCartBloc{
  final stateStreamController=StreamController<DeleteCartModel>.broadcast();
  StreamSink<DeleteCartModel> get deleteCartSink =>stateStreamController.sink;
  Stream<DeleteCartModel> get deleteCartStream =>stateStreamController.stream;
  var statusCode;
  postData(String id,String accessToken) async {
     final String url = 'http://staging.php-dev.in:8844/trainingapp/api/deleteCart';
    final response = await http.post(url, body: {
      "product_id":id,
    },headers: {"access_token" :accessToken});
    print(response.statusCode);
    if(response.statusCode==200){
      statusCode=response.statusCode;
      print(response.statusCode);
      var success =DeleteCartModel.fromJson(json.decode(response.body));
      deleteCartSink.add(success);
    }
    else {
      statusCode=response.statusCode;
      var error =DeleteCartModel.fromJson(json.decode(response.body));
      deleteCartSink.add(error);
    }
  }
  void dispose(){
    stateStreamController.close();
  }
}