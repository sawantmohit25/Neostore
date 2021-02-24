import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/gestures.dart';
import 'package:neostore_app/Screens/forgot_password.dart';
import 'package:neostore_app/Screens/register.dart';
import 'package:neostore_app/Screens/home_screen.dart';
import 'package:neostore_app/usermodel.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}
class _LoginScreenState extends State<LoginScreen> {
  Color myHexColor1 = Color(0xfffe3f3f);
  Color myHexColor = Color(0xffe91c1a);
  @override
  void initState() {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    super.initState();
    // TODO: implement initState
  }
  final _formKey = GlobalKey<FormState>();
  var _scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController userName = TextEditingController();
  TextEditingController password = TextEditingController();
  bool hiddenValue=true;
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
  String validatePass(val) {
    if (val.isEmpty) {
      return 'Required';
    }
    // if (!RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$').hasMatch(val)) //Minimum 1 uppercase,lowercase,1 numeric number,1 special character,allow common char
    //     {
    //   return 'Please Enter A valid Password';
    // }
    return null;
  }
  @override
  Widget build(BuildContext context) {
    setState(() {
      SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    });
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
                          hintText:'Username',
                          errorStyle: TextStyle(color: Colors.white),
                          errorBorder:OutlineInputBorder(borderSide: BorderSide(color: Colors.white, width: 0.0),) ,
                          focusedErrorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white, width: 0.0),),
                          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white, width: 0.0),),
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
                        TextFormField(
                          decoration: InputDecoration(
                            enabledBorder: const OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.white, width: 0.0),
                            ),
                            border: OutlineInputBorder(),
                            hintText: 'Password',
                            errorStyle: TextStyle(color: Colors.white),
                            errorBorder:OutlineInputBorder(borderSide: BorderSide(color: Colors.white, width: 0.0),) ,
                            focusedErrorBorder:OutlineInputBorder(borderSide: BorderSide(color: Colors.white, width: 0.0),),
                            focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white, width: 0.0),),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 18.0, horizontal: 5.0),
                            hintStyle: TextStyle(color: Colors.white),
                            prefixIcon: Icon(
                              Icons.lock,
                              color: Colors.white,
                            ),suffixIcon:IconButton(
                            icon: Icon(hiddenValue?Icons.visibility:Icons.visibility_off),
                            onPressed: () {setState(() {
                              if(hiddenValue==true){
                                hiddenValue=false;
                              }
                              else{
                                hiddenValue=true;
                              }
                            });
                            },
                            color: Colors.white,
                          ),   ),
                          controller: password,
                          validator: validatePass,
                          obscureText:hiddenValue,
                          style: TextStyle(color: Colors.white),
                          cursorColor: Colors.white,
                        ),
                        SizedBox(height: 33.0),
                        Container(
                          height: 47.0,
                          width: 293.0,
                          child: RaisedButton(
                            child: Text(
                              "LOGIN",
                              style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                            ),
                            onPressed: ()async{
                              if(_formKey.currentState.validate()) {
                                final String email=userName.text;
                                final String pass=password.text;
                                Future postData(String email,String password) async {
                                  final String url = 'http://staging.php-dev.in:8844/trainingapp/api/users/login';
                                  final response = await http.post(url, body: {
                                    "email": email,
                                    "password": password,
                                  });
                                  if(response.statusCode==200){
                                    print(response.statusCode);
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
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(builder: (context) => HomeScreen()));
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
                                postData(email, pass);
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
                        SizedBox(height: 21.0),
                        RichText(
                          text: TextSpan(
                            style:TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 18.0) ,
                            text: 'Forgot Password?',
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => ForgotPassword()));
                              }

                          ),
                        )
                      ],
                    ),
                  ) ,
                )
    ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16.0,80.0,0,20.0),
                child: Row(
                  children: [
                    RichText(
                      text: TextSpan(
                        style:TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 18.0) ,
                          text: 'DONT HAVE AN ACCOUNT?',
                      ),
                    ),
                    SizedBox(width:60.0),
                    Container(
                      width:46 ,
                      height:46 ,
                      color:myHexColor,
                      child: IconButton(icon:Icon(Icons.add,size:32,),color:Colors.white, onPressed:(){
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => RegisterScreen()));

                      }),
                    )
                  ],
                ),
              )
            ],
          ),
      ),
    );
  }
}
