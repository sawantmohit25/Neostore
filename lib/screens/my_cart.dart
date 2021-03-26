import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:neostore_app/bloc/delete_cart_bloc.dart';
import 'package:neostore_app/bloc/edit_cart_bloc.dart';
import 'package:neostore_app/bloc/my_cart_bloc.dart';
import 'package:neostore_app/model_classes/deletecartmodel.dart';
import 'package:neostore_app/model_classes/mycartmodel.dart';
import 'package:neostore_app/model_classes/editcartmodel.dart';
import 'package:neostore_app/screens/add_address.dart';
import 'package:neostore_app/screens/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
class MyCart extends StatefulWidget {
  @override
  _MyCartState createState() => _MyCartState();
}

class _MyCartState extends State<MyCart> {
  ScrollController _scrollController =ScrollController();
  Color myHexColor1 = Color(0xfffe3f3f);
  Color myHexColor = Color(0xffe91c1a);
  Color dropColor=Color(0xffededed);
  final myCartObj=MyCartBloc();
  final editCartObj=EditCartBloc();
  final deleteCartObj=DeleteCartBloc();
  List<Data> postList =List();
  String accessToken,dropValue,total;
  @override
  void initState() {
    getAccessToken();
    print('pat tap ${accessToken}');
    // TODO: implement initState
    super.initState();
  }
  getAccessToken() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      accessToken=prefs.getString("key7");
    });
     myCartObj.getData(accessToken);
  }
  getRequest() async{
    getAccessToken();
  }
  @override
  void dispose() {
    myCartObj.dispose();
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Cart'),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: myHexColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_sharp),
          onPressed: () {
            Navigator.pop(context,true);
            // Navigator.pushReplacement(context,MaterialPageRoute(builder:(context) =>HomeScreen() ));
          },
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search),
          ),
        ],
      ),
      body:StreamBuilder<MyCartModel>(
        stream:myCartObj.myCartStream,
        builder: (context,snapshot){
          if(snapshot.hasData){
            if(snapshot.data.data!=null){
              postList.addAll(snapshot.data.data);
              total=snapshot.data.total.toStringAsFixed(2);
              return SingleChildScrollView(
                child: Column(
                  children: [
                    ListView.builder(physics: BouncingScrollPhysics(),shrinkWrap:true,itemBuilder:(context,index){
                      return Column(
                        children: [
                          Slidable(
                            actionPane: SlidableDrawerActionPane(),
                            secondaryActions: [
                              Container(height:45,width:45,decoration:BoxDecoration(color: Colors.red,shape: BoxShape.circle, border: Border.all(width: 2, color: Colors.red)),
                                  child: IconButton(icon:Icon(Icons.delete,color: Colors.white,),
                                    onPressed: (){
                                deleteCartObj.postData(postList[index].productId.toString(),accessToken);
                                postList.clear();
                                Future.delayed(Duration(seconds:1),(){
                                  myCartObj.getData(accessToken);
                                });
                              },)),
                            ],child: Container(
                            height: 90.0,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                              child:ListTile(
                                leading: Container(child: Image.network(
                                    postList[index].product.productImages),
                                    height: 73,
                                    width: 66),
                                title:Text(postList[index].product.name, style: TextStyle(fontSize: 15.0,fontWeight: FontWeight.bold)),
                                subtitle:Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 3.0,),
                                    Text('(${postList[index].product.productCategory})', style: TextStyle(fontSize: 12.0)),
                                    SizedBox(height: 3.0,),
                                    Container(
                                      height: 18.0,
                                      width: 35.0,
                                      color:dropColor ,
                                      child: DropdownButton<String>(
                                        underline:SizedBox(),
                                        icon:Icon(Icons.keyboard_arrow_down),
                                        iconEnabledColor: Colors.black,
                                        isExpanded: true,
                                        value:postList[index].quantity.toString(),
                                        // validator: (val) {
                                        //   if (val == null) {
                                        //     return 'Required';
                                        //   }
                                        // },
                                        items: [DropdownMenuItem<String>(
                                          value:'1',
                                          child: Text('1'),
                                        ),
                                          DropdownMenuItem<String>(
                                            value: '2',
                                            child: Text('2'),
                                          ),
                                          DropdownMenuItem<String>(
                                            value: '3',
                                            child: Text('3'),
                                          ),
                                          DropdownMenuItem<String>(
                                            value: '4',
                                            child: Text('4'),
                                          ),
                                          DropdownMenuItem<String>(
                                            value: '5',
                                            child: Text('5'),
                                          ),
                                          DropdownMenuItem<String>(
                                            value: '6',
                                            child: Text('6'),
                                          ),
                                          DropdownMenuItem<String>(
                                            value: '7',
                                            child: Text('7'),
                                          ),
                                          DropdownMenuItem<String>(
                                            value: '8',
                                            child: Text('8'),
                                          )

                                        ],
                                        onChanged: (val) {
                                          editCartObj.postData(val,postList[index].productId.toString(),accessToken);
                                          postList.clear();
                                          Future.delayed(Duration(seconds:1),(){
                                            myCartObj.getData(accessToken);
                                          });
                                        },
                                        hint: Text(postList[index].quantity.toString()),
                                      ),
                                    ),
                                    StreamBuilder<EditCartModel>(
                                        stream: editCartObj.editCartStream,
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
                                          return Text('');
                                        }),
                                    StreamBuilder<DeleteCartModel>(
                                        stream: deleteCartObj.deleteCartStream,
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
                                          //WidgetsBinding.instance.addPostFrameCallback((_) =>Scaffold.of(context).showSnackBar(getSnackBar(snapshot.data)) );
                                          return Text('');
                                        })

                                  ],
                                ),
                                trailing:Text('₹ ${postList[index].product.subTotal.toStringAsFixed(2)}',
                                    style: TextStyle(fontSize: 15.0)),
                              ),),
                          ),
                          ),
                          Divider(height: 2.0, thickness: 2.0,)
                        ],
                      );
                    },itemCount:postList.length,),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15.0,0,15.0,0),
                      child: Container(
                        height: 66.0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('TOTAL',
                                style: TextStyle(fontSize: 15.0,fontWeight: FontWeight.bold)),
                            Text('₹ ${total}',
                                style: TextStyle(fontSize: 15.0,fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                    ),
                    Divider(height: 2.0, thickness: 2.0,),
                    SizedBox(height: 20.0),
                    Padding(
                      padding:const EdgeInsets.fromLTRB(15.0,0,15.0,0),
                      child: Container(
                        height:47,
                        width:double.infinity,
                        child: RaisedButton(
                          child:Text(
                            "ORDER NOW",
                            style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),
                          ),
                          color:myHexColor,
                          textColor: Colors.white,
                          splashColor: Colors.red,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6.0),
                              side: BorderSide(color: Colors.red)),
                          onPressed: () {
                            Navigator.push(context,MaterialPageRoute(builder:(context) => AddAddress() )).then((value) =>value?getRequest():null);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
            else{
              return Center(
                child:Image.network('https://professionalscareer.com/assets/images/emptycart.png'),
              );
            }
          }
          else{
            return Center(child: CircularProgressIndicator());
          }
        },
      ) ,
    );
  }
}
