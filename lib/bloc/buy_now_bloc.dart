import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:neostore_app/model_classes/buynowmodel.dart';
import 'package:neostore_app/model_classes/setratingmodel.dart';
class BuyNowBloc{
  final stateStreamController=StreamController<BuyNowModel>.broadcast();
  StreamSink<BuyNowModel> get quantitySink =>stateStreamController.sink;
  Stream<BuyNowModel> get quantityStream =>stateStreamController.stream;
  var statusCode;
  postData(String quantity,String id,String accessToken) async {
    final String url = 'http://staging.php-dev.in:8844/trainingapp/api/addToCart';
    final response = await http.post(url, body: {
      "product_id":id,
      "quantity" :quantity
    },headers: {"access_token" :accessToken});
    print(response.statusCode);
    if(response.statusCode==200){
      statusCode=response.statusCode;
      print(response.statusCode);
      var success =BuyNowModel.fromJson(json.decode(response.body));
      quantitySink.add(success);
    }
    else if(response.statusCode==401){
      statusCode=response.statusCode;
      var error =BuyNowModel.fromJson(json.decode(response.body));
      quantitySink.add(error);
    }
  }
  void dispose(){
    stateStreamController.close();
  }
}