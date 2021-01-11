import 'package:flutter/material.dart';
import 'package:salon/view/forget.dart';
import 'view/menu.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

enum LoginStatus { notSignIn, signIn }

class _MyHomePageState extends State<MyHomePage> {
  LoginStatus _loginStatus = LoginStatus.notSignIn;

  String username, password;
  final _key = new GlobalKey<FormState>();
  bool _secureText = true;

  showHide() {
    setState(() {
      _secureText = !_secureText;
    });
  }

  check() {
    final form = _key.currentState;
    if (form.validate()) {
      form.save();
      login();
    }
  }

  login() async {
    debugPrint("Success");
    final response =
        await http.post("http://192.168.1.10/salon/login.php", body: {
      'username': username,
      'password': password,
    });

    debugPrint(response.body.toString());
    final data = jsonDecode(response.body);
    int value = data['value'];
    String message = data['message'];
    String nameAPI = data['name'];
    String emailAPI = data['email'];
    String id = data['userid'];
    print(nameAPI);
    print(id);
    debugPrint(data.toString());
    if (value == 1) {
      setState(() {
        _loginStatus = LoginStatus.signIn;
        savePref(value, nameAPI, emailAPI, id);
      });
      print(message);
      loginToast(message);
    } else {
      print(message);
      failedToast(message);
    }
  }

  loginToast(String toast) {
    return Fluttertoast.showToast(
        msg: 'You Have Sucessfully Login',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3,
        backgroundColor: Colors.green,
        textColor: Colors.white);
  }

  failedToast(String toast) {
    return Fluttertoast.showToast(
        msg: 'Your Account Dosent Exist',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3,
        backgroundColor: Color(0xffb5171d),
        textColor: Colors.white);
  }

