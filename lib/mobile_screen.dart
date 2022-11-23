import 'package:flutter/material.dart';
import 'package:iconnect/constants.dart';
import 'package:iconnect/maps.dart';
import 'package:photo_view/photo_view.dart';

class MobileScreen extends StatefulWidget {
  const MobileScreen({
    Key? key, 
    required this.controller, 
    required this.pixels,
    required this.duration,
  }) : super(key: key);

  final ScrollController controller;
  final double pixels;
  final int duration;

  @override
  State<MobileScreen> createState() => _MobileScreenState();
}

class _MobileScreenState extends State<MobileScreen> {
  List<int> resolutions = [
    250, 275, 300, 325, 350, 375, 400, 425,
    450, 475, 500, 525, 550, 575, 600,
  ];
  List<int> pages = [
    1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17,
    18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31,
  ];
  bool isShowingPlan = false;
  String plan = "";

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          controller: widget.controller,
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: pages.map((page) => imageWidget(page)).toList(),
            ),
          ),
        ),
        if (isShowingPlan) ... [
          zoomWidget(),
        ],
      ],
    );
  }

  Widget zoomWidget() {
    return Container(
      color: colorBackgroundZoomBig,
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.symmetric(
              vertical: 30,
              horizontal: 30,
            ),
            child: ClipRect(
              child: PhotoView(
                backgroundDecoration: const BoxDecoration(
                  color: colorBackgroundZoomSmall
                ),
                imageProvider: AssetImage(plan),
                maxScale: PhotoViewComputedScale.covered * 2.5,
                minScale: PhotoViewComputedScale.contained,
                initialScale: PhotoViewComputedScale.covered,
              ),
            ),
          ),
          InkWell(
            onTap: (() {
              setState(() {
                plan = "";
                isShowingPlan = false;
              });
            }),
          child: const Padding(
            padding: EdgeInsets.all(5),
              child: Icon(
                Icons.close_rounded,
                color: colorIconClose,
                size: 25,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget imageWidget(int page) {
    return AnimatedOpacity(
      opacity: page == 1 ? 1 : widget.pixels >= getLimitByScreen(page) ? 1 : 0,
      duration: Duration(milliseconds: widget.duration),
      child: Column(
        children: [
          if (page == 7) ... [
            ubicationWidget(page),
          ],
          if (page >= 20 && page <= 27) ... [
            planWidget(page),
          ],
          if ((page < 20 || page > 27) && page != 7) ... [
            otherWidget(page),
          ],
        ],
      ),
    );
  }

  int getLimitByScreen(int page) {
    int limit = 0;
    resolutions
      .asMap()
      .entries
      .map((resolution) => {
        if (MediaQuery.of(context).size.width >= resolution.value &&
        MediaQuery.of(context).size.width < resolution.value + 25) {
          limit = ((resolution.key * 25) + 135) +
          ((page - 2) * ((resolution.key * 25) + 405))
        }
      }
    ).toList();
    return limit;
  } // w: 500-i: 700-e: 300 --- w: 525-i: 740-e: 315 --- w: 550-i: 780-e: 330
  // 475: 660 / 450: 620 / 425: 580 / 400: 540 / 375: 500 / 350: 460 / 325: 420 / 300: 380 / 275: 340 / 250: 300 -> imagen
  // 475: 275 / 450: 250 / 425: 225 / 400: 200 / 375: 175 / 350: 150 / 325: 125 / 300: 100 / 275: 75 / 250: 50 -> efecto

  Widget ubicationWidget(int page) {
    return Container(
      color: colorBackgroundMobile,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.width * 1.5,
      child: Column(
        children: [
          Image.asset(
              "assets/iconnect_mobile_page-0007-1.jpg", 
              fit: BoxFit.fill
            ),
          const Spacer(),
          mapWidget(),
          Image.asset(
              "assets/iconnect_mobile_page-0007-2.jpg", 
              fit: BoxFit.fill
            ),
        ],
      ),
    );
  }

  Widget mapWidget() {
    return Padding(
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
    );
  }

  Widget planWidget(int page) {
    return InkWell(
      onTap: (() {
        setState(() {
          plan = "assets/iconnect_mobile_page-00$page.jpg";
          isShowingPlan = isShowingPlan ? false : true;
        });
      }),
      child: Image.asset(
        "assets/iconnect_mobile_page-00$page.jpg",
        fit: BoxFit.fill
      ),
    );
  }

  Widget otherWidget(int page) {
    return Image.asset(page < 10
      ? "assets/iconnect_mobile_page-000$page.jpg"
      : "assets/iconnect_mobile_page-00$page.jpg",
      fit: BoxFit.fill
    );
  }
}
