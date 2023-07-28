import 'package:flutter/material.dart';

const kPrimary = Color(0xFF0090EA);
const white = Color(0xFFFFFFFF);
const darkText = Color(0xFF707070);
const lightText = Color(0xFF9D9B9B);
const lightGrey = Color(0xFFA3A2A2);
const greyColor = Color(0xFFEAEAEA);
const Kyellow = Color(0xffFFA800);
const inputFieldBackgroundColor = Color(0xFFF7F7F7);

const screenTitle = TextStyle(
  fontFamily: 'Segoe UI',
  fontSize: 30.0,
  color: darkText,
  fontWeight: FontWeight.w700,
);

const labelText = TextStyle(
  fontFamily: 'Segoe UI',
  fontSize: 20.0,
  color: darkText,
  fontWeight: FontWeight.w600,
);

const formInputStyle = InputDecoration(
  filled: true,
  fillColor: inputFieldBackgroundColor,
  contentPadding: EdgeInsets.all(11.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(5.0),
    ),
    borderSide: BorderSide(
      width: 0,
      style: BorderStyle.none,
    ),
  ),
);
