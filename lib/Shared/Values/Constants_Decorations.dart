import 'package:flutter/material.dart';
import 'package:next_level_admin/Shared/Values/Constants_Colours.dart';
import 'package:next_level_admin/Shared/Values/Constants_Numerical.dart';



const textInputDecoration = InputDecoration(
    fillColor: Colors.white,
    filled: true,
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.red),
      borderRadius: BorderRadius.all(Radius.circular(textInputDecorationRadius)),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: mainColor),
      borderRadius: BorderRadius.all(Radius.circular(textInputDecorationRadius)),
    ),
    //hintStyle: TextStyle(color: Colors.black),
    labelStyle: TextStyle(color: mainColor),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.black),
      borderRadius: BorderRadius.all(Radius.circular(textInputDecorationRadius)),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: mainColor),
      borderRadius: BorderRadius.all(Radius.circular(textInputDecorationRadius)),
    )
);