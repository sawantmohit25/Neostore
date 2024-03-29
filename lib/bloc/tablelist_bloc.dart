import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:neostore_app/model_classes/productmodel.dart';
class TableListBloc{
  var responseStatus;
  final stateStreamController=StreamController<ProductList>.broadcast();
  StreamSink<ProductList> get tableSink =>stateStreamController.sink;
  Stream<ProductList> get tableStream =>stateStreamController.stream;
   getData(int pageNumber) async{
    var endpointUrl = 'http://staging.php-dev.in:8844/trainingapp/api/products/getList';
    Map<String,String> queryParams = {
      'product_category_id':'1',
      'limit': '10',
      'page' :pageNumber.toString()
    };
    String queryString = Uri(queryParameters: queryParams).query;
    var requestUrl = endpointUrl + '?' + queryString;
    var res= await http.get(requestUrl);//?product_category_id=1&limit=10&page=1
    var body=json.decode(res.body);
    if(res.statusCode==200){
      ProductList proList=ProductList.fromJson(body);
      responseStatus=res.statusCode;
      tableSink.add(proList);
    }
    else{
      responseStatus=res.statusCode;
    }
  }
  void dispose(){
    stateStreamController.close();
  }
}