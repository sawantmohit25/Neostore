import 'package:flutter/material.dart';
import 'package:neostore_app/model_classes/productmodel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class TableList extends StatefulWidget {
  @override
  _TableListState createState() => _TableListState();
}

class _TableListState extends State<TableList> {
  Color myHexColor1 = Color(0xfffe3f3f);
  Color myHexColor = Color(0xffe91c1a);
  Future<ProductList> getData() async{
    var res= await http.get('http://staging.php-dev.in:8844/trainingapp/api/products/getList?product_category_id=1&limit=10&page=1');
    var body=json.decode(res.body);
    if(res.statusCode==200){
      ProductList proList=ProductList.fromJson(body);
      return proList;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: Text('Tables'),
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
      body:Container(
        child:FutureBuilder<ProductList>(
          future: getData(),
          builder: (context,snapshot){
            if(snapshot.hasData){
              List<Data> postList=snapshot.data.data;
              return ListView.builder(itemBuilder:(context,index){
                return Column(
                  children: [
                    Container(
                      height: 93.0,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0,13,0,13),
                        child: ListTile(
                          leading:Container(child: Image.network(postList[index].productImages),height:73,width: 66),
                          title: Text(postList[index].name,style: TextStyle(fontSize:15.0)),
                          subtitle:Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(postList[index].producer,style: TextStyle(fontSize:10.0)),
                              SizedBox(height:16.0),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 6.0),
                                child: Text('Rs. ${postList[index].cost.toString()}',style: TextStyle(color: Colors.red,fontSize: 20.0),),
                              ),
                            ],
                          ),
                          trailing: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              productRating(postList[index].rating),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Divider(height: 2.0,thickness: 2.0,)
                  ],
                );
              },
                itemCount:postList.length,);
            }
            else if(snapshot.hasError){
              return Text('${snapshot.error}');
            }
            return CircularProgressIndicator();
          },
        )
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
