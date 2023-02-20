import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../core/constants.dart';
import '../../domain/home_controller.dart';
import '../../core/maps.dart';

class ImageWidget extends StatelessWidget {
  const ImageWidget({
    Key? key,
    required this.homeController,
    required this.sizingInformation,
    required this.page,
    required this.pixels,
  }) : super(key: key);

  final HomeController homeController;
  final SizingInformation sizingInformation;
  final int page;
  final double pixels;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      id: HomeController.zoomId,
      init: homeController,
      builder: (controller) {
        return AnimatedOpacity(
          opacity: page == 1
              ? 1
              : pixels >=
                      controller.getLimitByScreen(
                        context,
                        sizingInformation,
                        page,
                      )
                  ? 1
                  : 0,
          duration: const Duration(milliseconds: 1000),
          child: Column(
            children: [
              if (page == 7) ...[
                if (sizingInformation.deviceScreenType ==
                    DeviceScreenType.mobile)
                  Container(
                    color: colorBackgroundMobile,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.width * 1.5,
                    child: Column(
                      children: [
                        Image.asset(
                          "assets/iconnect_mobile_page-0007-1.jpg",
                          fit: BoxFit.fill,
                        ),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: Container(
                            height: 250,
                            width: MediaQuery.of(context).size.width - 50,
                            decoration: const BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: colorShadow,
                                  spreadRadius: 5,
                                  blurRadius: 5,
                                  offset: Offset(0.1, 0.1),
                                ),
                              ],
                            ),
                            child: const GoogleMap(),
                          ),
                        ),
                        Image.asset(
                          "assets/iconnect_mobile_page-0007-2.jpg",
                          fit: BoxFit.fill,
                        ),
                      ],
                    ),
                  ),
                if (sizingInformation.deviceScreenType ==
                        DeviceScreenType.tablet ||
                    sizingInformation.deviceScreenType ==
                        DeviceScreenType.desktop)
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.width / 2 * 1.15,
                    child: Column(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Image.asset(
                            "assets/iconnect_page-0007-1.jpg",
                            fit: BoxFit.fill,
                          ),
                        ),
                        Expanded(
                          flex: 5,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Expanded(
                                flex: 5,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    left: 40,
                                    bottom: 20,
                                  ),
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: colorShadow,
                                          spreadRadius: 5,
                                          blurRadius: 5,
                                          offset: Offset(0.1, 0.1),
                                        ),
                                      ],
                                    ),
                                    child: const GoogleMap(),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 4,
                                child: Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: Image.asset(
                                    "assets/iconnect_page-0007-2.jpg",
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Image.asset(
                            "assets/iconnect_page-0007-3.jpg",
                            fit: BoxFit.fill,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
              if (page >= 20 && page <= 27) ...[
                if (sizingInformation.deviceScreenType ==
                    DeviceScreenType.mobile)
                  InkWell(
                    onTap: (() {
                      controller.imageZoom =
                          "assets/iconnect_mobile_page-00$page.jpg";
                      controller.isShowingZoom =
                          controller.isShowingZoom ? false : true;
                    }),
                    child: Image.asset(
                      "assets/iconnect_mobile_page-00$page.jpg",
                      fit: BoxFit.fill,
                    ),
                  ),
                if (sizingInformation.deviceScreenType ==
                        DeviceScreenType.tablet ||
                    sizingInformation.deviceScreenType ==
                        DeviceScreenType.desktop)
                  InkWell(
                    onTap: (() {
                      controller.imageZoom = "assets/iconnect_page-00$page.jpg";
                      controller.isShowingZoom =
                          controller.isShowingZoom ? false : true;
                    }),
                    child: Image.asset(
                      "assets/iconnect_page-00$page.jpg",
                      fit: BoxFit.fill,
                    ),
                  ),
              ],
              if ((page < 20 || page > 27) && page != 7) ...[
                if (sizingInformation.deviceScreenType ==
                    DeviceScreenType.mobile)
                  Image.asset(
                    page < 10
                        ? "assets/iconnect_mobile_page-000$page.jpg"
                        : "assets/iconnect_mobile_page-00$page.jpg",
                    fit: BoxFit.fill,
                  ),
                if (sizingInformation.deviceScreenType ==
                        DeviceScreenType.tablet ||
                    sizingInformation.deviceScreenType ==
                        DeviceScreenType.desktop)
                  Image.asset(
                    page < 10
                        ? "assets/iconnect_page-000$page.jpg"
                        : "assets/iconnect_page-00$page.jpg",
                    fit: BoxFit.fill,
                  ),
              ],
            ],
          ),
        );
      },
    );
  }
}

// w: 500-i: 700-e: 300 --- w: 525-i: 740-e: 315 --- w: 550-i: 780-e: 330
// 475: 660 / 450: 620 / 425: 580 / 400: 540 / 375: 500 / 350: 460 / 325: 420 / 300: 380 / 275: 340 / 250: 300 -> imagen
// 475: 275 / 450: 250 / 425: 225 / 400: 200 / 375: 175 / 350: 150 / 325: 125 / 300: 100 / 275: 75 / 250: 50 -> efecto
