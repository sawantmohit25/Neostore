import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/gestures.dart';
import 'package:neostore_app/model_classes/usermodel.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:neostore_app/bloc/register_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}
class _RegisterScreenState extends State<RegisterScreen> {
  Color myHexColor = Color(0xffe91c1a);
  Color myHexColor1 = Color(0xfffe3f3f);
  // @override
  // void initState() {
  //     SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
  //     super.initState();
  //   }
  TextEditingController firstNameContr = TextEditingController();
  TextEditingController lastNameContr = TextEditingController();
  TextEditingController emailContr = TextEditingController();
  TextEditingController passwordContr = TextEditingController();
  TextEditingController confirmPasswordContr = TextEditingController();
  TextEditingController phoneNoContr = TextEditingController();
  String gender1;
  bool isValidateRadio1 =false,checkValue=false,hiddenValue=true,hiddenValue1=true,isLoading=false;
  final registerObj = RegisterBloc();
  final _formKey = GlobalKey<FormState>();
  var _scaffoldKey = new GlobalKey<ScaffoldState>();
  progressState(){
    registerObj.registerStream.listen((event) {
      if(event.isNotEmpty){
        Fluttertoast.showToast(
            msg:event,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.white,
            textColor: Colors.red
        );
        if (registerObj.statusCode == 200) {
          setState(() {
            isLoading=false;
          });
          //if(snapshot.data=='Registration successful')
          Future.delayed(const Duration(seconds: 1), () {
            Navigator.pop(context);
          });
        }
        else{
          setState(() {
            isLoading=false;
          });
        }
      }
    });
  }
  String validatePhone(val) {
    if (val.isEmpty) {
      return 'Required';
    }
    if (val.length < 10) {
      return 'Please enter a 10 digit Phone Number';
    }
    if (val.length > 10) {
      return 'Please enter a 10 digit Phone Number';
    }
    return null;
  }

  String validateLastName(val) {
    if (val.isEmpty) {
      return 'Required';
    }
    if (!RegExp(r'^[a-z A-Z,.\-]+$').hasMatch(val)) {
      return 'Please Enter A valid Name';
    }
    return null;
  }

  String validateFirstName(val) {
    if (val.isEmpty) {
      return 'Required';
    }
    if (!RegExp(r'^[a-z A-Z,.\-]+$').hasMatch(val)) {
      return 'Please Enter A valid Name';
    }
    return null;
  }

