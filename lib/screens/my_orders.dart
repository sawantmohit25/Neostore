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
  List<Data> ordersForDisplay =List();
  String accessToken;
  bool isSearching=false;

  @override
  void initState() {
    getAccessToken();
    myOrderObj.myOrderStream.listen((event) {
      if(event.data.isNotEmpty){
       setState(() {
         myOrderList.addAll(event.data);
         ordersForDisplay=myOrderList;
       });
      }
      else{
        return CircularProgressIndicator();
      }
    });
    super.initState();
  }

  getAccessToken() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      accessToken=prefs.getString("accessToken");
    });
    myOrderObj.getData(accessToken);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: isSearching==false?Text('My Orders'):Theme(data: ThemeData(primaryColor: Colors.white),
          child: TextField(cursorColor: Colors.white,keyboardType:TextInputType.number,style: TextStyle(color: Colors.white),decoration: InputDecoration(icon: Icon(Icons.search,color: Colors.white,),hintText:'Search Orders Here',hintStyle:TextStyle(color: Colors.white)),
            onChanged:(text){
            setState(() {
              ordersForDisplay=myOrderList.where((element){
                var orders=element.id.toString();
                return orders.contains(text);
              }).toList();
            });
            } ,),
        ),
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
          isSearching==false?IconButton(
            onPressed: () {
              setState(() {
                isSearching=true;
              });
            },
            icon:Icon(Icons.search),
          ):IconButton(
            onPressed: () {
              setState(() {
                isSearching=false;
                ordersForDisplay=myOrderList;
              });
            },
            icon:Icon(Icons.cancel),
          )
        ],
      ),
      body:ordersForDisplay.isNotEmpty?ListView.builder(itemCount:ordersForDisplay.length, itemBuilder:(context,index){
              return Column(
                children: [
                  Container(
                    height: 100.0,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0,20,0,20),
                      child: ListTile(
                        onTap: (){
                          Navigator.push(context,MaterialPageRoute(builder:(context) => OrderDetailed(orderId:ordersForDisplay[index].id.toString())));
                        },
                        title:Text('Order Id : ${ordersForDisplay[index].id.toString()}',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16.0),),
                        subtitle:Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0,10.0,90.0,10.0),
                              child: Divider(height: 0.6, thickness:0.66,),
                            ),
                            Text('Ordererd Date : ${ordersForDisplay[index].created}',style: TextStyle(fontSize: 11.0),),
                          ],
                        ),
                        trailing: Text('₹${ordersForDisplay[index].cost.toStringAsFixed(2)}',style: TextStyle(fontSize: 20.0),),
                      ),
                    ),
                  ),
                  Divider(height: 1.0, thickness: 2.0,)
                ],
              );
      }):Center(child: Text('No Orders',style: TextStyle(fontSize: 40.0,fontWeight: FontWeight.bold),),)
    );
  }
}
