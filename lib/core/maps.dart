// ignore: avoid_web_libraries_in_flutter
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:google_maps/google_maps.dart';
import 'dart:ui' as ui;

import 'package:iconnect/core/constants.dart';

class GoogleMap extends StatelessWidget {
  const GoogleMap({super.key});

  @override
  Widget build(BuildContext context) {
    String htmlId = "7";

    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(htmlId, (int viewId) {
      final ubication = LatLng(latitudeMap, longitudeMap);

      final mapOptions = MapOptions()
        ..zoom = zoomMap
        ..center = LatLng(latitudeMap, longitudeMap);

      final elem = DivElement()
        ..id = htmlId
        ..style.width = "100%"
        ..style.height = "100%"
        ..style.border = "none";

      final map = GMap(elem, mapOptions);

      Marker(
        MarkerOptions()
          ..position = ubication
          ..map = map,
      );
      return elem;
    });

    return HtmlElementView(viewType: htmlId);
  }
}
