import 'package:flutter/material.dart';
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Color myHexColor1 = Color(0xfffe3f3f);
  Color myHexColor = Color(0xffe91c1a);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('NeoSTORE'),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor:myHexColor,
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon:Icon(Icons.search),
          ),
        ],
      ),
      drawer: Drawer(
        child: Container(
          color: Colors.grey[850],
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: <Widget>[
              SizedBox(height:35.0),
              Theme(
                  data:ThemeData.light().copyWith(
                      primaryColor: Colors.grey[850],
                  ),
                    child: UserAccountsDrawerHeader(
                  accountName: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Kinjal Jain",style: TextStyle(fontSize: 23.0),),
                    ],
                  ),
                  accountEmail: Row(mainAxisAlignment:MainAxisAlignment.center,children:[Text("kinjal.jain@wwindia.com",style: TextStyle(fontSize: 13.0),)] ),
                  currentAccountPicture: CircleAvatar(
                    backgroundColor: Colors.orange,
                    child: Text(
                      "K",
                      style: TextStyle(fontSize: 40.0),
                    ),
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.shopping_cart,color: Colors.white,), title: Text("My Cart",style: TextStyle(color: Colors.white),),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              Divider(color: Colors.black,height: 2.0,),
              ListTile(
                leading: Icon(Icons.deck,color: Colors.white,), title: Text("Tables",style: TextStyle(color: Colors.white),),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              Divider(color: Colors.black,height: 2.0,),
              ListTile(
                leading: Icon(Icons.weekend,color: Colors.white,), title: Text("Sofas",style: TextStyle(color: Colors.white),),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              Divider(color: Colors.black,height: 2.0,),
              ListTile(
                leading: Icon(Icons.event_seat,color: Colors.white,), title: Text("Chairs",style: TextStyle(color: Colors.white),),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              Divider(color: Colors.black,height: 2.0,),
              ListTile(
                leading: Icon(Icons.weekend,color: Colors.white,), title: Text("Cupboards",style: TextStyle(color: Colors.white),),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              Divider(color: Colors.black,height: 2.0,),
              ListTile(
                leading: Icon(Icons.person,color: Colors.white,), title: Text("My Account",style: TextStyle(color: Colors.white),),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              Divider(color: Colors.black,height: 2.0,),
              ListTile(
                leading: Icon(Icons.location_on_outlined,color: Colors.white,), title: Text("Store Locator",style: TextStyle(color: Colors.white),),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              Divider(color: Colors.black,height: 2.0,),
              ListTile(
                leading: Icon(Icons.fact_check,color: Colors.white,), title: Text("My Orders",style: TextStyle(color: Colors.white),),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              Divider(color: Colors.black,height: 2.0,),
              ListTile(
                leading: Icon(Icons.logout,color: Colors.white,), title: Text("Logout",style: TextStyle(color: Colors.white),),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    ) ;
  }
}
