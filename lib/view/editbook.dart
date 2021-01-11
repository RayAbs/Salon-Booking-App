import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:salon/model/barberdetails.dart';

class Editbook extends StatefulWidget {
  final Barberdetails model;
  final VoidCallback reload;
  Editbook(this.model, this.reload);
  @override
  _EditbookState createState() => _EditbookState();
}

class _EditbookState extends State<Editbook> {
  final _key = new GlobalKey<FormState>();
  String _portVal;
  String _portVal1;

  List _ports = [
    'Haircut',
    'Womens Hair Cut',
    'Color & Blow Dry',
    'Oil Treatment'
  ];
  List _stylist = [
    'Oscar Blandi',
    'Nicky Clarke',
    'Kimberly',
    'Jen Atkin',
    'Ted Gibson'
  ];

  final DateFormat dateFormat = DateFormat('MM-dd-yyyy HH:mm');
  TimeOfDay selecttime = new TimeOfDay.now();
  Future<TimeOfDay> _selectedTime(BuildContext context) {
    return showTimePicker(context: context, initialTime: selecttime);
  }

  DateTime selectdate;
  Future<DateTime> _selectDate(BuildContext context) => showDatePicker(
      context: context,
      initialDate: DateTime.now().add(Duration(seconds: 1)),
      firstDate: DateTime.now(),
      lastDate: DateTime(3000));

  check() {
    final form = _key.currentState;
    if (form.validate()) {
      form.save();
      save();
    }
  }

  save() async {
    //'transaction_date': selectdate.toString(),
    String trans_dt = selectdate.toString();
    final response =
        await http.post('http://192.168.1.10/salon/editbook.php', body: {
      'typeofservice': _portVal,
      'stylist': _portVal1,
      'trans_dt': trans_dt,
      'clientid': widget.model.id,
    });
    final data = jsonDecode(response.body);
    int value = data['value'];
    if (value == 1) {
      setState(() {
        Navigator.pop(context);
      });
      Fluttertoast.showToast(
          msg: 'Record successfully updated',
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
          msg: 'Fail to update the record',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 6,
          backgroundColor: Color(0xffb5171d),
          textColor: Colors.white);
      String message = data['message'];
      print(message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text(
          "Edit Booked",
        ),
        backgroundColor: Color(0xff083663),
      ),
      body: Form(
        key: _key,
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: <Widget>[
                Container(
                  child: Stack(
                    children: <Widget>[
                      Center(
                        child: Container(
                          padding: EdgeInsets.fromLTRB(15.0, 50.0, 0.0, 0.0),
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
                SizedBox(
                  height: 10.0,
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'BOOKING FORM',
                          style: TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.w900),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    padding: EdgeInsets.only(left: 16.0, right: 16.0),
                    decoration: BoxDecoration(
                        border:
                            Border.all(color: Color(0xff083663), width: 1.0)),
                    child: DropdownButton(
                      hint: Text('Please select a type of service'),
                      elevation: 5,
                      icon: Icon(Icons.arrow_drop_down),
                      iconSize: 36.0,
                      isExpanded: true,
                      style:
                          TextStyle(color: Color(0xff083663), fontSize: 18.0),
                      value: _portVal,
                      onChanged: (value) {
                        setState(() {
                          _portVal = value;
                        });
                      },
                      items: _ports.map((value) {
                        return DropdownMenuItem(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    padding: EdgeInsets.only(left: 16.0, right: 16.0),
                    decoration: BoxDecoration(
                        border:
                            Border.all(color: Color(0xff083663), width: 1.0)),
                    child: DropdownButton(
                      hint: Text('Please select a stylist'),
                      elevation: 5,
                      icon: Icon(Icons.arrow_drop_down),
                      iconSize: 36.0,
                      isExpanded: true,
                      style:
                          TextStyle(color: Color(0xff083663), fontSize: 18.0),
                      value: _portVal1,
                      onChanged: (value) {
                        setState(() {
                          _portVal1 = value;
                        });
                      },
                      items: _stylist.map((value) {
                        return DropdownMenuItem(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                  child: InkWell(
                    onTap: () async {
                      final selectdate = await _selectDate(context);
                      if (selectdate == null) return;

                      final selecttime = await _selectedTime(context);
                      if (selecttime == null) return;

                      setState(() {
                        this.selectdate = DateTime(
                          selectdate.year,
                          selectdate.month,
                          selectdate.day,
                          selecttime.hour,
                          selecttime.minute,
                        );
                      });
                    },
                    child: InputDecorator(
                      decoration: InputDecoration(
                          labelText: 'Actual Date and Time of Arrival',
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Color(0xff083663)))),
                      baseStyle: TextStyle(
                        fontSize: 16.0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            selectdate == null
                                ? '00-00-0000 00:00'
                                : dateFormat.format(selectdate),
                            style: TextStyle(
                                fontSize: 16.0, color: Color(0xff083663)),
                          ),
                          Icon(
                            Icons.calendar_today,
                            color:
                                Theme.of(context).brightness == Brightness.light
                                    ? Color(0xff083663)
                                    : Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 50,
                  width: 250,
                  child: RaisedButton(
                    onPressed: () {
                      check();
                    },
                    color: Colors.green,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30.0))),
                    textColor: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        // Icon(
                        //   Icons.account_box,
                        //   color: Colors.white,
                        // ),
                        Text(
                          'Update Record',
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
      ),
    );
  }
}
