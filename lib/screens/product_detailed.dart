import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:neostore_app/bloc/buy_now_bloc.dart';
import 'package:neostore_app/bloc/product_detail_bloc.dart';
import 'package:neostore_app/bloc/set_rating_bloc.dart';
import 'package:neostore_app/model_classes/buynowmodel.dart';
import 'package:neostore_app/model_classes/productdetailmodel.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:neostore_app/model_classes/setratingmodel.dart';
import 'package:shared_preferences/shared_preferences.dart';
class ProductDetailed extends StatefulWidget {
  int id,initialRate;
  String productImage,appTitle;
  ProductDetailed({this.id,this.productImage,this.appTitle,this.initialRate});
  @override
  _ProductDetailedState createState() => _ProductDetailedState(this.id,this.productImage,this.appTitle,this.initialRate);
}

class _ProductDetailedState extends State<ProductDetailed> {
  int id,initialRate;
  String productImage,appTitle;
  _ProductDetailedState(this.id,this.productImage,this.appTitle,this.initialRate);
  Color myHexColor1 = Color(0xfffe3f3f);
  Color myHexColor = Color(0xffe91c1a);
  Color shareColor = Color(0xff7f7f7f);
  final detailObj = ProductDetailedBloc();
  final ratingObj =SetRatingBloc();
  final quantityObj=BuyNowBloc();
  String centerImage,barTitle,accessToken;
  var setRating;
  final _formKey = GlobalKey<FormState>();
  TextEditingController quantityContr = TextEditingController();
  @override
  void initState() {
  detailObj.getData(id);
  getAccessToken();
  centerImage=productImage;
  barTitle=appTitle;
  super.initState();
  }
  getAccessToken() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      accessToken=prefs.getString("key7");
    });
  }

  @override
  void dispose() {
  detailObj.dispose();
  quantityObj.dispose();
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar:AppBar(
        title:Text(barTitle),
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
      body: StreamBuilder<ProductDetails>(
        stream:detailObj.detailStream,
        builder: (context, snapshot) {
          if(snapshot.hasData){
            List<ProductImages> proImages=snapshot.data.data.productImages;
            return SingleChildScrollView(
                  child: Container(
                    child: Column(
                      children: [
                        Container(
                          color: Colors.white,
                          child:Padding(
                            padding: const EdgeInsets.fromLTRB(13.0,10.0,13.0,10.0),
                            child: Column(
                              crossAxisAlignment:CrossAxisAlignment.stretch,
                              children: [
                                Text(snapshot.data.data.name,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 19.0),),
                                Text('Category - Tables',style: TextStyle(fontSize: 16.0),),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(snapshot.data.data.producer,style: TextStyle(fontSize: 10.0,color: Colors.grey),),
                                    Container(height:10.0,width:60.0,child:productRating(snapshot.data.data.rating),)
                                  ],
                                ),
                              ],
                            ),
                          ) ,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(13.0,16.0,13.0,16.0),
                          child: Container(
                            decoration:BoxDecoration(
                              borderRadius: BorderRadius.circular(30),

                            ),
                            child:Container(
                              color: Colors.white,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(10.0,0,10.0,0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('Rs.${snapshot.data.data.cost.toString()}',style: TextStyle(color: Colors.red,fontSize: 23.0),),
                                        IconButton(icon:Icon(Icons.share,size: 23.0,color:shareColor,), onPressed:(){})
                                      ],
                                    ),
                                  ),
                                  Container(height:178,width:257,child:Image.network(centerImage!=null?centerImage:'https://cdn.shopify.com/s/files/1/0031/8809/7069/products/1.jpg?v=1568630114'),),
                                  SizedBox(height:6.0),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(10.0,0,10.0,0),
                                    child: Container(
                                      height:80,
                                      child: ListView.builder(itemBuilder:(context,index){
                                        return Row(
                                          children: [
                                            InkWell(onTap:(){
                                              getImage(proImages[index].image);
                                            } ,child: Container(child: Image.network(proImages[index].image)),),//height:78,width:69 not given not looking proper
                                            SizedBox(width:10.0,)
                                          ],
                                        );
                                      },itemCount: proImages.length,scrollDirection: Axis.horizontal,),
                                    ),
                                  ),
                                  SizedBox(height: 25.0),
                                  Divider(height: 3.0,color: Colors.grey,),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Text('DESCRIPTION',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 10.0),),
                                            ],
                                          ),
                                          SizedBox(height:5.0),
                                          Text(snapshot.data.data.description,style: TextStyle(fontSize: 10.0),),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(13.0,8.0,13.0,8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  height:45,
                                  width:150,
                                  child: RaisedButton(
                                    onPressed: () {
                                      buyNow(context);
                                    },
                                    child: Text(
                                      "BUY NOW",
                                      style: TextStyle(
                                          fontSize: 20, fontWeight: FontWeight.bold,color: Colors.white),
                                    ),
                                    color: Colors.red,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(6.0),
                                    ),

                                  ),
                                ),
                                Container(
                                  height:45,
                                  width:150,
                                  child: RaisedButton(
                                    onPressed: () {
                                      rateProduct(context);
                                    },
                                    child: Text(
                                      "RATE",
                                      style: TextStyle(
                                          fontSize: 20, fontWeight: FontWeight.bold,color:Colors.grey[700]),
                                    ),
                                    color: Colors.grey[300],
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(6.0),
                                    ),

                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );

          }
          else{
            return CircularProgressIndicator();
          }
        }
      ),
    );
  }
  Widget productRating(int rating) {
    switch(rating){
      case 1 : {
        return Container(
          width: 60,
          height: 11,
          child: Row(
            children: [
              Icon(Icons.star,color: Colors.amber,size: 12.0,),
              Icon(Icons.star,size: 12.0,color:shareColor,),Icon(Icons.star,size: 12.0,color:shareColor),Icon(Icons.star,size: 12.0,color:shareColor),Icon(Icons.star,size: 12.0,color:shareColor),
            ],
          ),
        );
      } break;
      case 2 : {
        return Container(
          width: 60,
          height: 11,
          child: Row(
            children: [
              Icon(Icons.star,color: Colors.amber,size: 12.0,),
              Icon(Icons.star,color:Colors.amber,size: 12.0,),Icon(Icons.star,size: 12.0,color:shareColor),Icon(Icons.star,size: 12.0,color:shareColor),Icon(Icons.star,size: 12.0,color:shareColor),
            ],
          ),
        );
      }break;
      case 3 : {
        return Container(
          width: 60,
          height: 11,
          child: Row(
            children: [
              Icon(Icons.star,color: Colors.amber,size: 12.0,),
              Icon(Icons.star,color:Colors.amber,size: 12.0,),Icon(Icons.star,color:Colors.amber,size: 12.0,),Icon(Icons.star,size: 12.0,color:shareColor),Icon(Icons.star,size: 12.0,color:shareColor),
            ],
          ),
        );
      }break;
      case 4 : {
        return Container(
          width: 60,
          height: 11,
          child: Row(
            children: [
              Icon(Icons.star,color: Colors.amber,size: 12.0,),
              Icon(Icons.star,color:Colors.amber,size: 12.0,),Icon(Icons.star,color:Colors.amber,size: 12.0,),Icon(Icons.star,color:Colors.amber,size: 12.0,),Icon(Icons.star,size: 12.0,color:shareColor),
            ],
          ),
        );
      }break;
      case 5 : {
        return Container(
          width: 60,
          height: 11,
          child: Row(
            children: [
              Icon(Icons.star,color: Colors.amber,size: 12.0,),
              Icon(Icons.star,color:Colors.amber,size: 12.0,),Icon(Icons.star,color:Colors.amber,size: 12.0,),Icon(Icons.star,color:Colors.amber,size: 12.0,),Icon(Icons.star,color:Colors.amber,size: 12.0,),
            ],
          ),
        );
      }
    }

  }
  getImage(String image){
    setState(() {
      centerImage=image;
    });
  }
  Future<Widget> rateProduct (BuildContext context) async{
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title:Text(barTitle,textAlign: TextAlign.center,),
            content:Container(
              height:317,
              child: Column(
                children: [
                  Image.network(productImage),
              SizedBox(height: 10.0),
              RatingBar.builder(
                initialRating:initialRate.toDouble(),
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemPadding: EdgeInsets.symmetric(horizontal: 3.0),
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {
                    setRating=rating.toString();
                },
              ),
                  SizedBox(height: 10.0),
                  Container(
                    height:55,
                    width:double.infinity,
                    child: RaisedButton(
                      child:Text(
                        "RATE NOW",
                        style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                      ),
                      color: Colors.red,
                      textColor: Colors.white,
                      splashColor: Colors.red,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6.0),
                          side: BorderSide(color: Colors.red)),
                      onPressed: () {
                        ratingObj.postData(setRating,id.toString());
                      },
                    ),
                  ),
                  StreamBuilder<SetRatingModel>(
                      stream: ratingObj.ratingStream,
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
                          if(ratingObj.statusCode==200) {
                            // if(snapshot.data=='New password sent on email')
                            Future.delayed(
                                const Duration(seconds: 1), () {
                              Navigator.pop(context);
                            });
                          }
                        }
                        //WidgetsBinding.instance.addPostFrameCallback((_) =>Scaffold.of(context).showSnackBar(getSnackBar(snapshot.data)) );
                        return Text('');
                      })

                ],
              ),
            ),
          );
        });

  }
  Future<Widget> buyNow (BuildContext context) async{
    return showDialog(
        context: context,
        builder: (context) {
          return SingleChildScrollView(
            child: AlertDialog(
              content:Container(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0,33.0,0,33.0),
                  child: Column(
                    children: [
                      Text(barTitle,textAlign: TextAlign.center,style: TextStyle(fontSize: 25.0),),
                      SizedBox(height: 33.0),
                      Image.network(productImage),
                      SizedBox(height: 33.0),
                      Text('Enter Qty',textAlign: TextAlign.center,style: TextStyle(fontSize: 20.0),),
                      SizedBox(height: 22.0),
                      Form(
                        key:_formKey,
                        child: TextFormField(
                          controller:quantityContr,
                        ),
                      ),
                      SizedBox(height: 22.0),
                      Container(
                        height:47,
                        width:198,
                        child: RaisedButton(
                          child:Text(
                            "SUBMIT",
                            style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                          ),
                          color: Colors.red,
                          textColor: Colors.white,
                          splashColor: Colors.red,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6.0),
                              side: BorderSide(color: Colors.red)),
                          onPressed: () {
                            quantityObj.postData(quantityContr.text,id.toString(),accessToken);
                          },
                        ),
                      ),
                      StreamBuilder<BuyNowModel>(
                          stream: quantityObj.quantityStream,
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
                              if(quantityObj.statusCode==200) {
                                // if(snapshot.data=='New password sent on email')
                                Future.delayed(
                                    const Duration(seconds: 1), () {
                                  Navigator.pop(context);
                                });
                              }
                            }
                            //WidgetsBinding.instance.addPostFrameCallback((_) =>Scaffold.of(context).showSnackBar(getSnackBar(snapshot.data)) );
                            return Text('');
                          })

                    ],
                  ),
                ),
              ),
            ),
          );
        });

  }
}
