import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:salon/view/changepass.dart';
import 'package:salon/view/home.dart';
import 'package:salon/view/myappointment.dart';

import 'package:shared_preferences/shared_preferences.dart';

class Menu extends StatefulWidget {
  final VoidCallback signOut;
  Menu(this.signOut);
  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  signOut() {
    setState(() {
      widget.signOut();
    });
  }

  String name = "", email = "";
  getpref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      name = preferences.getString("name");
      email = preferences.getString("email");
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getpref();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: new AppBar(
          centerTitle: true,
          title: Text(
            "SALON LA RESERVA",
          ),
          backgroundColor: Color(0xff083663),
        ),
        drawer: Drawer(
          child: ListView(
            children: <Widget>[
              UserAccountsDrawerHeader(
                accountName: Text("$name", style: TextStyle(fontSize: 20.0)),
                accountEmail: Text("$email", style: TextStyle(fontSize: 20.0)),
                decoration: BoxDecoration(color: Color(0xff083663)),
              ),
              ListTile(
                title:
                    Text('Change Password', style: TextStyle(fontSize: 20.0)),
                trailing: Icon(Icons.vpn_key),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ChangePassword()));
                },
              ),
              Divider(),
              // ListTile(
              //   title:
              //       Text('My Appointments', style: TextStyle(fontSize: 20.0)),
              //   trailing: Icon(Icons.local_library),
              //   onTap: () {
              //     Navigator.of(context).pop();
              //     Navigator.of(context).push(
              //         MaterialPageRoute(builder: (context) => Myappoint()));
              //   },
              // ),

              ListTile(
                title: Text('Sign out', style: TextStyle(fontSize: 20.0)),
                trailing: Icon(Icons.exit_to_app),
                onTap: () {
                  signOut();
                  Fluttertoast.showToast(
                      msg: 'You Have Sucessfully Logout',
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 5,
                      backgroundColor: Colors.green,
                      textColor: Colors.white);
                },
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            Home(),
            Myappoint(),
          ],
        ),
        bottomNavigationBar: TabBar(
          labelColor: Colors.blue,
          unselectedLabelColor: Colors.black,
          indicator: UnderlineTabIndicator(
              borderSide: BorderSide(style: BorderStyle.none)),
          tabs: <Widget>[
            Tab(
              icon: Icon(Icons.home),
              text: 'Home',
            ),
            Tab(
              icon: Icon(Icons.list_rounded),
              text: 'Booked',
            ),
          ],
        ),
      ),
    );
  }
}
