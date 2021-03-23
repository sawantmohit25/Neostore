import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/material.dart';
class StoreLocator extends StatefulWidget {
  @override
  _StoreLocatorState createState() => _StoreLocatorState();
}

class _StoreLocatorState extends State<StoreLocator> {
  Color myHexColor1 = Color(0xfffe3f3f);
  Color myHexColor = Color(0xffe91c1a);
  List data;
  Future<String> loadJsonData() async {
    var jsonText = await rootBundle.loadString('assets/storeLocator.json');
    setState(() {
      data = json.decode(jsonText);
    });
    print("Store $data");
    return "Success";
  }
  @override
  void initState() {
      this.loadJsonData();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: Text('Store Locator'),
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
        child: Column(
          children: [
            Container(
              height: 166.0,
              width: double.infinity,
              child: Text(''),
              color: Colors.green,
            ),
            Divider(height: 2.0, thickness: 2.0,),
            ListView.builder(physics: BouncingScrollPhysics(),shrinkWrap: true,itemCount:data!=null?data.length:0,itemBuilder:(context,index){
              print(data[index]['store_name']);
              return Column(
                children: [
                  Container(
                    // height: 69.0,
                    // width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0,20.0,0,20.0),
                      child: ListTile(
                        leading: Icon(Icons.location_pin),
                        title: Text(data[index]['store_name']!=null?data[index]['store_name']:'',style: TextStyle(fontWeight: FontWeight.bold,fontSize:15.0),),
                        subtitle:Text(data[index]['store_address']!=null?data[index]['store_address']:'',style: TextStyle(fontSize:13.0),),
                      ),
                    ),
                  ),
                  Divider(height: 2.0, thickness: 2.0,),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }
}
