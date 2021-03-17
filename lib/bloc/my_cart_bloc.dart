import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:neostore_app/model_classes/mycartmodel.dart';

class MyCartBloc{
  final stateStreamController =StreamController<MyCartModel>.broadcast();
  StreamSink<MyCartModel> get myCartSink => stateStreamController.sink;
  Stream<MyCartModel> get myCartStream =>stateStreamController.stream;

  getData(String accessToken) async{
    var endpointUrl ='http://staging.php-dev.in:8844/trainingapp/api/cart';
    var res=await http.get(endpointUrl,headers: {"access_token":accessToken});
    var body=json.decode(res.body);
    if(res.statusCode==200){
      print(res.statusCode);
      MyCartModel cartList=MyCartModel.fromJson(body);
      myCartSink.add(cartList);
      print('headshot${cartList}');
    }
    else{
      print(res.statusCode);
    }

  }
  void dispose(){
    stateStreamController.close();
  }

}