import 'dart:async';

import 'package:flutter/material.dart';
import 'package:iconnect/constants.dart';
import 'package:iconnect/mobile_screen.dart';
import 'package:iconnect/tablet_screen.dart';
import 'package:iconnect/web_screen.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:url_launcher/url_launcher.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Iconnect",
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: const MyHomePage(title: "Iconnect"),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final ScrollController controller = ScrollController();
  double pixels = 0;
  bool isShowingLoader = false;
  bool isShowingPage = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 100), () {
      setState(() {
        isShowingLoader = true;
      });
    });
    Timer(const Duration(milliseconds: 3000), () {
      setState(() {
        isShowingLoader = false;
        isShowingPage = true;
      });
    });
    controller.addListener(() {
      setState(() {
        pixels = controller.position.pixels;
        // print(controller.position.pixels);
        // print(MediaQuery.of(context).size.width);
      });
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MediaQuery.of(context).size.width > 600 ? colorBackground : colorBackgroundMobile,
      floatingActionButton: floatingButtonWidget(),
      body: ResponsiveBuilder(builder: (context, sizingInformation) {
        return Stack(
          children: [
            AnimatedOpacity(
              opacity: isShowingLoader ? 1 : 0, 
              duration: const Duration(milliseconds: 1000),
              child: progressWidget(),
            ),
            AnimatedOpacity(
              opacity: isShowingPage ? 1 : 0, 
              duration: const Duration(milliseconds: 1000),
              child: Stack(
                children: [
                  if (sizingInformation.deviceScreenType == DeviceScreenType.desktop) ... [
                    WebScreen(controller: controller, pixels: pixels, duration: 1000),
                  ],
                  if (sizingInformation.deviceScreenType == DeviceScreenType.tablet) ... [
                    TabletScreen(controller: controller, pixels: pixels, duration: 1000),
                  ],
                  if (sizingInformation.deviceScreenType == DeviceScreenType.mobile) ... [
                    MobileScreen(controller: controller, pixels: pixels, duration: 1000),
                  ],
                ],
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget floatingButtonWidget() {
    return FloatingActionButton(
      elevation: 12,
      backgroundColor: colorIconWhatsAppBackground,
      onPressed: () => openURL(),
      child: const Icon(
        Icons.whatsapp_rounded,
          color: colorIconWhatsApp,
          size: 25,
      ),
    );
  }

  Widget progressWidget() {
    return Container(
      alignment: Alignment.center,
      color: colorBackground,
      child: const CircularProgressIndicator(
        color: colorProgress,
      ),
    );
  }

  Future<void> openURL() async {
    final Uri url = Uri.parse(whatsAppUrl);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      // throw "Could not launch $url";
    }
  }
}