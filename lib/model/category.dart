import 'package:salon/Widget/constant.dart';
import 'package:flutter/material.dart';

class Category {
  final String icon;
  final String title;
  final String subtitle;
  final Color color;
  Category({this.icon, this.subtitle, this.title, this.color});
}

List<Category> categoryList = [
  Category(
    icon: "assets/saloon.svg",
    title: "Saloon",
    subtitle: "",
    color: kPurple,
  ),
  Category(
    icon: "assets/haircut.svg",
    title: "Haircut",
    subtitle: "",
    color: kYellow,
  ),
  Category(
    icon: "assets/palor.svg",
    title: "Palor",
    subtitle: "",
    color: kGreen,
  ),
  Category(
    icon: "assets/shampoo.svg",
    title: "Shampoo",
    subtitle: "",
    color: kPink,
  ),
  Category(
    icon: "assets/spa.svg",
    title: "Spa",
    subtitle: "",
    color: kIndigo,
  ),
];