  savePref(
    int value,
    String fullname,
    String email,
    String id,
  ) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.setInt('value', value);
      preferences.setString('name', fullname);
      preferences.setString('email', email);
      preferences.setString('id', id);
    });
  }

  var value;
  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      value = preferences.getInt('value');
      _loginStatus = value == 1 ? LoginStatus.signIn : LoginStatus.notSignIn;
    });
  }

  signOut() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.setInt("value", null);
      preferences.setString('name', null);
      preferences.setString('email', null);
      preferences.setString('id', null);
      _loginStatus = LoginStatus.notSignIn;
    });
  }

  @override
  void initState() {
    super.initState();
    getPref();
  }

  @override
  Widget build(BuildContext context) {
    switch (_loginStatus) {
      case LoginStatus.notSignIn:
        return new Scaffold(
            resizeToAvoidBottomPadding: false,
            body: SingleChildScrollView(
              child: Center(
                child: Form(
                  key: _key,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        child: Stack(
                          children: <Widget>[
                            Center(
                              child: Container(
                                padding:
                                    EdgeInsets.fromLTRB(15.0, 150.0, 0.0, 0.0),
                                child: Material(
                                  child: Image.asset(
                                    'assets/loginpic.png',
                                    width: 350,
                                    height: 180,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                          padding: EdgeInsets.only(
                              top: 35.0, left: 20.0, right: 20.0),
                          child: Column(
                            children: <Widget>[
                              TextFormField(
                                style: new TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black),
                                validator: (e) {
                                  if (e.isEmpty) {
                                    return "Please insert username";
                                  }
                                  return null;
                                },
                                onSaved: (e) => username = e,
                                decoration: InputDecoration(
                                    hintText: 'Username',
                                    suffixIcon: Icon(Icons.account_circle),
                                    hintStyle: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.normal,
                                    )),
                              ),
                              SizedBox(height: 20.0),
                              TextFormField(
                                style: new TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black),
                                validator: (e) {
                                  if (e.isEmpty) {
                                    return "Please insert password";
                                  }
                                  return null;
                                },
                                obscureText: _secureText,
                                onSaved: (e) => password = e,
                                decoration: InputDecoration(
                                    hintText: 'Password',
                                    suffixIcon: IconButton(
                                      onPressed: showHide,
                                      icon: Icon(_secureText
                                          ? Icons.visibility_off
                                          : Icons.visibility),
                                    ),
                                    hintStyle: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.normal,
                                    )),
                              ),
                              SizedBox(height: 5.0),
                              Container(
                                alignment: Alignment(1.0, 0.0),
                                padding: EdgeInsets.only(top: 15.0, left: 20),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) => Forget()));
                                  },
                                  child: Text('Forgot Password',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Montserrat',
                                          decoration:
                                              TextDecoration.underline)),
                                ),
                              ),
                              SizedBox(height: 40.0),
                              Container(
                                width: 300,
                                height: 50.0,
                                child: Material(
                                  borderRadius: BorderRadius.circular(25.0),
                                  shadowColor: Color(0xff083663),
                                  color: Color(0xff083663),
                                  elevation: 7.0,
                                  child: MaterialButton(
                                    onPressed: () {
                                      check();
                                    },
                                    child: Center(
                                      child: Text(
                                        'Login',
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Montserrat'),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 20.0),
                            ],
                          )),
                      SizedBox(height: 15.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'No Account yet?',
                            style: TextStyle(
                                fontSize: 17.0, fontFamily: 'Montserrat'),
                          ),
                          SizedBox(width: 5.0),
                          InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => Signup()));
                            },
                            child: Text(
                              'Sign-up',
                              style: TextStyle(
                                  fontSize: 18.0,
                                  color: Color(0xffb5171d),
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ));
        break;
      case LoginStatus.signIn:
        return Menu(signOut);
        break;
    }
  }
}

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  bool _secureText = true;
  String username, password, email, name;

  check() {
    final form = _key.currentState;
    if (form.validate()) {
      form.save();
      save();
    }
  }

  save() async {
    debugPrint("Success");
    final response =
        await http.post("http://192.168.1.10/salon/register.php", body: {
      'username': username,
      'password': password,
      'email': email,
      'name': name,
    });

    debugPrint(response.body.toString());
    final data = jsonDecode(response.body);
    int value = data['value'];
    String message = data['message'];
    debugPrint(data.toString());
    if (value == 1) {
      setState(() {
        Navigator.pop(context);
      });
      loginToast(message);
    } else {
      print(message);
      failedToast(message);
    }
  }

  loginToast(String toast) {
    return Fluttertoast.showToast(
        msg: 'You Have Sucessfully Register',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3,
        backgroundColor: Colors.green,
        textColor: Colors.white);
  }

  failedToast(String toast) {
    return Fluttertoast.showToast(
        msg: 'Account Already Exists',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3,
        backgroundColor: Color(0xffb5171d),
        textColor: Colors.white);
  }

  showHide() {
    setState(() {
      _secureText = !_secureText;
    });
  }

  final _key = new GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        resizeToAvoidBottomPadding: false,
        body: SingleChildScrollView(
          child: Center(
            child: Form(
              key: _key,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: Stack(
                      children: <Widget>[
                        Center(
                          child: Container(
                            padding: EdgeInsets.fromLTRB(15.0, 110.0, 0.0, 0.0),
                            child: Material(
                              child: Image.asset(
                                'assets/loginpic.png',
                                width: 350,
                                height: 180,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                      padding:
                          EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            style: new TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.normal,
                                color: Colors.black),
                            validator: (e) {
                              if (e.isEmpty) {
                                return "Please insert username";
                              }
                              return null;
                            },
                            onSaved: (e) => username = e,
                            decoration: InputDecoration(
                                hintText: 'Username',
                                suffixIcon: Icon(Icons.account_circle),
                                hintStyle: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.normal,
                                )),
                          ),
                          SizedBox(height: 20.0),
                          TextFormField(
                            style: new TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.normal,
                                color: Colors.black),
                            validator: (e) {
                              if (e.isEmpty) {
                                return "Please insert password";
                              }
                              return null;
                            },
                            obscureText: _secureText,
                            onSaved: (e) => password = e,
                            decoration: InputDecoration(
                                hintText: 'Password',
                                suffixIcon: IconButton(
                                  onPressed: showHide,
                                  icon: Icon(_secureText
                                      ? Icons.visibility_off
                                      : Icons.visibility),
                                ),
                                hintStyle: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.normal,
                                )),
                          ),
                          SizedBox(height: 20.0),
                          TextFormField(
                            style: new TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.normal,
                                color: Colors.black),
                            validator: (e) {
                              if (e.isEmpty) {
                                return "Please insert Email";
                              }
                              return null;
                            },
                            onSaved: (e) => email = e,
                            decoration: InputDecoration(
                                hintText: 'Email',
                                suffixIcon: Icon(Icons.mail),
                                hintStyle: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.normal,
                                )),
                          ),
                          SizedBox(height: 20.0),
                          TextFormField(
                            style: new TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.normal,
                                color: Colors.black),
                            validator: (e) {
                              if (e.isEmpty) {
                                return "Please insert Full name";
                              }
                              return null;
                            },
                            onSaved: (e) => name = e,
                            decoration: InputDecoration(
                                hintText: 'Full Name',
                                suffixIcon: Icon(Icons.edit),
                                hintStyle: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.normal,
                                )),
                          ),
                          SizedBox(height: 40.0),
                          Container(
                            width: 300,
                            height: 50.0,
                            child: Material(
                              borderRadius: BorderRadius.circular(25.0),
                              shadowColor: Color(0xff083663),
                              color: Color(0xff083663),
                              elevation: 7.0,
                              child: MaterialButton(
                                onPressed: () {
                                  check();
                                },
                                child: Center(
                                  child: Text(
                                    'Sign Up',
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Montserrat'),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 20.0),
                        ],
                      )),
                ],
              ),
            ),
          ),
        ));
  }
}
