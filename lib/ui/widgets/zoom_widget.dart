import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';

import '../../core/constants.dart';
import '../../domain/home_controller.dart';

class ZoomWidget extends StatelessWidget {
  const ZoomWidget({Key? key, required this.homeController}) : super(key: key);

  final HomeController homeController;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      id: HomeController.zoomId,
      init: homeController,
      builder: (controller) {
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
                      color: colorBackgroundZoomSmall,
                    ),
                    imageProvider: AssetImage(controller.imageZoom),
                    maxScale: PhotoViewComputedScale.covered * 2.5,
                    minScale: PhotoViewComputedScale.contained,
                    initialScale: PhotoViewComputedScale.covered,
                  ),
                ),
              ),
              InkWell(
                onTap: (() {
                  controller.isShowingZoom = false;
                  controller.imageZoom = "";
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
      },
    );
  }
}
