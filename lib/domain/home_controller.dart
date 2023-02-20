import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../core/constants.dart';

class HomeController extends GetxController {
  HomeController();

  static String homeId = "homeId";
  static String zoomId = "zoomId";

  @override
  void onInit() {
    Future.delayed(const Duration(milliseconds: 100), () {
      isShowingLoader = true;
    });
    Timer(const Duration(milliseconds: 3000), () {
      isShowingLoader = false;
      isShowingPage = true;
    });
    super.onInit();
  }

  bool _isShowingLoader = false;

  bool get isShowingLoader => _isShowingLoader;

  set isShowingLoader(bool value) {
    _isShowingLoader = value;
    update([homeId]);
  }

  bool _isShowingPage = false;

  bool get isShowingPage => _isShowingPage;

  set isShowingPage(bool value) {
    _isShowingPage = value;
    update([homeId]);
  }

  bool _isShowingZoom = false;

  bool get isShowingZoom => _isShowingZoom;

  set isShowingZoom(bool value) {
    _isShowingZoom = value;
    update([homeId, zoomId]);
  }

  String _imageZoom = "";

  String get imageZoom => _imageZoom;

  set imageZoom(String value) {
    _imageZoom = value;
    update([homeId, zoomId]);
  }

  int getLimitByScreen(
      BuildContext context, SizingInformation sizingInformation, int page) {
    int limit = 0;
    if (sizingInformation.deviceScreenType == DeviceScreenType.mobile) {
      mobileResolutions
          .asMap()
          .entries
          .map((resolution) => {
                if (MediaQuery.of(context).size.width >= resolution.value &&
                    MediaQuery.of(context).size.width < resolution.value + 25)
                  {
                    limit = ((resolution.key * 25) + 135) +
                        ((page - 2) * ((resolution.key * 25) + 405))
                  }
              })
          .toList();
    }
    if (sizingInformation.deviceScreenType == DeviceScreenType.tablet) {
      tabletResolutions
          .asMap()
          .entries
          .map((resolution) => {
                if (MediaQuery.of(context).size.width >= resolution.value &&
                    MediaQuery.of(context).size.width < resolution.value + 100)
                  {
                    limit = ((resolution.key * 50) + 110) +
                        ((page - 2) * ((resolution.key * 50) + 330))
                  }
              })
          .toList();
    }
    if (sizingInformation.deviceScreenType == DeviceScreenType.desktop) {
      webResolutions
          .asMap()
          .entries
          .map((resolution) => {
                if (MediaQuery.of(context).size.width >= resolution.value &&
                    MediaQuery.of(context).size.width < resolution.value + 100)
                  {
                    limit = ((resolution.key * 50) + 170) +
                        ((page - 2) * ((resolution.key * 50) + 570))
                  }
              })
          .toList();
    }
    return limit;
  }
}
