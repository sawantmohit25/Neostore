import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:neostore_app/bloc/reset_bloc.dart';
import 'package:neostore_app/screens/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
class ResetPass extends StatefulWidget {
  @override
  _ResetPassState createState() => _ResetPassState();
}

class _ResetPassState extends State<ResetPass> {
  Color myHexColor1 = Color(0xfffe3f3f);
  Color myHexColor = Color(0xffe91c1a);
  final _formKey = GlobalKey<FormState>();
  final resetObj= ResetBloc();
  String accessToken;
  bool navError=false,isLoading=false;
  TextEditingController currPasswordContr = TextEditingController();
  TextEditingController newPasswordContr = TextEditingController();
  TextEditingController confirmPasswordContr = TextEditingController();
  String validateConfirmPass(val) {
    if (val.isEmpty) {
      return 'Required';
    }
    else if(val.toString().length<6)
        {
      return 'Password should be minimum of 6 characters';
    }
    else if(newPasswordContr.text!=confirmPasswordContr.text){
      return'Password Not Matched';
    }
    else{
      return null;
    }
  }
  String validateNewPass(val) {
    if (val.isEmpty) {
      return 'Required';
    }
    else if(val.toString().length<6)
        {
      return 'Password should be minimum of 6 characters';
    }
    else{
      return null;
    }

  }
  String validateCurrentPass(val) {
    if (val.isEmpty) {
      return 'Required';
    }
    else if(val.toString().length<6)
        {
      return 'Password should be minimum of 6 characters';
    }
    else{
      return null;
    }
  }
  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      accessToken=prefs.getString("accessToken");
      print('omkar${accessToken}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myHexColor1,
      appBar:AppBar(
        title: Text('Reset Password'),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: myHexColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_sharp),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body:SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Padding(padding:EdgeInsets.fromLTRB(33.0,0,33.0,0),
              child:Container(
                child: Form(
                  key:_formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child:Column(
                    children: [
                      Padding(
                        padding:const EdgeInsets.fromLTRB(25,50,25,0),
                        child: Text('NeoSTORE', style: TextStyle(
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2.0,
                            color: Colors.white,
                            fontSize: 45.0),),
                      ),
                      SizedBox(height: 49.0),
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
                          hintText: 'Current Password',
                          errorStyle: TextStyle(color: Colors.white),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 5.0),
                          hintStyle: TextStyle(color: Colors.white),
                          prefixIcon: Icon(
                            Icons.lock,
                            color: Colors.white,
                          ),),
                        controller:currPasswordContr,
                        validator: validateCurrentPass,
                        obscureText:true,
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
                          hintText: 'New Password',
                          errorStyle: TextStyle(color: Colors.white),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 5.0),
                          hintStyle: TextStyle(color: Colors.white),
                          prefixIcon: Icon(
                            Icons.lock,
                            color: Colors.white,
                          ),),
                        controller:newPasswordContr,
                        validator:validateNewPass,
                        obscureText:true,
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
                         ),
                        controller:confirmPasswordContr,
                        obscureText:true,
                        validator: validateConfirmPass,
                        style: TextStyle(color: Colors.white),
                        cursorColor: Colors.white,
                      ),
                      SizedBox(height: 13.0),
                      isLoading==false?Container(
                        height:47,
                        width:double.infinity,
                        child: RaisedButton(
                          onPressed: (){
                            print('hi${accessToken}');
                            if(_formKey.currentState.validate()) {
                              setState(() {
                                navError=true;
                                isLoading=!isLoading;
                              });
                              final String currentPassword=currPasswordContr.text;
                              final String newPassword=newPasswordContr.text;
                              final String confirmPassword=confirmPasswordContr.text;
                              print('hi${accessToken}');
                              print('hi${newPassword}');
                              resetObj.postData(currentPassword,newPassword,confirmPassword,accessToken);
                            }
                          },
                          child: Text(
                            "RESET PASSWORD",
                            style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                          ),
                          color: Colors.white,
                          textColor: Colors.red,
                          splashColor: Colors.red,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6.0),
                              side: BorderSide(color: Colors.red)),
                        ),
                      ):CircularProgressIndicator(),
                      navError==true?
                      StreamBuilder<String>(
                          stream: resetObj.resetStream,
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
                              if(resetObj.statusCode==200) {
                                // if(snapshot.data=='Logged In successfully')
                                Future.delayed(
                                    const Duration(seconds: 1), () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(builder: (context) =>
                                          LoginScreen()));
                                });
                              }
                            }
                            //WidgetsBinding.instance.addPostFrameCallback((_) =>Scaffold.of(context).showSnackBar(getSnackBar(snapshot.data)) );
                            return Text('');
                          }) :Text(''),
                    ],
                  ),
                ),
              ),)
            ],
          ),
        ),
      )
    );
  }
}
