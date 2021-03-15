import 'package:flutter/material.dart';
import 'package:neostore_app/bloc/product_detail_bloc.dart';
import 'package:neostore_app/model_classes/productdetailmodel.dart';
class ProductDetailed extends StatefulWidget {
  @override
  _ProductDetailedState createState() => _ProductDetailedState();
}

class _ProductDetailedState extends State<ProductDetailed> {
  Color myHexColor1 = Color(0xfffe3f3f);
  Color myHexColor = Color(0xffe91c1a);
  final detailObj = ProductDetailedBloc();
@override
  void initState() {
  detailObj.getData();
  super.initState();
  }

  @override
  void dispose() {
  detailObj.dispose();
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar:AppBar(
        title: Text('Centre Coffee Table'),
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
            return ListView.builder(
              itemCount:1,
              itemBuilder: (context,index) {
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
                                Text('Category -',style: TextStyle(fontSize: 16.0),),
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
                                        IconButton(icon:Icon(Icons.share,size: 23.0,color: Colors.black,), onPressed:(){})
                                      ],
                                    ),
                                  ),
                                  Container(height:257,width:178,child:Image.network(proImages[0].image)),
                                  SizedBox(height:6.0),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Container(height:78,width:69,child:Image.network('https://www.godrejinterio.com/imagestore/B2C/56101543SD00116/56101543SD00116_01_803x602.png')),
                                      Container(height:78,width:69,child:Image.network(proImages[0].image),),
                                      Container(height:78,width:69,child: Image.network(proImages[1].image)),
                                    ],
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
                                    onPressed: () {},
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
                                    onPressed: () {},
                                    child: Text(
                                      "RATE",
                                      style: TextStyle(
                                          fontSize: 20, fontWeight: FontWeight.bold,color:Colors.grey[350]),
                                    ),
                                    color: Colors.grey,
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
              Icon(Icons.star,size: 12.0,),Icon(Icons.star,size: 12.0,),Icon(Icons.star,size: 12.0,),Icon(Icons.star,size: 12.0,),
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
              Icon(Icons.star,color:Colors.amber,size: 12.0,),Icon(Icons.star,size: 12.0,),Icon(Icons.star,size: 12.0,),Icon(Icons.star,size: 12.0,),
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
              Icon(Icons.star,color:Colors.amber,size: 12.0,),Icon(Icons.star,color:Colors.amber,size: 12.0,),Icon(Icons.star,size: 12.0,),Icon(Icons.star,size: 12.0,),
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
              Icon(Icons.star,color:Colors.amber,size: 12.0,),Icon(Icons.star,color:Colors.amber,size: 12.0,),Icon(Icons.star,color:Colors.amber,size: 12.0,),Icon(Icons.star,size: 12.0,),
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
}
