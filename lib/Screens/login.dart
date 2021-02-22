import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:neostore_app/Screens/forgot_password.dart';
import 'package:neostore_app/Screens/register.dart';
import 'package:neostore_app/Screens/home_screen.dart';
class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Color myHexColor1 = Color(0xfffe3f3f);
  Color myHexColor = Color(0xffe91c1a);
  final _formKey = GlobalKey<FormState>();
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
    if (!RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$').hasMatch(val)) //Minimum 1 uppercase,lowercase,1 numeric number,1 special character,allow common char
        {
      return 'Please Enter A valid Password';
    }
    return null;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:myHexColor1,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add,size:48.0 ),

        backgroundColor: myHexColor,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(),
        onPressed: () => {
        Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => RegisterScreen()))
        },
      ),
      body: SingleChildScrollView(
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
                        labelText:'Username',
                        errorStyle: TextStyle(color: Colors.white),
                        contentPadding: EdgeInsets.symmetric(vertical: 18.0,horizontal: 5.0),
                        labelStyle:TextStyle(color:Colors.white),
                        prefixIcon:Icon(Icons.person,color:Colors.white),
                      ),
                        controller: userName,
                        validator:validateUserName,
                        keyboardType: TextInputType.name,
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(height: 13.0),
                      TextFormField(
                        decoration: InputDecoration(
                          enabledBorder: const OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.white, width: 0.0),
                          ),
                          border: OutlineInputBorder(),
                          labelText: 'Password',
                          errorStyle: TextStyle(color: Colors.white),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 18.0, horizontal: 5.0),
                          labelStyle: TextStyle(color: Colors.white),
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
                          onPressed: () {
                            if(_formKey.currentState.validate()) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => HomeScreen()));
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
                      // Text('Forgot Password?', style: TextStyle(
                      //     fontWeight: FontWeight.bold,
                      //     color: Colors.white,
                      //     fontSize: 18.0),),
                    ],
                  ),
                ) ,
              )
    ),
            Container(margin: EdgeInsets.fromLTRB(0,90 ,100 ,0),
            child:RichText(
              text: TextSpan(
                style:TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 18.0) ,
                  text: 'DONT HAVE AN ACCOUNT?',
              ),
            ))
          ],
        ),
      ),
    );
  }
}
