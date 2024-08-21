import 'dart:core';
import 'dart:core';
import 'dart:core';
import 'dart:core';

import 'package:flutter/material.dart';

final kHintTextStyle = TextStyle(
  color: Colors.white54,
  fontFamily: 'OpenSans',
);

final kLabelStyle = TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.bold,
  fontFamily: 'OpenSans',
);

final kBoxDecorationStyle = BoxDecoration(
  color: Color(0xFF6CA8F1),
  borderRadius: BorderRadius.circular(10.0),
  boxShadow: [
    BoxShadow(
      color: Colors.black12,
      blurRadius: 6.0,
      offset: Offset(0, 2),
    ),
  ],
);

const TextStyle kBodyText =
    TextStyle(fontSize: 22, color: Colors.white, height: 1.5);

const TextStyle kBodyText1 =
    TextStyle(fontSize: 15, color: Colors.white, height: 1.5);

const TextStyle kBodyText2 =
    TextStyle(fontSize: 20, color: kcontentColor, height: 1.5);

const TextStyle kBodyText3 =
    TextStyle(fontSize: 20, color: kourcolor1, height: 1.5);

const Color kWhite = Colors.white;
//const Color kBlue = Color(0xff5663ff);
const Color kBlue = Color(0xFF122B5F);
//const Color kBlue = Color.fromARGB(255, 30, 70, 157);
const kscaffoldColor = Color(0xffffffff);
const kcontentColor = Color(0xffF5F5F5);
const kprimaryColor = Color(0xffff660e);
const kourcolor = Color(0xff221F20);
const kourcolor1 = Color(0xFF222222);

abstract class AppColor {
  static const LinearGradient gradient = LinearGradient(
    colors: [
      Colors.white,
      Color(0xFFCBAAFF),
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
  static const Color primary = Color(0xFF935DE6);
  static const Color secondary = Color(0xFF0C0A19);
  static const Color text = Color(0xFF32303d);
  static const Color accent = Color(0xFFFFFFFF);
  static const Color accent_1 = Color(0xFFefeff6);
  static const Color accent_2 = Color(0xFFeef6ff);
  static const Color accent_3 = Color(0xFFfff7f4);
  static const Color accent_4 = Color(0xFFffe4ea);
}

abstract class AppStyle {
  static const h1Light = TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.bold,
      // height: 38,
      // letterSpacing: 20,
      color: AppColor.accent_1);

  static const h1Dark = TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.bold,
      // height: 38,
      // letterSpacing: 20,
      color: AppColor.text);

  static const h2 = TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w600,
      // letterSpacing: 20,
      // height: 32,
      color: AppColor.text);

  static const h3 = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.normal,
      // letterSpacing: 20,
      // height: 20,
      color: AppColor.text);

  static const text = TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.normal,
      // letterSpacing: 20,
      // height: 20,
      color: AppColor.text);

  static const bodyText = TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.normal,
      // letterSpacing: 20,
      // height: 20,
      color: AppColor.text);
}

const String Profile = "Profile";
const String tEditProfile = "Edit Profile";
const String LogoutDialogHeading = "Logout";
const String ProfileHeading = "Rand Suwan";
const String ProfileSubHeading = "rand.nabil.2019@gmail.com";

//const String tHenus = tLogout;
const String tMenul = "Settings";
const String tMenu4 = "Information";
const String tMenu2 = "Billing Details";
const String tMenu3 = "User Management";
//** Update Profile Screen * Text const String telete • "Delete";
const String tJoined = "Joined";
const String tJoinedAt = "31October2022";
