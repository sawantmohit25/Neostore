import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:neostore_app/bloc/add_address_bloc.dart';
import 'package:neostore_app/model_classes/addaddressmodel.dart';
import 'package:neostore_app/screens/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
class AddAddress extends StatefulWidget {
  @override
  _AddAddressState createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddress> {
  Color myHexColor1 = Color(0xfffe3f3f);
  Color myHexColor = Color(0xffe91c1a);
  String accessToken;
  TextEditingController addressController = TextEditingController();
  TextEditingController landmarkController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController zipcodeController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final addAddressObj=AddAddressBloc();
  String validateAddress(val){
    if (val.isEmpty) {
      return 'Required';
    }
    else{
      return null;
    }
  }
  getAccessToken() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      accessToken=prefs.getString("key7");
    });
  }
  @override
  void initState() {
    getAccessToken();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar:AppBar(
        title:Text('ADD ADDRESS'),
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
      body: SingleChildScrollView(
        child: Padding(
          padding:EdgeInsets.fromLTRB(20.0,20.0,20.0,0),
          child: Container(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('ADDRESS',style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold),),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0,10,0,26),
                    child: Container(
                      color: Colors.white,
                      width: double.infinity,
                      height: 100,
                      child:TextFormField(
                        controller:addressController,
                        validator: validateAddress,
                        maxLines: 100,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white, width: 0.0),),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('LANDMARK',style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold),),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0,16,0,16),
                    child: Container(
                      color: Colors.white,
                      width: double.infinity,
                      height: 40,
                      child:TextFormField(
                        controller:landmarkController,
                        maxLines:2,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white, width: 0.0),),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('CITY',style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold),),
                          SizedBox(height: 16.0),
                          Container(
                            color: Colors.white,
                            width:150,
                            height: 40,
                            child: TextFormField(
                              controller: cityController,
                              maxLines: 2,
                              decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.white, width: 0.0),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 16.0),
                          Text('ZIP CODE',style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold),),
                          SizedBox(height: 16.0),
                          Container(
                            color: Colors.white,
                            width:150,
                            height: 40,
                            child: TextFormField(
                              controller: zipcodeController,
                              maxLines: 2,
                              decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                  BorderSide(color: Colors.white, width: 0.0),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('STATE',style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold),),
                          SizedBox(height: 16.0),
                          Container(
                            color: Colors.white,
                            width:150,
                            height: 40,
                            child: TextFormField(
                              controller: stateController,
                              maxLines: 2,
                              decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                  BorderSide(color: Colors.white, width: 0.0),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 16.0),
                          Text('COUNTRY',style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold),),
                          SizedBox(height: 16.0),
                          Container(
                            color: Colors.white,
                            width:150,
                            height: 40,
                            child: TextFormField(
                              controller: countryController,
                              maxLines: 2,
                              decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                  BorderSide(color: Colors.white, width: 0.0),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 26.0),
                  Container(
                    height:47,
                    width:double.infinity,
                    child: RaisedButton(
                      child:Text(
                        "PLACE ORDER",
                        style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),
                      ),
                      color:myHexColor,
                      textColor: Colors.white,
                      splashColor: Colors.red,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6.0),
                          side: BorderSide(color: Colors.red)),
                      onPressed: () {
                        if(_formKey.currentState.validate()){
                          String address=addressController.text;
                          addAddressObj.postData(address, accessToken);
                        }

                      },
                    ),
                  ),
                  StreamBuilder<AddAddressModel>(
                      stream: addAddressObj.addAddressStream,
                      builder: (context, snapshot) {
                        if(snapshot.data!=null)
                        {
                          Fluttertoast.showToast(
                              msg:snapshot.data.userMsg,
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              backgroundColor: Colors.white,
                              textColor: Colors.red
                          );
                        }
                        if(addAddressObj.statusCode==200) {
                          // if(snapshot.data=='Logged In successfully')
                          Future.delayed(
                              const Duration(seconds: 1), () {
                            Navigator.pop(context,true);
                          });
                        }
                        return Text('');
                      }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
