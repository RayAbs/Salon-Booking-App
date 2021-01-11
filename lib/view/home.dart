import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:salon/Widget/barber.dart';
import 'package:salon/Widget/barbershop.dart';

import 'package:salon/Widget/constant.dart';
import 'package:salon/Widget/custom_list_tile.dart';
import 'package:salon/model/barber.dart';
import 'package:salon/model/barbershop.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              ClipPath(
                clipper: OvalBottomBorderClipper(),
                child: Container(
                  width: double.infinity,
                  height: 305.0,
                  padding: EdgeInsets.only(bottom: 50.0),
                  decoration: BoxDecoration(
                    color: kYellow,
                    image: DecorationImage(
                      image: AssetImage("assets/img-1639.jpg"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      AppBar(
                        backgroundColor: Colors.black12.withOpacity(.0),
                        elevation: 0.0,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 30.0),
              CustomListTile(title: "Best Hairstyles"),
              SizedBox(height: 25.0),
              Container(
                width: double.infinity,
                height: 150.0,
                child: ListView.builder(
                  itemCount: bestList.length,
                  scrollDirection: Axis.horizontal,
                  physics: ScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    var barbershop = bestList[index];
                    return BarbershopCard(barbershop: barbershop);
                  },
                ),
              ),
              SizedBox(height: 30.0),
              CustomListTile(title: "Best Hairstylist"),
              SizedBox(height: 25.0),
              Container(
                width: double.infinity,
                height: 150.0,
                child: ListView.builder(
                  itemCount: bestList1.length,
                  scrollDirection: Axis.horizontal,
                  physics: ScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    var barber = bestList1[index];
                    return BarberCard(barber: barber);
                  },
                ),
              ),
              SizedBox(height: 20.0),
            ],
          ),
        ),
      ),
    );
  }
}
