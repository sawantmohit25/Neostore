import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:neostore_app/bloc/tablelist_bloc.dart';
import 'package:neostore_app/model_classes/productmodel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:neostore_app/screens/product_detailed.dart';
class TableList extends StatefulWidget {
  @override
  _TableListState createState() => _TableListState();
}

class _TableListState extends State<TableList> {
  ScrollController _scrollController =ScrollController();
  int pageNumber=1;
  Color myHexColor1 = Color(0xfffe3f3f);
  Color myHexColor = Color(0xffe91c1a);
  final tableObj = TableListBloc();
  bool isSearching=false;
  TextEditingController searchController=TextEditingController();
  List<Data> postList=List();
  List<Data> tablesForDisplay=List();

  Future<bool> onBackPressed() async{
    Navigator.pop(context,true);
    return true;
  }

  @override
  void initState() {
    tableObj.getData(pageNumber);
    _scrollController.addListener(() {
      if(_scrollController.position.pixels==_scrollController.position.maxScrollExtent) {
        if(tableObj.responseStatus==200){
          print(tableObj.responseStatus);
          tableObj.getData(++pageNumber);
        }
        else{
          Fluttertoast.showToast(
              msg:'No More Items Further',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.red,
              textColor: Colors.white
          );
        }
      }
      });
    tableObj.tableStream.listen((event) {
      if(event.data!=null){
        setState(() {
          postList.addAll(event.data);
          tablesForDisplay=postList;
        });

      }
      else{
        return CircularProgressIndicator();
      }

    });
    // TODO: implement initState
    super.initState();
  }
  // Future<ProductList> getData() async{
  //   var endpointUrl = 'http://staging.php-dev.in:8844/trainingapp/api/products/getList';
  //   Map<String,String> queryParams = {
  //     'product_category_id':'1',
  //     'limit': '10',
  //     'page' :'1'
  //   };
  //   String queryString = Uri(queryParameters: queryParams).query;
  //   var requestUrl = endpointUrl + '?' + queryString;
  //   var res= await http.get(requestUrl);//?product_category_id=1&limit=10&page=1
  //   var body=json.decode(res.body);
  //   if(res.statusCode==200){
  //     ProductList proList=ProductList.fromJson(body);
  //     return proList;
  //   }
  // }
  @override
  void dispose() {
    // TODO: implement dispose
    _scrollController.dispose();
    tableObj.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop:onBackPressed,
      child: Scaffold(
        appBar:AppBar(
          title:isSearching==false?Text('Tables'):Theme(data: ThemeData(primaryColor: Colors.white,),
            child: TextField(cursorColor:Colors.white,style:TextStyle(color: Colors.white),decoration: InputDecoration(icon:Icon(Icons.search,color: Colors.white,),hintText: 'Search Tables Here',hintStyle: TextStyle(color:Colors.white)),
                onChanged:(text){
              text=text.toLowerCase();
              setState(() {
                tablesForDisplay=postList.where((element){
                  var tables=element.name.toLowerCase();
                  return tables.contains(text);
                }).toList();
              });
                }),
          ),
          centerTitle: true,
          elevation: 0.0,
          backgroundColor: myHexColor,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_sharp),
            onPressed: () {
              Navigator.pop(context,true);
            },
          ),
          actions: <Widget>[
            isSearching==false?IconButton(
              onPressed: () {
                setState(() {
                  isSearching=true;
                });
              },
              icon: Icon(Icons.search),
            ):IconButton(
              onPressed: () {
                setState(() {
                  isSearching=false;
                  tablesForDisplay=postList;
                });
              },
              icon: Icon(Icons.cancel),
            )
          ],
        ),
        body:Container(
          child:ListView.builder(controller:_scrollController,physics:BouncingScrollPhysics(),itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Container(
                        height: 93.0,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 13, 0, 13),
                          child: ListTile(
                            onTap: (){
                              Navigator.push(context,MaterialPageRoute(builder:(context) =>ProductDetailed(id: tablesForDisplay[index].id,productImage:tablesForDisplay[index].productImages,appTitle:tablesForDisplay[index].name,initialRate: tablesForDisplay[index].rating,)));
                            },
                            leading: Container(child: Image.network(
                                tablesForDisplay[index].productImages),
                                height: 73,
                                width: 66),
                            title: Text(tablesForDisplay[index].name,
                                style: TextStyle(fontSize: 15.0)),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(tablesForDisplay[index].producer,
                                    style: TextStyle(fontSize: 10.0)),
                                SizedBox(height: 16.0),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 6.0),
                                  child: Text(
                                    'Rs. ${tablesForDisplay[index].cost.toString()}',
                                    style: TextStyle(
                                        color: Colors.red, fontSize: 20.0),),
                                ),
                              ],
                            ),
                            trailing: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                productRating(tablesForDisplay[index].rating),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Divider(height: 2.0, thickness: 2.0,)
                    ],
                  );
                },
                  itemCount: tablesForDisplay.length,),
        ),
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
