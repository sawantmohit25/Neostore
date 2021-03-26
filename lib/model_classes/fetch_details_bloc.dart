import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:neostore_app/model_classes/fetchdetailsmodel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FetchDetailsBloc{
  final  stateStreamController = StreamController<FetchDetailsModel>.broadcast();
  StreamSink<FetchDetailsModel> get fetchSink => stateStreamController.sink;
  Stream<FetchDetailsModel> get fetchStream =>stateStreamController.stream;

  getData(String accessToken) async{
    var endpointUrl ='http://staging.php-dev.in:8844/trainingapp/api/users/getUserData';
    var res=await http.get(endpointUrl,headers: {"access_token":accessToken});
    var body=json.decode(res.body);
    if(res.statusCode==200){
      print(res.statusCode);
      FetchDetailsModel fetchData=FetchDetailsModel.fromJson(body);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("key1",fetchData.data.userData.firstName);
      prefs.setString('key2',fetchData.data.userData.lastName);
      prefs.setString('key3',fetchData.data.userData.email);
      // prefs.setString('key4',success.data.profilePic);
      prefs.setString('key5',fetchData.data.userData.phoneNo);
      prefs.setString('key6',fetchData.data.userData.dob);
      prefs.setString("key7",fetchData.data.userData.accessToken);
      prefs.setString("key8",fetchData.data.userData.profilePic);
      fetchSink.add(fetchData);
    }
    else{
      print(res.statusCode);
    }

  }
  void dispose(){
    stateStreamController.close();
  }
}