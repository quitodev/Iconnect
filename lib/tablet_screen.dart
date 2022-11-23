import 'package:flutter/material.dart';
import 'package:iconnect/constants.dart';
import 'package:iconnect/maps.dart';
import 'package:photo_view/photo_view.dart';

class TabletScreen extends StatefulWidget {
  const TabletScreen({
    Key? key, 
    required this.controller, 
    required this.pixels,
    required this.duration,
  }) : super(key: key);

  final ScrollController controller;
  final double pixels;
  final int duration;

  @override
  State<TabletScreen> createState() => _TabletScreenState();
}

class _TabletScreenState extends State<TabletScreen> {
  List<int> resolutions = [
    600, 700, 800, 900, 1000,
  ];
  List<int> pages = [
    1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17,
    18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32,
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
        MediaQuery.of(context).size.width < resolution.value + 100) {
          limit = ((resolution.key * 50) + 110) +
          ((page - 2) * ((resolution.key * 50) + 330))
        }
      }
    ).toList();
    return limit;
  }

  Widget ubicationWidget(int page) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.width / 2 * 1.15,
      child: Column(
        children: [
          Expanded(
            flex: 1,
            child: Image.asset(
              "assets/iconnect_page-0007-1.jpg", 
              fit: BoxFit.fill
            ),
          ),
          Expanded(
            flex: 5,
            child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                flex: 5,
                child: mapWidget(),
              ),
              Expanded(
                flex: 4,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Image.asset(
                    "assets/iconnect_page-0007-2.jpg", 
                    fit: BoxFit.fill
                  ),
                )
              ),
            ],
          ),
          ),
          Expanded(
            flex: 1,
            child: Image.asset(
              "assets/iconnect_page-0007-3.jpg", 
              fit: BoxFit.fill
            ),
          ),
        ],
      ),
    );
  }

  Widget mapWidget() {
    return Padding(
      padding: const EdgeInsets.only(left: 40, bottom: 20),
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
      ? "assets/iconnect_page-000$page.jpg"
      : "assets/iconnect_page-00$page.jpg",
      fit: BoxFit.fill
    );
  }
}
