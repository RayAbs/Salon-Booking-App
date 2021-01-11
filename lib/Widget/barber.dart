import 'package:flutter/material.dart';
import 'package:salon/model/barber.dart';

import 'constant.dart';

class BarberCard extends StatelessWidget {
  final Barber barber;
  BarberCard({this.barber});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150.0,
      // color: Colors.red,
      margin: EdgeInsets.only(left: 18.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: 130.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7.0),
              image: DecorationImage(
                image: AssetImage(barber.image),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Row(
            children: [
              SizedBox(
                width: 100.0,
                child: Text(
                  barber.name,
                  overflow: TextOverflow.ellipsis,
                  style: kTitleItem,
                ),
              ),
              // Spacer(),
              // Icon(
              //   Icons.star,
              //   size: 15.0,
              //   color: kYellow,
              // ),
              // Text(barbershop.rating, style: kTitleItem),
            ],
          ),
          // Text(barbershop.address,
          //     overflow: TextOverflow.ellipsis, style: kTitleItem),
        ],
      ),
    );
  }
}
