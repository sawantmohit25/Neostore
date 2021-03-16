import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:neostore_app/model_classes/productdetailmodel.dart';
import 'dart:async';
class ProductDetailedBloc{
  final stateStreamController=StreamController<ProductDetails>.broadcast();
  StreamSink<ProductDetails> get detailSink =>stateStreamController.sink;
  Stream<ProductDetails> get detailStream =>stateStreamController.stream;

  getData(int id) async{
    var endpointUrl = 'http://staging.php-dev.in:8844/trainingapp/api/products/getDetail';
    Map<String,String> queryParams = {
      "product_id" :id.toString()
    };
    String queryString = Uri(queryParameters: queryParams).query;
    var requestUrl = endpointUrl + '?' + queryString;
    var res= await http.get(requestUrl);//?product_category_id=1&limit=10&page=1
    var body=json.decode(res.body);
    if(res.statusCode==200){
      ProductDetails proDetails=ProductDetails.fromJson(body);
      detailSink.add(proDetails);
    }
  }
  void dispose(){
    stateStreamController.close();
  }
}