  String validateEmail(val) {
    if (val.isEmpty) {
      return 'Required';
    }
    if (!RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(val)) {
      return 'Please Enter a valid Email Address';
    }
    return null;
  }
  String validateConfirmPass(val) {
    if (val.isEmpty) {
      return 'Required';
    }
    else if(val.toString().length<6) // Can be used Regex for extra validation Minimum 1 uppercase,lowercase,1 numeric number,1 special character,allow common char RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$'
        {
      return 'Password should be minimum of 6 characters';
    }
    else if(passwordContr.text!=confirmPasswordContr.text){
      return'Password Not Matched';
    }
    else{
      return null;
    }
  }
  String validatePass(val) {
    if (val.isEmpty) {
      return 'Required';
    }
    else if(val.toString().length<6) // Can be used Regex for extra validation Minimum 1 uppercase,lowercase,1 numeric number,1 special character,allow common char RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$'
        {
      return 'Password should be minimum of 6 characters';
    }
    else{
      return null;
    }
  }
  @override
  void dispose() {
    registerObj.dispose();
    // TODO: implement dispose
    super.dispose();
  }
  @override
  void initState() {
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    // setState(() {
    //   SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    // });
    print('hey');
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor:myHexColor1,
      appBar: AppBar(
        title: Text('Register'),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor:myHexColor,
        leading:IconButton(icon:Icon(Icons.arrow_back_ios_sharp ),onPressed: (){Navigator.pop(context);},)
      ),
      body:SingleChildScrollView(
        child: Padding(
          padding:EdgeInsets.fromLTRB(33.0,0,33.0,0),
          child:Container(
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(25,25,25,0),
                    child: Text('NeoSTORE', style: TextStyle(
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2.0,
                        color: Colors.white,
                        fontSize: 45.0),),
                  ),
                  SizedBox(height: 13.0,),
                  TextFormField(decoration: InputDecoration(
                    enabledBorder: const OutlineInputBorder(borderSide: const BorderSide(color: Colors.white, width: 0.0),),
                    border: OutlineInputBorder(),
                    errorBorder:OutlineInputBorder(borderSide: BorderSide(color: Colors.white, width: 0.0),) ,
                    focusedErrorBorder:OutlineInputBorder(borderSide: BorderSide(color: Colors.white, width: 0.0),),
                    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white, width: 0.0),),
                    hintText:'First Name',
                      errorStyle: TextStyle(color: Colors.white),
                    contentPadding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 5.0),
                  hintStyle:TextStyle(color:Colors.white),
                  prefixIcon:Icon(Icons.person,color:Colors.white),
                  ),
                    controller: firstNameContr,
                    validator:validateFirstName,
                    keyboardType: TextInputType.name,
                    style: TextStyle(color: Colors.white),
                    cursorColor: Colors.white,
                  ),
                  SizedBox(height: 13.0),
                  TextFormField(decoration: InputDecoration(
                      enabledBorder: const OutlineInputBorder(borderSide: const BorderSide(color: Colors.white, width: 0.0),),
                      border: OutlineInputBorder(),
                      errorBorder:OutlineInputBorder(borderSide: BorderSide(color: Colors.white, width: 0.0),) ,
                      focusedErrorBorder:OutlineInputBorder(borderSide: BorderSide(color: Colors.white, width: 0.0),),
                      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white, width: 0.0),),
                      hintText: 'Last Name',
                      errorStyle: TextStyle(color: Colors.white),
                      contentPadding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 5.0),
                      hintStyle:TextStyle(color:Colors.white),
                      prefixIcon:Icon(Icons.person,color: Colors.white,)),
                    controller: lastNameContr,
                    validator: validateLastName,
                    keyboardType: TextInputType.name,
                    style: TextStyle(color: Colors.white),
                    cursorColor: Colors.white,
                  ),
                  SizedBox(height: 13.0),
                  TextFormField(decoration: InputDecoration(
                    enabledBorder: const OutlineInputBorder(borderSide: const BorderSide(color: Colors.white, width: 0.0),),
                    border: OutlineInputBorder(),
                    errorBorder:OutlineInputBorder(borderSide: BorderSide(color: Colors.white, width: 0.0),) ,
                    focusedErrorBorder:OutlineInputBorder(borderSide: BorderSide(color: Colors.white, width: 0.0),),
                    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white, width: 0.0),),
                    hintText: 'Email',
                    errorStyle: TextStyle(color: Colors.white),
                    contentPadding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 5.0),
                    prefixIcon:Icon(Icons.email,color: Colors.white,),
                    hintStyle:TextStyle(color:Colors.white),),
                    controller: emailContr,
                    validator: validateEmail,
                    keyboardType: TextInputType.emailAddress,
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
                        errorBorder:OutlineInputBorder(borderSide: BorderSide(color: Colors.white, width: 0.0),) ,
                        focusedErrorBorder:OutlineInputBorder(borderSide: BorderSide(color: Colors.white, width: 0.0),),
                        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white, width: 0.0),),
                          hintText: 'Password',
                          errorStyle: TextStyle(color: Colors.white),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 5.0),
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
                      controller: passwordContr,
                      validator: validatePass,
                      obscureText:hiddenValue,
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
                        errorBorder:OutlineInputBorder(borderSide: BorderSide(color: Colors.white, width: 0.0),) ,
                        focusedErrorBorder:OutlineInputBorder(borderSide: BorderSide(color: Colors.white, width: 0.0),),
                        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white, width: 0.0),),
                          hintText: 'Confirm Password',
                          errorStyle: TextStyle(color: Colors.white),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 5.0),
                          hintStyle: TextStyle(color: Colors.white),
                          prefixIcon: Icon(
                            Icons.lock,
                            color: Colors.white,
                          ),
                        suffixIcon:IconButton(
                          icon: Icon(hiddenValue1?Icons.visibility:Icons.visibility_off),
                          onPressed: () {setState(() {
                            if(hiddenValue1==true){
                              hiddenValue1=false;
                            }
                            else{
                              hiddenValue1=true;
                            }
                          });
                          },
                          color: Colors.white,
                        ),),
                      controller: confirmPasswordContr,
                      obscureText:hiddenValue1,
                      validator: validateConfirmPass,
                      style: TextStyle(color: Colors.white),
                      cursorColor: Colors.white,
                    ),
                  SizedBox(height: 23.0,),
                  Row(
                    children: [
                      Text('Gender', style: TextStyle(
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2.0,
                          color: Colors.white),),
                      SizedBox(width: 20,),
                      Theme(
                        data: Theme.of(context).copyWith(
                            unselectedWidgetColor: Colors.white,
                            disabledColor: Colors.white
                        ),
                        child: Radio(
                          value: 'M',
                          groupValue: gender1,
                          activeColor: Colors.white,
                          onChanged: (val) {
                            setState(() {
                              gender1 = val;
                            });
                          },
                        ),
                      ),
                      Text(
                        'Male',
                        style: TextStyle(fontSize: 16.0,letterSpacing: 2.0,
                            color: Colors.white),
                      ),

                      Theme(
                        data: Theme.of(context).copyWith(
                            unselectedWidgetColor: Colors.white,
                            disabledColor: Colors.white
                        ),
                        child: Radio(
                          value: 'F',
                          groupValue:gender1,
                          activeColor: Colors.white,
                          onChanged: (val) {
                            setState(() {
                              gender1 = val;
                            });
                          },
                        ),
                      ),
                      Text(
                        'Female',
                        style: TextStyle(
                          fontSize: 16.0,letterSpacing: 2.0,
                            color: Colors.white
                        ),
                      ),
                    ],
                  ),
              isValidateRadio1 && gender1 == null ? Text('Please Select your Gender', style: TextStyle(fontSize: 10, color: Colors.white)):Container() ,
                  SizedBox(height: 23.0,),
                    TextFormField(
                      decoration: InputDecoration(
                        enabledBorder: const OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.white, width: 0.0),
                        ),
                        border: OutlineInputBorder(),
                        errorBorder:OutlineInputBorder(borderSide: BorderSide(color: Colors.white, width: 0.0),) ,
                        focusedErrorBorder:OutlineInputBorder(borderSide: BorderSide(color: Colors.white, width: 0.0),),
                        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white, width: 0.0),),
                        hintText: 'Phone Number',
                        errorStyle: TextStyle(color: Colors.white),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 5.0),
                        hintStyle: TextStyle(color: Colors.white),
                        prefixIcon:
                            Icon(Icons.phone_android, color: Colors.white),
                      ),
                      keyboardType: TextInputType.number,
                      controller: phoneNoContr,
                      validator: validatePhone,
                      style: TextStyle(color: Colors.white),
                      cursorColor: Colors.white,
                    ),
                  Row(
                    children: [
                      Theme(
                        data: Theme.of(context).copyWith(
                            unselectedWidgetColor: Colors.white,
                            disabledColor: Colors.white
                        ),
                        child: Checkbox(
                          checkColor:Colors.black,
                          activeColor: Colors.white,
                          value:checkValue,
                          onChanged: (bool value) {
                            setState(() {
                               checkValue= value;
                            });
                          },
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          text: 'I agree the ',
                          style:TextStyle(fontWeight: FontWeight.bold, fontSize: 13.0, letterSpacing: 2.0, color: Colors.white) ,
                          children: <TextSpan>[
                            TextSpan(text: 'Terms & Conditions',  style: TextStyle(
                              decoration: TextDecoration.underline,fontWeight: FontWeight.bold, fontSize: 13.0, letterSpacing: 2.0,color: Colors.white),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                   print(' Terms and Conditions');
                                  }
                            ),
                          ],
                        ),
                      )
                      // Text('I agree the Terms & Conditions', style: TextStyle(
                      //     fontWeight: FontWeight.bold,
                      //     fontSize: 13.0,
                      //     letterSpacing: 2.0,
                      //     color: Colors.white),),
                    ],
                  ),
                    isLoading==false?Container(
                      height: 47.0,
                      width: 293.0,
                      child: RaisedButton(
                        child: Text(
                          "REGISTER",
                          style: TextStyle(fontSize: 20),
                        ),
                        onPressed: () async{
                          setState(() {
                            isValidateRadio1=true;
                          });
                            if(_formKey.currentState.validate()) {
                                if(gender1!=null && checkValue==true){
                                  setState(() {
                                    isLoading=true;
                                  });
                                  final String firstName=firstNameContr.text;
                                  final String lastName=lastNameContr.text;
                                  final String email=emailContr.text;
                                  final String password=passwordContr.text;
                                  final String confirmPassword=confirmPasswordContr.text;
                                  final String gender=gender1;
                                  final String phoneNo=phoneNoContr.text;
                                  registerObj.postData(firstName, lastName, email, password, confirmPassword, gender, phoneNo);
                                  progressState();
                                  }
                            }
                        },
                        color: Colors.white,
                        textColor: Colors.red,
                        splashColor: Colors.red,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6.0),
                            side: BorderSide(color: Colors.red)),
                      ),
                    ):CircularProgressIndicator(),
                  // StreamBuilder<String>(
                  //     stream: registerObj.registerStream,
                  //     builder: (context, snapshot) {
                  //       if(snapshot.data!=null) {
                  //         Fluttertoast.showToast(
                  //             msg: snapshot.data,
                  //             toastLength: Toast.LENGTH_SHORT,
                  //             gravity: ToastGravity.BOTTOM,
                  //             backgroundColor: Colors.white,
                  //             textColor: Colors.red
                  //         );
                  //         if (registerObj.statusCode == 200) {
                  //           //if(snapshot.data=='Registration successful')
                  //           Future.delayed(const Duration(seconds: 1), () {
                  //             Navigator.pop(context);
                  //           });
                  //         }
                  //       }
                  //       //WidgetsBinding.instance.addPostFrameCallback((_) =>Scaffold.of(context).showSnackBar(getSnackBar(snapshot.data)) );
                  //       return Text('');
                  //     }),
                  ],
              ),
            ),
          )
        ),
      ) ,
    );
  }
}
