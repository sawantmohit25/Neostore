import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:neostore_app/model_classes/editcartmodel.dart';
class EditCartBloc{
  final stateStreamController=StreamController<EditCartModel>.broadcast();
  StreamSink<EditCartModel> get editCartSink =>stateStreamController.sink;
  Stream<EditCartModel> get editCartStream =>stateStreamController.stream;
  var statusCode;
  postData(String quantity,String id,String accessToken) async {
    print('neta${quantity}');
    print('neta${id}');
    print('neta${accessToken}');
    final String url = 'http://staging.php-dev.in:8844/trainingapp/api/editCart';
    final response = await http.post(url, body: {
      "product_id":id,
      "quantity" :quantity
    },headers: {"access_token" :accessToken});
    print(response.statusCode);
    if(response.statusCode==200){
      statusCode=response.statusCode;
      print(response.statusCode);
      var success =EditCartModel.fromJson(json.decode(response.body));
      editCartSink.add(success);
    }
    else {
      statusCode=response.statusCode;
      var error =EditCartModel.fromJson(json.decode(response.body));
      editCartSink.add(error);
    }
  }
  void dispose(){
    stateStreamController.close();
  }
}