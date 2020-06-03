import 'package:flutter/material.dart';
import 'package:osm_traccar/pages/camera_page.dart';

Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder> {
    'camera' : ( BuildContext context ) => CameraPage(),
  };
}
