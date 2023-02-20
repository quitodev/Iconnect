import 'package:flutter/material.dart';

// COLORS
const Color colorBackground = Color.fromARGB(255, 230, 230, 230);
const Color colorBackgroundMobile = Color.fromARGB(255, 222, 222, 222);
const Color colorBackgroundZoomBig = Color.fromARGB(100, 0, 0, 0);
const Color colorBackgroundZoomSmall = Color.fromARGB(50, 0, 0, 0);
const Color colorIconClose = Color.fromARGB(255, 255, 255, 255);
const Color colorIconWhatsApp = Color.fromARGB(255, 255, 255, 255);
const Color colorIconWhatsAppBackground = Color.fromARGB(255, 76, 127, 50);
const Color colorProgress = Color.fromARGB(255, 59, 59, 59);
const Color colorShadow = Color.fromARGB(121, 173, 173, 173);

// STRINGS
const String nameApp = "Iconnect";
const String addressMap = "Av. Cabildo 3546";
const String whatsAppUrl =
    "https://api.whatsapp.com/send/?phone=5491126935384&text=Hola%2C+quisiera+recibir+m%C3%A1s+informaci%C3%B3n+sobre+Iconnect+Cabildo.";
const String googleMapsUrl =
    "https://www.google.com.ar/maps/place/Av.+Cabildo+3546,+Buenos+Aires/@-34.5505331,-58.4695149,17z/data=!3m1!4b1!4m5!3m4!1s0x95bcb69ced1632bb:0x2572af9e68d4de1!8m2!3d-34.5505375!4d-58.4673262";

// DOUBLES
const double latitudeMap = -34.550520;
const double longitudeMap = -58.467273;
const double zoomMap = 17;

// PAGES
List<int> mobilePages = List.generate(31, (index) => index + 1);
List<int> webPages = List.generate(32, (index) => index + 1);

// RESOULUTIOS

const List<int> mobileResolutions = [
  250,
  275,
  300,
  325,
  350,
  375,
  400,
  425,
  450,
  475,
  500,
  525,
  550,
  575,
  600,
];

const List<int> tabletResolutions = [
  600,
  700,
  800,
  900,
  1000,
];

const List<int> webResolutions = [
  950,
  1050,
  1150,
  1250,
  1350,
  1450,
  1550,
  1650,
  1750,
  1850,
  1950,
  2050,
  2150,
  2250,
  2350,
  2450,
  2550,
  2650,
  2750,
  2850,
  2950,
  3050,
  3150,
  3250,
  3350,
  3450,
  3550,
  3650,
  3750,
  3850,
  3950,
  4050,
];
