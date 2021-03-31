import 'package:flutter/material.dart';
import 'package:neostore_app/bloc/order_detailed_bloc.dart';
import 'package:neostore_app/model_classes/orderdetailmodel.dart';
import 'package:shared_preferences/shared_preferences.dart';
class OrderDetailed extends StatefulWidget {
  String orderId;
  OrderDetailed({this.orderId});
  @override
  _OrderDetailedState createState() => _OrderDetailedState(this.orderId);
}

class _OrderDetailedState extends State<OrderDetailed> {
  String orderId;
  _OrderDetailedState(this.orderId);
  Color myHexColor1 = Color(0xfffe3f3f);
  Color myHexColor = Color(0xffe91c1a);
  final orderDetailedObj=OrderDetailBloc();
  List<OrderDetails> orderDetailList =List();
  String accessToken,total;
  @override
  void initState() {
    getAccessToken();
    // TODO: implement initState
    super.initState();
  }
  getAccessToken() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      accessToken=prefs.getString("accessToken");
    });
    orderDetailedObj.getData(orderId,accessToken);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: Text('Order ID : ${orderId}'),
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
      body:SingleChildScrollView(
        child: StreamBuilder<OrderDetailModel>(
          stream:orderDetailedObj.orderDetailStream,
          builder: (context,snapshot){
            if(snapshot.hasData){
              orderDetailList.addAll(snapshot.data.data.orderDetails);
              return Column(
                children: [
                  ListView.builder(shrinkWrap: true,itemCount:orderDetailList.length,itemBuilder:(context,index){
                    return Column(
                      children: [
                        Container(
                          height: 100,
                          child:Padding(
                            padding: const EdgeInsets.fromLTRB(0,16.0,0,16.0),
                            child: ListTile(
                              leading:Container(child: Image.network(orderDetailList[index].prodImage), height: 73, width: 66),
                              title:Text(orderDetailList[index].prodName,style: TextStyle(fontSize: 20.0),),
                              subtitle:Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('(${orderDetailList[index].prodCatName})',style: TextStyle(fontSize: 15.0),),
                                  SizedBox(height: 13.0),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('QTY : ${orderDetailList[index].quantity}',style: TextStyle(fontSize: 13.0,color: Colors.black),),
                                      Text('₹${orderDetailList[index].total.toStringAsFixed(2)}',style: TextStyle(fontSize: 13.0,color: Colors.black),),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Divider(height: 1.0, thickness: 2.0,),
                      ],
                    );
                  }),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15.0,0,15.0,0),
                    child: Container(
                      height: 66.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('TOTAL',
                              style: TextStyle(fontSize: 15.0,fontWeight: FontWeight.bold)),
                          Text('₹ ${snapshot.data.data.cost}',
                              style: TextStyle(fontSize: 15.0,fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ),
                  Divider(height: 2.0, thickness: 2.0,),
                ],
              );
            }
            else{
              return CircularProgressIndicator();
            }
          },
        ),
      )
    );
  }
}
