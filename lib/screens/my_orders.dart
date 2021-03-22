import 'package:flutter/material.dart';
import 'package:neostore_app/bloc/my_order_bloc.dart';
import 'package:neostore_app/model_classes/myordermodel.dart';
import 'package:neostore_app/screens/order_detailed.dart';
import 'package:shared_preferences/shared_preferences.dart';
class MyOrders extends StatefulWidget {
  @override
  _MyOrdersState createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  Color myHexColor1 = Color(0xfffe3f3f);
  Color myHexColor = Color(0xffe91c1a);
  final myOrderObj =MyOrderBloc();
  List<Data> myOrderList =List();
  String accessToken;
  @override
  void initState() {
    getAccessToken();
    // TODO: implement initState
    super.initState();
  }
  getAccessToken() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      accessToken=prefs.getString("key7");
    });
    myOrderObj.getData(accessToken);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: Text('My Orders'),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor:myHexColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_sharp),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon:Icon(Icons.search),
          ),
        ],
      ),
      body:StreamBuilder<MyOrderModel>(
        stream:myOrderObj.myOrderStream,
        builder: (context,snapshot){
          if(snapshot.hasData){
            myOrderList.addAll(snapshot.data.data);
            return ListView.builder(itemCount:myOrderList.length, itemBuilder:(context,index){
              return Column(
                children: [
                  Container(
                    height: 100.0,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0,20,0,20),
                      child: ListTile(
                        onTap: (){
                          Navigator.push(context,MaterialPageRoute(builder:(context) => OrderDetailed(orderId:myOrderList[index].id.toString())));
                        },
                        title:Text('Order Id : ${myOrderList[index].id.toString()}',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16.0),),
                        subtitle:Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0,10.0,90.0,10.0),
                              child: Divider(height: 0.6, thickness:0.66,),
                            ),
                            Text('Ordererd Date : ${myOrderList[index].created}',style: TextStyle(fontSize: 11.0),),
                          ],
                        ),
                        trailing: Text('₹${myOrderList[index].cost.toStringAsFixed(2)}',style: TextStyle(fontSize: 20.0),),
                      ),
                    ),
                  ),
                  Divider(height: 1.0, thickness: 2.0,)
                ],
              );
                });
          }
          else{
            return Center(child: CircularProgressIndicator());
          }
        },
      ) ,
    );
  }
}
