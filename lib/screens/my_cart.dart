import 'package:flutter/material.dart';
import 'package:neostore_app/bloc/my_cart_bloc.dart';
import 'package:neostore_app/model_classes/mycartmodel.dart';
import 'package:shared_preferences/shared_preferences.dart';
class MyCart extends StatefulWidget {
  @override
  _MyCartState createState() => _MyCartState();
}

class _MyCartState extends State<MyCart> {
  Color myHexColor1 = Color(0xfffe3f3f);
  Color myHexColor = Color(0xffe91c1a);
  final myCartObj=MyCartBloc();
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
      body:StreamBuilder<MyCartModel>(
        stream:myCartObj.myCartStream,
        builder: (context,snapshot){
          if(snapshot.hasData){
            postList.addAll(snapshot.data.data);
            total=snapshot.data.total.toStringAsFixed(2);
            return Column(
              children: [
                ListView.builder(shrinkWrap:true,itemBuilder:(context,index){
                  return Column(
                    children: [
                      Container(
                        height: 90.0,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                          child:ListTile(
                            leading: Container(child: Image.network(
                                postList[index].product.productImages),
                                height: 73,
                                width: 66),
                            title:Text(postList[index].product.name, style: TextStyle(fontSize: 15.0,fontWeight: FontWeight.bold)),
                            subtitle:Text('(${postList[index].product.productCategory})', style: TextStyle(fontSize: 15.0)),
                            trailing:Text('₹ ${postList[index].product.subTotal.toStringAsFixed(2)}',
                                style: TextStyle(fontSize: 15.0)),
                          ),),
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
                      onPressed: () {},
                    ),
                  ),
                ),
              ],
            );
          }
          else{
            return CircularProgressIndicator();
          }
        },
      ) ,
    );
  }
}
