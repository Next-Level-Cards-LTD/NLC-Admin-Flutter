import 'package:flutter/material.dart';

//Brand Colours
const mainColor = Color.fromRGBO(255, 0, 0, 1);
const secondaryColor = Color.fromRGBO(0, 102, 102, 1);
const tertiaryColor = Color.fromRGBO(255, 255, 255, 1);

//Button Colours
const disabledColor = Colors.grey;

//Error Message Colour
const errorTextColor = Color.fromRGBO(255, 0, 0, 1);

//Main Swatch
Map<int, Color> swatch = {
  50:Color.fromRGBO(mainColor.red, mainColor.green, mainColor.blue, .1),
  100:Color.fromRGBO(mainColor.red, mainColor.green, mainColor.blue, .2),
  200:Color.fromRGBO(mainColor.red, mainColor.green, mainColor.blue, .3),
  300:Color.fromRGBO(mainColor.red, mainColor.green, mainColor.blue, .4),
  400:Color.fromRGBO(mainColor.red, mainColor.green, mainColor.blue, .5),
  500:Color.fromRGBO(mainColor.red, mainColor.green, mainColor.blue, .6),
  600:Color.fromRGBO(mainColor.red, mainColor.green, mainColor.blue, .7),
  700:Color.fromRGBO(mainColor.red, mainColor.green, mainColor.blue, .8),
  800:Color.fromRGBO(mainColor.red, mainColor.green, mainColor.blue, .9),
  900:Color.fromRGBO(mainColor.red, mainColor.green, mainColor.blue, 1),
};
MaterialColor mainSwatch = new MaterialColor(mainColor.value, swatch);