import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:neostore_app/Screens/login.dart';
import 'package:neostore_app/usermodel.dart';
import 'dart:convert';
class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  Color myHexColor1 = Color(0xfffe3f3f);
  Color myHexColor = Color(0xffe91c1a);
  final _formKey = GlobalKey<FormState>();
  var _scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController userName = TextEditingController();
  String validateUserName(val) {
    if (val.isEmpty) {
      return 'Required';
    }
    if (!RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(val)) {
      return 'Please Enter a valid UserName';
    }
    return null;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor:myHexColor1,
      body:SingleChildScrollView(
        child: Column(
          children: [
            Padding(
                padding:EdgeInsets.fromLTRB(33.0,0,33.0,0),
                child: Container(
                  child:Form(
                    key: _formKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(25,150,25,0),
                          child: Text('NeoSTORE', style: TextStyle(
                              fontWeight: FontWeight.bold,
                              letterSpacing: 2.0,
                              color: Colors.white,
                              fontSize: 45.0),),
                        ),
                        SizedBox(height: 49.0),
                        TextFormField(decoration: InputDecoration(
                          enabledBorder: const OutlineInputBorder(borderSide: const BorderSide(color: Colors.white, width: 0.0),),
                          border: OutlineInputBorder(),
                          errorBorder:OutlineInputBorder(borderSide: BorderSide(color: Colors.white, width: 0.0),) ,
                          focusedErrorBorder:OutlineInputBorder(borderSide: BorderSide(color: Colors.white, width: 0.0),),
                          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white, width: 0.0),),
                          hintText:'Username',
                          errorStyle: TextStyle(color: Colors.white),
                          contentPadding: EdgeInsets.symmetric(vertical: 18.0,horizontal: 5.0),
                          hintStyle:TextStyle(color:Colors.white),
                          prefixIcon:Icon(Icons.person,color:Colors.white),
                        ),
                          controller: userName,
                          validator:validateUserName,
                          keyboardType: TextInputType.name,
                          style: TextStyle(color: Colors.white),
                          cursorColor: Colors.white,
                        ),
                        SizedBox(height: 13.0),
                        SizedBox(height: 33.0),
                        Container(
                          height: 47.0,
                          width: 293.0,
                          child: RaisedButton(
                            child: Text(
                              "SUBMIT",
                              style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                            ),
                            onPressed: () async{
                              if(_formKey.currentState.validate()) {
                                final String email=userName.text;
                                Future postData(String email) async {
                                  final String url = 'http://staging.php-dev.in:8844/trainingapp/api/users/forgot';
                                  final response = await http.post(url, body: {
                                    "email": email,
                                  });
                                  if(response.statusCode==200){
                                    print(response.statusCode);
                                    print(response.body);
                                    print(email);
                                    var success =ResponseModel.fromJson(json.decode(response.body));
                                    print(success.userMsg);
                                    _scaffoldKey.currentState.showSnackBar(
                                        SnackBar(
                                          content:Text(success.userMsg),
                                          backgroundColor: Colors.blue,
                                          duration:Duration(seconds: 5),
                                          action: SnackBarAction(
                                            label: 'Ok',
                                            textColor: Colors.white,
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                        )
                                    );
                                  }
                                  if(response.statusCode==401){
                                    var error =ErrorModel.fromJson(json.decode(response.body));
                                    print(error.userMsg);
                                    _scaffoldKey.currentState.showSnackBar(
                                        SnackBar(
                                          content:Text(error.userMsg),
                                          backgroundColor: Colors.blue,
                                          duration:Duration(seconds: 2),
                                        )
                                    );
                                    print(response.statusCode);
                                    return null;
                                  }
                                }
                                postData(email);
                              }
                            },
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
                  ) ,
                )
            ),
          ],
        ),
      ),
    );
  }
}
