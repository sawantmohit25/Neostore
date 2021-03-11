import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:core';
import 'package:image_picker/image_picker.dart';
class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  File _image;
  Color myHexColor1 = Color(0xfffe3f3f);
  Color myHexColor = Color(0xffe91c1a);
  final _formKey = GlobalKey<FormState>();
  TextEditingController firstNameContr = TextEditingController();
  TextEditingController lastNameContr = TextEditingController();
  TextEditingController emailContr = TextEditingController();
  TextEditingController phoneNoContr = TextEditingController();
  TextEditingController dobContr = TextEditingController();

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:myHexColor1,
      appBar:AppBar(
        title: Text('Edit Profile'),
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
                child:Column(
                  children: [
                    SizedBox(height: 20.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          child: Container(
                            width: 133.0,
                            height:133.0,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(image:_image!=null?FileImage(_image): NetworkImage('https://www.pngitem.com/pimgs/m/4-40070_user-staff-man-profile-user-account-icon-jpg.png'),
                                  fit: BoxFit.fill),),
                          ),
                          onTap:(){
                            pickImage();
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 20.0),
                    Form(
                      key: _formKey,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      child:Column(
                        children: [
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
                          SizedBox(height: 13.0),
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
                              hintText: 'DOB',
                              errorStyle: TextStyle(color: Colors.white),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 5.0),
                              hintStyle: TextStyle(color: Colors.white),
                              prefixIcon:
                              Icon(Icons.cake, color: Colors.white),
                            ),
                            keyboardType: TextInputType.datetime,
                            controller:dobContr,
                            style: TextStyle(color: Colors.white),
                            cursorColor: Colors.white,
                            onTap: ()async{
                              // DateTime date = DateTime(1900);
                              FocusScope.of(context).requestFocus(new FocusNode());

                              DateTime date = await showDatePicker(context: context,
                                  initialDate:DateTime.now(),
                                  firstDate:DateTime(1900),
                                  lastDate: DateTime(2022),
                              );

                              String formatDate= DateFormat("yyyy-MM-dd").format(date);
                              dobContr.text =formatDate;
                            },
                          ),
                          SizedBox(height: 13.0),
                          Container(
                            height:47,
                            width:double.infinity,
                            child: RaisedButton(
                              onPressed: (){

                              },
                              child: Text(
                                "SUBMIT",
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
                      )
                    )
                  ],
                ))
            ],
          ),
        ),
      ),
    );
  }
  Future pickImage() async{
    PickedFile image= await ImagePicker().getImage(source:ImageSource.gallery);
    setState(() {
      _image=image as File;
    });
  }
}
