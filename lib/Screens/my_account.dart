import 'package:flutter/material.dart';
import 'package:neostore_app/usermodel.dart';
import 'package:neostore_app/bloc/login_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
class MyAccount extends StatefulWidget {
  @override
  _MyAccountState createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  Color myHexColor1 = Color(0xfffe3f3f);
  Color myHexColor = Color(0xffe91c1a);
  String firstName,lastName,email,profilePic,phoneNo,dob;
  @override
  void initState() {
    getData();
    super.initState();
  }
  getData() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      firstName=prefs.getString("key1");
      print('Driver ${firstName}');
      lastName=prefs.getString("key2");
      email=prefs.getString("key3");
      profilePic=prefs.getString("key4");
      phoneNo=prefs.getString("key5");
      dob=prefs.getString("key6");
    });
  }
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
            Navigator.pop(context);
          },
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search),
          ),
        ],
      ),
      body:SingleChildScrollView(
        child: Container(
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
                            Container(
                              width: 133.0,
                              height:133.0,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(image: NetworkImage('https://www.pngitem.com/pimgs/m/4-40070_user-staff-man-profile-user-account-icon-jpg.png'),
                                    fit: BoxFit.fill),),
                            ),
                          ],
                        ),
                        SizedBox(height: 20.0),
                        TextField(
                          decoration: InputDecoration(
                              disabledBorder:OutlineInputBorder(borderSide: BorderSide(color: Colors.white, width: 0.0),) ,
                            prefixIcon:Icon(Icons.person,color:Colors.white),
                            labelText:firstName,
                              labelStyle:TextStyle(color:Colors.white),
                        ),
                          enabled: false,
                        ),
                        SizedBox(height: 13.0),
                        TextField(
                          decoration: InputDecoration(
                            disabledBorder:OutlineInputBorder(borderSide: BorderSide(color: Colors.white, width: 0.0),) ,
                            prefixIcon:Icon(Icons.person,color:Colors.white),
                            labelText:lastName,
                            labelStyle:TextStyle(color:Colors.white),
                          ),
                          enabled: false,
                        ),
                        SizedBox(height: 13.0),
                        TextField(
                          decoration: InputDecoration(
                            disabledBorder:OutlineInputBorder(borderSide: BorderSide(color: Colors.white, width: 0.0),) ,
                            prefixIcon:Icon(Icons.email,color:Colors.white),
                            labelText:email,
                            labelStyle:TextStyle(color:Colors.white),
                          ),
                          enabled: false,
                        ),
                        SizedBox(height: 13.0),
                        TextField(
                          decoration: InputDecoration(
                            disabledBorder:OutlineInputBorder(borderSide: BorderSide(color: Colors.white, width: 0.0),) ,
                            prefixIcon:Icon(Icons.phone_android,color:Colors.white),
                            labelText:phoneNo,
                            labelStyle:TextStyle(color:Colors.white),
                          ),
                          enabled: false,
                        ),
                        SizedBox(height: 13.0),
                        TextField(
                          decoration: InputDecoration(
                            disabledBorder:OutlineInputBorder(borderSide: BorderSide(color: Colors.white, width: 0.0),) ,
                            prefixIcon:Icon(Icons.cake,color:Colors.white),
                            labelText:dob!=null?dob:'Edit your DoB',
                            labelStyle:TextStyle(color:Colors.white),
                          ),
                          enabled: false,
                        ),
                        SizedBox(height: 20.0),
                        Container(
                          height:47,
                          width:double.infinity,
                          child: RaisedButton(
                            onPressed: (){},
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
                  onPressed: (){},
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
        ),

      ),
    );
  }
}
