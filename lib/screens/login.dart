import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/gestures.dart';
import 'package:neostore_app/Screens/forgot_password.dart';
import 'package:neostore_app/Screens/register.dart';
import 'package:neostore_app/Screens/home_screen.dart';
import 'package:neostore_app/model_classes/usermodel.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:neostore_app/bloc/login_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}
class _LoginScreenState extends State<LoginScreen> {
  Color myHexColor1 = Color(0xfffe3f3f);
  Color myHexColor = Color(0xffe91c1a);
  @override
  void initState() {
    SystemChrome.setEnabledSystemUIOverlays([]);
    super.initState();
    // TODO: implement initState
  }
  final _formKey = GlobalKey<FormState>();
  final loginObj = LoginBloc();
  var _scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController userName = TextEditingController();
  TextEditingController password = TextEditingController();
  bool hiddenValue=true,navError=false;
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
  void dispose() {
    loginObj.dispose();
    userName.dispose();
    password.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    print('hi');
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
                              setState(() {
                                navError=true;
                              });
                              if(_formKey.currentState.validate()) {
                                final String email=userName.text;
                                final String pass=password.text;
                                loginObj.postData(email,pass);
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
                        navError==true?
                        StreamBuilder<String>(
                            stream: loginObj.loginStream,
                            builder: (context, snapshot) {
                              if(snapshot.data!=null)
                              {
                                navError=false;
                                Fluttertoast.showToast(
                                    msg:snapshot.data,
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    backgroundColor: Colors.white,
                                    textColor: Colors.red
                                );
                                if(loginObj.statusCode==200) {
                                  // if(snapshot.data=='Logged In successfully')
                                  Future.delayed(
                                      const Duration(seconds: 1), () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) =>
                                            HomeScreen()));
                                  });
                                }
                              }
                              //WidgetsBinding.instance.addPostFrameCallback((_) =>Scaffold.of(context).showSnackBar(getSnackBar(snapshot.data)) );
                              return Text('');
                            }) :Text(''),
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
              SizedBox(height: 160.0,),
              Padding(
                padding: const EdgeInsets.fromLTRB(13.0,0,13.0,0),
                //padding: EdgeInsets.only(bottom: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RichText(
                      text: TextSpan(
                        style:TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 16.0) ,
                        text: 'DONT HAVE AN ACCOUNT?',
                      ),
                    ),
                    Container(
                      width:46 ,
                      height:46 ,
                      color:myHexColor,
                      child: IconButton(icon:Icon(Icons.add,size:32,),color:Colors.white, onPressed:(){
                        Navigator.pushReplacement(
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
