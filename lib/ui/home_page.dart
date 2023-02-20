import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:url_launcher/url_launcher.dart';

import '../core/constants.dart';
import '../domain/home_controller.dart';
import 'widgets/image_widget.dart';
import 'widgets/zoom_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  late final HomeController homeController;
  late final ScrollController scrollController;
  double pixels = 0;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    homeController = Get.put(HomeController());
    scrollController = ScrollController();
    scrollController.addListener(() {
      setState(() {
        pixels = scrollController.position.pixels;
        // print(scrollController.position.pixels);
        // print(MediaQuery.of(context).size.width);
      });
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  Future<void> openURL() async {
    final Uri url = Uri.parse(whatsAppUrl);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      // throw "Could not launch $url";
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: MediaQuery.of(context).size.width > 600
          ? colorBackground
          : colorBackgroundMobile,
      floatingActionButton: FloatingActionButton(
        elevation: 12,
        backgroundColor: colorIconWhatsAppBackground,
        onPressed: () => openURL(),
        child: const Icon(
          MdiIcons.whatsapp,
          color: colorIconWhatsApp,
          size: 25,
        ),
      ),
      body: GetBuilder<HomeController>(
        id: HomeController.homeId,
        init: homeController,
        builder: (controller) {
          return ResponsiveBuilder(builder:
              (BuildContext context, SizingInformation sizingInformation) {
            return Stack(
              children: [
                AnimatedOpacity(
                  opacity: controller.isShowingLoader ? 1 : 0,
                  duration: const Duration(milliseconds: 1000),
                  child: Container(
                    alignment: Alignment.center,
                    color: colorBackground,
                    child: const CircularProgressIndicator(
                      color: colorProgress,
                    ),
                  ),
                ),
                AnimatedOpacity(
                  opacity: controller.isShowingPage ? 1 : 0,
                  duration: const Duration(milliseconds: 1000),
                  child: Stack(
                    children: [
                      SingleChildScrollView(
                        controller: scrollController,
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            children: sizingInformation.deviceScreenType ==
                                    DeviceScreenType.mobile
                                ? mobilePages
                                    .map((page) => ImageWidget(
                                          key: Key("$page"),
                                          homeController: controller,
                                          sizingInformation: sizingInformation,
                                          page: page,
                                          pixels: pixels,
                                        ))
                                    .toList()
                                : webPages
                                    .map((page) => ImageWidget(
                                          key: Key("$page"),
                                          homeController: controller,
                                          sizingInformation: sizingInformation,
                                          page: page,
                                          pixels: pixels,
                                        ))
                                    .toList(),
                          ),
                        ),
                      ),
                      if (homeController.isShowingZoom)
                        ZoomWidget(homeController: controller),
                    ],
                  ),
                ),
              ],
            );
          });
        },
      ),
    );
  }
}
