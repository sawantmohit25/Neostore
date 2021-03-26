import 'dart:io';

import 'package:flutter/material.dart';
import 'package:neostore_app/model_classes/fetch_details_bloc.dart';
import 'package:neostore_app/model_classes/fetchdetailsmodel.dart';
import 'package:neostore_app/model_classes/usermodel.dart';
import 'package:neostore_app/bloc/login_bloc.dart';
import 'package:neostore_app/screens/edit_profile.dart';
import 'package:neostore_app/screens/home_screen.dart';
import 'package:neostore_app/screens/reset_password.dart';
import 'package:shared_preferences/shared_preferences.dart';
class MyAccount extends StatefulWidget {
  @override
  _MyAccountState createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  Color myHexColor1 = Color(0xfffe3f3f);
  Color myHexColor = Color(0xffe91c1a);
  final fetchDetailsObj =FetchDetailsBloc();
  // String firstName,lastName,email,phoneNo,dob,profile_Pic;
  String accessToken;
  @override
  void initState() {
    getAccessToken();
    // getData();
    super.initState();
  }
  getAccessToken() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      accessToken=prefs.getString("key7");
    });
    fetchDetailsObj.getData(accessToken);
  }
  getRequest() async{
    getAccessToken();
  }
  // getData() async{
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   setState(() {
  //     firstName=prefs.getString("key1");
  //     print('Driver ${firstName}');
  //     lastName=prefs.getString("key2");
  //     email=prefs.getString("key3");
  //     phoneNo=prefs.getString("key5");
  //     dob=prefs.getString("key6");
  //     profile_Pic=prefs.getString("key8");
  //   });
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:myHexColor1,
      appBar: AppBar(
        title: Text('My Account'),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: myHexColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_sharp),
          onPressed: () {
            Navigator.pop(context,true);
            // Navigator.pushReplacement(context,MaterialPageRoute(builder:(context) => HomeScreen()));
          },
        ),
      ),
      body:SingleChildScrollView(
        child: StreamBuilder<FetchDetailsModel>(
          stream:fetchDetailsObj.fetchStream,
          builder: (context, snapshot) {
           if(snapshot.hasData){
             return Container(
               child: Column(
                 children: [
                   Padding(
                     padding:EdgeInsets.fromLTRB(33.0,0,33.0,0),
                     child: Column(
                       children: [
                         SizedBox(height: 20.0),
                         Row(
                           mainAxisAlignment: MainAxisAlignment.center,
                           children: [
                             snapshot.data.data.userData.profilePic!=null?Container(
                               width: 133.0,
                               height:133.0,
                               decoration: BoxDecoration(
                                 shape: BoxShape.circle,
                                 image: DecorationImage(image: NetworkImage(snapshot.data.data.userData.profilePic), fit: BoxFit.fill),),
                             ):Container(
                               width: 133.0,
                               height:133.0,
                               decoration:BoxDecoration(shape: BoxShape.circle,color: Colors.white),
                               child:Center(child: Text(snapshot.data.data.userData.firstName[0]+snapshot.data.data.userData.lastName[0],textAlign:TextAlign.center,style: TextStyle(fontSize:40,color: Colors.red),)),)
                           ],
                         ),
                         SizedBox(height: 20.0),
                         TextField(
                           decoration: InputDecoration(
                             disabledBorder:OutlineInputBorder(borderSide: BorderSide(color: Colors.white, width: 0.0),) ,
                             prefixIcon:Icon(Icons.person,color:Colors.white),
                             labelText:snapshot.data.data.userData.firstName,
                             labelStyle:TextStyle(color:Colors.white),
                           ),
                           enabled: false,
                         ),
                         SizedBox(height: 13.0),
                         TextField(
                           decoration: InputDecoration(
                             disabledBorder:OutlineInputBorder(borderSide: BorderSide(color: Colors.white, width: 0.0),) ,
                             prefixIcon:Icon(Icons.person,color:Colors.white),
                             labelText:snapshot.data.data.userData.lastName,
                             labelStyle:TextStyle(color:Colors.white),
                           ),
                           enabled: false,
                         ),
                         SizedBox(height: 13.0),
                         TextField(
                           decoration: InputDecoration(
                             disabledBorder:OutlineInputBorder(borderSide: BorderSide(color: Colors.white, width: 0.0),) ,
                             prefixIcon:Icon(Icons.email,color:Colors.white),
                             labelText:snapshot.data.data.userData.email,
                             labelStyle:TextStyle(color:Colors.white),
                           ),
                           enabled: false,
                         ),
                         SizedBox(height: 13.0),
                         TextField(
                           decoration: InputDecoration(
                             disabledBorder:OutlineInputBorder(borderSide: BorderSide(color: Colors.white, width: 0.0),) ,
                             prefixIcon:Icon(Icons.phone_android,color:Colors.white),
                             labelText:snapshot.data.data.userData.phoneNo,
                             labelStyle:TextStyle(color:Colors.white),
                           ),
                           enabled: false,
                         ),
                         SizedBox(height: 13.0),
                         TextField(
                           decoration: InputDecoration(
                             disabledBorder:OutlineInputBorder(borderSide: BorderSide(color: Colors.white, width: 0.0),) ,
                             prefixIcon:Icon(Icons.cake,color:Colors.white),
                             labelText:snapshot.data.data.userData.dob!=null?snapshot.data.data.userData.dob:'Edit your DoB',
                             labelStyle:TextStyle(color:Colors.white),
                           ),
                           enabled: false,
                         ),
                         SizedBox(height: 20.0),
                         Container(
                           height:47,
                           width:double.infinity,
                           child: RaisedButton(
                             onPressed: (){
                               Navigator.push(context,MaterialPageRoute(builder:(context) => EditProfile())).then((value) => value?getRequest():null);
                             },
                             child: Text(
                               "EDIT PROFILE",
                               style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                             ),
                             color: Colors.white,
                             textColor: Colors.red,
                             splashColor: Colors.red,
                             shape: RoundedRectangleBorder(
                                 borderRadius: BorderRadius.circular(6.0),
                                 side: BorderSide(color: Colors.red)),
                           ),
                         ),
                       ],
                     ),
                   ),
                   SizedBox(height:36),
                   Container(
                     height: 52.0,
                     width: double.infinity,
                     child: RaisedButton(
                       onPressed: (){
                         Navigator.push(context,MaterialPageRoute(builder:(context) => ResetPass()));
                       },
                       child: Text(
                         "RESET PASSWORD",
                         style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),
                       ),
                       color: Colors.white,
                       textColor: Colors.red,
                       splashColor: Colors.red,
                       shape: RoundedRectangleBorder(
                           borderRadius: BorderRadius.circular(6.0),
                           side: BorderSide(color: Colors.red)),
                     ),
                   ),
                 ],
               ),
             );
           }
           else{
             return Center(child: CircularProgressIndicator());
           }
          }
        ),

      ),
    );
  }
}
