import 'package:flutter/material.dart';
import 'package:neostore_app/Screens/login.dart';
import 'package:neostore_app/bloc/login_bloc.dart';
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Color myHexColor1 = Color(0xfffe3f3f);
  Color myHexColor = Color(0xffe91c1a);
  LoginBloc drawObj=LoginBloc();
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
                    child:StreamBuilder<String>(
                      stream:drawObj.drawStream,
                      builder: (context, snapshot) {
                        if(snapshot.data!=null) {
                          print('bolte ${snapshot.data}');
                          return Column(
                            children: [
                              SizedBox(height: 37.0),
                              Container(
                                width: 83,
                                height: 83,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.white),
                                  shape: BoxShape.circle,
                                  image: DecorationImage(image: NetworkImage(
                                      'https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?ixid=MXwxMjA3fDB8MHxzZWFyY2h8M3x8YnVzaW5lc3MlMjB3b21hbnxlbnwwfHwwfA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=400&q=60'),
                                      fit: BoxFit.fill),),
                              ),
                              SizedBox(height: 18.0),
                              Text("Kinjal Jain", style: TextStyle(
                                  fontSize: 23.0, color: Colors.white),),
                              SizedBox(height: 13.0),
                              Text("kinjal.jain@wwindia.com", style: TextStyle(
                                  fontSize: 13.0, color: Colors.white),)
                            ],
                          );
                        }
                        return Text('');
                      }
                    )
              ),
              SizedBox(height:13.0),
              Divider(color: Colors.black,height: 2.0,),
              ListTile(
                leading: Icon(Icons.shopping_cart,color: Colors.white,size: 28.0), title: Text("My Cart",style: TextStyle(color: Colors.white,fontSize:16.0),),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              Divider(color: Colors.black,height: 2.0,),
              ListTile(
                leading: Icon(Icons.deck,color: Colors.white,size: 28.0), title: Text("Tables",style: TextStyle(color: Colors.white,fontSize:16.0),),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              Divider(color: Colors.black,height: 2.0,),
              ListTile(
                leading: Icon(Icons.weekend,color: Colors.white,size: 28.0), title: Text("Sofas",style: TextStyle(color: Colors.white,fontSize:16.0),),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              Divider(color: Colors.black,height: 2.0,),
              ListTile(
                leading: Icon(Icons.event_seat,color: Colors.white,size: 28.0), title: Text("Chairs",style: TextStyle(color: Colors.white,fontSize:16.0),),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              Divider(color: Colors.black,height: 2.0,),
              ListTile(
                leading: Icon(Icons.table_chart_sharp,color: Colors.white,size: 28.0), title: Text("Cupboards",style: TextStyle(color: Colors.white,fontSize:16.0),),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              Divider(color: Colors.black,height: 2.0,),
              ListTile(
                leading: Icon(Icons.person,color: Colors.white,size: 28.0), title: Text("My Account",style: TextStyle(color: Colors.white,fontSize:16.0),),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              Divider(color: Colors.black,height: 2.0,),
              ListTile(
                leading: Icon(Icons.location_on_outlined,color: Colors.white,size: 28.0), title: Text("Store Locator",style: TextStyle(color: Colors.white,fontSize:16.0),),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              Divider(color: Colors.black,height: 2.0,),
              ListTile(
                leading: Icon(Icons.fact_check,color: Colors.white,size: 28.0), title: Text("My Orders",style: TextStyle(color: Colors.white,fontSize:16.0),),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              Divider(color: Colors.black,height: 2.0,),
              ListTile(
                leading: Icon(Icons.logout,color: Colors.white,size: 28.0), title: Text("Logout",style: TextStyle(color: Colors.white,fontSize:16.0),),
                onTap: () {
                  Navigator.pop(context);
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
