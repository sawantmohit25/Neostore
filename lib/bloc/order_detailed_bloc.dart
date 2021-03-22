import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:neostore_app/model_classes/orderdetailmodel.dart';
import 'dart:async';
class OrderDetailBloc{
  final stateStreamController=StreamController<OrderDetailModel>.broadcast();
  StreamSink<OrderDetailModel> get orderDetailSink =>stateStreamController.sink;
  Stream<OrderDetailModel> get orderDetailStream =>stateStreamController.stream;
  getData(String orderId,String accessToken) async{
    var endpointUrl = 'http://staging.php-dev.in:8844/trainingapp/api/orderDetail';
    Map<String,String> queryParams = {
      'order_id' :orderId
         };
    String queryString = Uri(queryParameters: queryParams).query;
    var requestUrl = endpointUrl + '?' + queryString;
    var res= await http.get(requestUrl,headers: {"access_token":accessToken});
    var body=json.decode(res.body);
    if(res.statusCode==200){
      OrderDetailModel orderDetails=OrderDetailModel.fromJson(body);
      orderDetailSink.add(orderDetails);
    }
  }
  void dispose(){
    stateStreamController.close();
  }
}