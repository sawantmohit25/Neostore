import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
class StoreLocator extends StatefulWidget {
  @override
  _StoreLocatorState createState() => _StoreLocatorState();
}

class _StoreLocatorState extends State<StoreLocator> {
  Color myHexColor1 = Color(0xfffe3f3f);
  Color myHexColor = Color(0xffe91c1a);
  Set<Marker> _markers ={};
  List data;
  Future<String> loadJsonData() async {
    var jsonText = await rootBundle.loadString('assets/store_locator.json');
    setState(() {
      data = json.decode(jsonText);
    });
    print("Store $data");
    return "Success";
  }
//   void onMapCreated(GoogleMapController controller){
// setState(() {
//   _markers.add(Marker(markerId:MarkerId('id-1'),position: LatLng(18.999126,72.820426),infoWindow: ));
// });
//   }
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
      body:Column(
        children: [
          Container(
            height: 166.0,
            width: double.infinity,
            child:GoogleMap(
              initialCameraPosition:CameraPosition(target:LatLng(18.999126,72.820426),zoom:4),
              onMapCreated:(controller){
                setState(() {
                  _markers.add(Marker(markerId:MarkerId('id-1'),position: LatLng(18.999126,72.820426),infoWindow:InfoWindow(title:'Royal Touche',snippet: 'Wood and laminate flooring supplier')));
                  _markers.add(Marker(markerId: MarkerId('id-2'), position: LatLng(19.2337028,72.8621114), infoWindow: InfoWindow(title: 'A to Z Furnishing', snippet: 'Strong Cupboard supplier',),),);
                  _markers.add(Marker(markerId:MarkerId('id-3'),position: LatLng(28.568736,77.183983),infoWindow:InfoWindow(title:'Godrej Interio-Furniture Store',snippet: 'Modular Kitchen Gallery in Ram Krishna Puram,Delhi')));
                  _markers.add(Marker(markerId:MarkerId('id-4'),position: LatLng(19.232180,72.869150),infoWindow:InfoWindow(title:'Shree Mahalaxmi Furniture',snippet: 'Modular Kitchen Gallery in Borivali East, Mumbai')));
                  _markers.add(Marker(markerId: MarkerId('id-5'), position:  LatLng(19.229500,72.860320), infoWindow: InfoWindow(title: "Radha Krushna Furniture", snippet: "Modular furniture Gallery in Borivali",),),);
                });
              },
              mapType: MapType.normal,
              markers:_markers,
            ),
          ),
          Divider(height: 2.0, thickness: 2.0,),
          Expanded(
            child: ListView.builder(physics:AlwaysScrollableScrollPhysics(),shrinkWrap: true,itemCount:data!=null?data.length:0,itemBuilder:(context,index){
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
          ),
        ],
      ),
    );
  }
}
