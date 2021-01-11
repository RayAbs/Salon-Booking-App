import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ChangePassword extends StatefulWidget {
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  String c1, password, c3;
  final _key = new GlobalKey<FormState>();
  bool _secureText1 = true;
  bool _secureText2 = true;
  bool _secureText3 = true;
  bool isEnabled = false;
  showHide() {
    setState(() {
      _secureText1 = !_secureText1;
    });
  }

  showHide2() {
    setState(() {
      _secureText2 = !_secureText2;
    });
  }

  showHide3() {
    setState(() {
      _secureText3 = !_secureText3;
    });
  }

  check() {
    final form = _key.currentState;
    if (form.validate()) {
      form.save();
      save();
    }
  }

  save() async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    SharedPreferences preferences = await _prefs;
    String id = preferences.getString("id");

    debugPrint(id);
    final response =
        await http.post('http://192.168.1.10/salon/changepassword.php',
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(<String, dynamic>{
              'userid': int.parse(id),
              'password': password,
            }));
    debugPrint(response.body);
    final data = jsonDecode(response.body);
    int value = data['value'];
    if (value == 1) {
      setState(() {
        Navigator.pop(context);
      });
      Fluttertoast.showToast(
          msg: 'Password Sucessfully Updated',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 6,
          backgroundColor: Colors.green,
          textColor: Colors.white);
    } else {
      setState(() {
        Navigator.pop(context);
      });
      Fluttertoast.showToast(
          msg: 'Failed to Update',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 6,
          backgroundColor: Color(0xffb5171d),
          textColor: Colors.white);
      String message = data['message'];
      print(message);
    }
  }

  String id = "";
  getpref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      id = preferences.getString('id');

      debugPrint(id);
    });
  }

  @override
  void initState() {
    super.initState();
    getpref();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Change Password'),
        backgroundColor: Color(0xff083663),
      ),
      body: Form(
        key: _key,
        child: Center(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 30.0,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Change Password',
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.w900),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                child: TextFormField(
                  validator: (e) {
                    if (e.isEmpty) {
                      return "Please Enter Current Password";
                    }
                    return null;
                  },
                  obscureText: _secureText1,
                  onSaved: (e) => c1 = e,
                  decoration: InputDecoration(
                      labelText: 'Current Password',
                      suffixIcon: IconButton(
                        onPressed: showHide,
                        icon: Icon(_secureText1
                            ? Icons.visibility_off
                            : Icons.visibility),
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                        color: Color(0xff083663),
                      )),
                      border: OutlineInputBorder()),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                child: TextFormField(
                  validator: (e) {
                    if (e.isEmpty) {
                      return "Please Enter New Password";
                    }
                    return null;
                  },
                  obscureText: _secureText2,
                  onSaved: (e) => password = e,
                  decoration: InputDecoration(
                      labelText: 'New Password',
                      suffixIcon: IconButton(
                        onPressed: showHide2,
                        icon: Icon(_secureText2
                            ? Icons.visibility_off
                            : Icons.visibility),
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                        color: Color(0xff083663),
                      )),
                      border: OutlineInputBorder()),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                child: TextFormField(
                  validator: (e) {
                    if (e.isEmpty) {
                      return "Verify Password";
                    }
                    return null;
                  },
                  onSaved: (e) => c3 = e,
                  decoration: InputDecoration(
                      labelText: 'Verify Password',
                      suffixIcon: IconButton(
                        onPressed: showHide3,
                        icon: Icon(_secureText3
                            ? Icons.visibility_off
                            : Icons.visibility),
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                        color: Color(0xff083663),
                      )),
                      border: OutlineInputBorder()),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                child: Divider(),
              ),
              SizedBox(
                height: 20.0,
              ),
              Container(
                height: 50,
                width: 250,
                child: RaisedButton(
                  onPressed: () {
                    check();
                  },
                  color: Color(0xffb5171d),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30.0))),
                  textColor: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.vpn_key,
                        color: Colors.white,
                      ),
                      Text(
                        'Save Changes',
                        style: TextStyle(fontSize: 15),
                      ),
                      SizedBox(
                        height: 20,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
