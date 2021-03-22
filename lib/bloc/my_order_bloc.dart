import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:neostore_app/model_classes/myordermodel.dart';

class MyOrderBloc{
  final stateStreamController =StreamController<MyOrderModel>.broadcast();
  StreamSink<MyOrderModel> get myOrderSink => stateStreamController.sink;
  Stream<MyOrderModel> get myOrderStream =>stateStreamController.stream;

  getData(String accessToken) async{
    var endpointUrl ='http://staging.php-dev.in:8844/trainingapp/api/orderList';
    var res=await http.get(endpointUrl,headers: {"access_token":accessToken});
    var body=json.decode(res.body);
    if(res.statusCode==200){
      print(res.statusCode);
      MyOrderModel cartList=MyOrderModel.fromJson(body);
      myOrderSink.add(cartList);
    }
    else{
      print(res.statusCode);
    }

  }
  void dispose(){
    stateStreamController.close();
  }

}