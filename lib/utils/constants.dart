import 'package:flutter/material.dart';

// Colors that we use in our app
const kTextColor = Color(0xFF3C4046);
const kBackgroundColor = Color(0xFFFEFEFE);
const kTitleTextColor = Color(0xFF303030);
const kBodyTextColor = Color(0xFF4B4B4B);
const kTextLightColor = Color(0xFF959595);
const kInfectedColor = Color(0xFFFF8748);
const kDeathColor = Color(0xFFFF4848);
const kRecovercolor = Color(0xFF36C12C);
const kPrimaryColor = Color(0xFF3382CC);
final kShadowColor = Color(0xFFB7B7B7).withOpacity(.16);
final kActiveShadowColor = Color(0xFF4056C6).withOpacity(.15);

const kHeadingTextStyle = TextStyle(
  fontSize: 22,
  fontWeight: FontWeight.w600,
);

const kSubTextStyle = TextStyle(fontSize: 16, color: kTextLightColor);

const kTitleTextstyle = TextStyle(
  fontSize: 18,
  color: kTitleTextColor,
  fontWeight: FontWeight.bold,
);

const double kDefaultPadding = 20.0;


const String apiKey = "AIzaSyAT-29Vo1xQZU4nCKMCgvKfRivVJ2KkHhU";

const Color primaryColor = Color(0xFF006491);
const Color textColorLightTheme = Color(0xFF0D0D0E);

const Color secondaryColor80LightTheme = Color(0xFF202225);
const Color secondaryColor60LightTheme = Color(0xFF313336);
const Color secondaryColor40LightTheme = Color(0xFF585858);
const Color secondaryColor20LightTheme = Color(0xFF787F84);
const Color secondaryColor10LightTheme = Color(0xFFEEEEEE);
const Color secondaryColor5LightTheme = Color(0xFFF8F8F8);

const defaultPadding = 16.0;

Route scaleInTransition(Widget page) {
  return PageRouteBuilder(
    transitionDuration: const Duration(milliseconds: 300),
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, page) {
      var begin = 0.9;
      var end = 1.0;
      var curve = Curves.easeInOutBack;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      var tween2 = Tween(begin: 0.0, end: 1.0).chain(CurveTween(curve: curve));


      return ScaleTransition(
        scale: animation.drive(tween),
        child: FadeTransition(
          opacity: animation.drive(tween2),
          child: page,
        ),
      );
    },
  );
}
