import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/gestures.dart';
import 'package:neostore_app/usermodel.dart';
class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}
Future<UserModel> postData(String firstName,String lastName,String email,String password,String confirmPassword,String gender,String phoneNo) async{
  final String url= 'http://staging.php-dev.in:8844/trainingapp/api/users/register';
  final response = await http.post(url,body :{
    "firstName": firstName,
    "lastName":lastName,
    "email":email,
    "password":password,
    "confirmPassword":confirmPassword,
    "gender":gender,
    "phoneNo":phoneNo
  });
  if(response.statusCode==200){
    return userModelFromJson(response.body);
  }
  else{
    print('NULL value passing');
    return null;
  }
}
class _RegisterScreenState extends State<RegisterScreen> {
  Color myHexColor = Color(0xffe91c1a);
  Color myHexColor1 = Color(0xfffe3f3f);
  TextEditingController firstNameContr = TextEditingController();
  TextEditingController lastNameContr = TextEditingController();
  TextEditingController emailContr = TextEditingController();
  TextEditingController passwordContr = TextEditingController();
  TextEditingController confirmPasswordContr = TextEditingController();
  TextEditingController phoneNoContr = TextEditingController();
  String gender1;
  bool isValidateRadio1 = false,checkValue=false,hiddenValue=true,hiddenValue1=true;
  UserModel _user;
  final _formKey = GlobalKey<FormState>();
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
    if (!RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$').hasMatch(val)) //Minimum 1 uppercase,lowercase,1 numeric number,1 special character,allow common char
    {
      return 'Please Enter A valid Password';
    }
    if(passwordContr.text!=confirmPasswordContr.text){
      return'Password Not Matched';
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
      appBar: AppBar(
        title: Text('Register'),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor:myHexColor,
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
                    labelText:'First Name',
                      errorStyle: TextStyle(color: Colors.white),
                    contentPadding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 5.0),
                  labelStyle:TextStyle(color:Colors.white),
                  prefixIcon:Icon(Icons.person,color:Colors.white),
                  ),
                    controller: firstNameContr,
                    validator:validateFirstName,
                    keyboardType: TextInputType.name,
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(height: 7.0),
                  TextFormField(decoration: InputDecoration(
                      enabledBorder: const OutlineInputBorder(borderSide: const BorderSide(color: Colors.white, width: 0.0),),
                      border: OutlineInputBorder(),
                      labelText: 'Last Name',
                      errorStyle: TextStyle(color: Colors.white),
                      contentPadding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 5.0),
                      labelStyle:TextStyle(color:Colors.white),
                      prefixIcon:Icon(Icons.person,color: Colors.white,)),
                    controller: lastNameContr,
                    validator: validateLastName,
                    keyboardType: TextInputType.name,
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(height: 7.0),
                  TextFormField(decoration: InputDecoration(
                    enabledBorder: const OutlineInputBorder(borderSide: const BorderSide(color: Colors.white, width: 0.0),),
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                    errorStyle: TextStyle(color: Colors.white),
                    contentPadding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 5.0),
                    prefixIcon:Icon(Icons.email,color: Colors.white,),
                    labelStyle:TextStyle(color:Colors.white),),
                    controller: emailContr,
                    validator: validateEmail,
                    keyboardType: TextInputType.emailAddress,
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(height: 7.0),
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
                              vertical: 10.0, horizontal: 5.0),
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
                      controller: passwordContr,
                      validator: validatePass,
                      obscureText:hiddenValue,
                      style: TextStyle(color: Colors.white),

                    ),
                  SizedBox(height: 7.0),
                    TextFormField(
                      decoration: InputDecoration(
                          enabledBorder: const OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.white, width: 0.0),
                          ),
                          border: OutlineInputBorder(),
                          labelText: 'Confirm Password',
                          errorStyle: TextStyle(color: Colors.white),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 5.0),
                          labelStyle: TextStyle(color: Colors.white),
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
                    ),
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
                          value: 'Male',
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
                          value: 'Female',
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
              isValidateRadio1 && gender1 == null ? Text('Please Select your Gender', style: TextStyle(fontSize: 10, color: Colors.white)) : Container(),
                    TextFormField(
                      decoration: InputDecoration(
                        enabledBorder: const OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.white, width: 0.0),
                        ),
                        border: OutlineInputBorder(),
                        labelText: 'Phone Number',
                        errorStyle: TextStyle(color: Colors.white),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 5.0),
                        labelStyle: TextStyle(color: Colors.white),
                        prefixIcon:
                            Icon(Icons.phone_android, color: Colors.white),
                      ),
                      keyboardType: TextInputType.number,
                      controller: phoneNoContr,
                      validator: validatePhone,
                      style: TextStyle(color: Colors.white),
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
                    Container(
                      height: 47.0,
                      width: 293.0,
                      child: RaisedButton(
                        child: Text(
                          "REGISTER",
                          style: TextStyle(fontSize: 20),
                        ),
                        onPressed: () async{
                            isValidateRadio1=true;
                            if(_formKey.currentState.validate()) {
                                if(gender1!=null && checkValue==true){
                                  final String firstName=firstNameContr.text;
                                  final String lastName=lastNameContr.text;
                                  final String email=emailContr.text;
                                  final String password=passwordContr.text;
                                  final String confirmPassword=confirmPasswordContr.text;
                                  final String gender=gender1;
                                  final String phoneNo=phoneNoContr.text;
                                  final UserModel user =await postData(firstName,lastName,email,password,confirmPassword,gender,phoneNo);
                                  setState(() {
                                    _user=user;
                                  });
                                  print(_user.firstName);
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
                    )
                  ],
              ),
            ),
          )
        ),
      ) ,
    );
  }
}
