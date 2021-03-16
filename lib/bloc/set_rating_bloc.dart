import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:neostore_app/model_classes/setratingmodel.dart';
class SetRatingBloc{
  final stateStreamController=StreamController<SetRatingModel>.broadcast();
  StreamSink<SetRatingModel> get ratingSink =>stateStreamController.sink;
  Stream<SetRatingModel> get ratingStream =>stateStreamController.stream;
  var statusCode;
  postData(var rating,String id) async {
    final String url = 'http://staging.php-dev.in:8844/trainingapp/api/products/setRating';
    final response = await http.post(url, body: {
      "product_id":id,
      "rating" :rating
    });
    print(response.statusCode);
    if(response.statusCode==200){
      statusCode=response.statusCode;
      print(response.statusCode);
      var success =SetRatingModel.fromJson(json.decode(response.body));
      print(success.userMsg);
      ratingSink.add(success);
    }
    else if(response.statusCode==404){
      statusCode=response.statusCode;
      var error =SetRatingModel.fromJson(json.decode(response.body));
      print(error.userMsg);
      ratingSink.add(error);
    }
  }
  void dispose(){
    stateStreamController.close();
  }
}