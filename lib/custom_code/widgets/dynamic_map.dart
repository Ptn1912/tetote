// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/actions/actions.dart' as action_blocks;
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:latlong2/latlong.dart' as ll;
import 'package:flutter_map/flutter_map.dart';

class DynamicMap extends StatefulWidget {
  const DynamicMap({
    Key? key,
    this.width,
    this.height,
    this.points,
    required this.accessToken,
    required this.startingPoint,
    required this.startingZoom,
  }) : super(key: key);

  final double? width;
  final double? height;
  final List<LatLng>? points;
  final String accessToken;
  final LatLng startingPoint;
  final double startingZoom;

  @override
  State<DynamicMap> createState() => _DynamicMapState();
}

class _DynamicMapState extends State<DynamicMap> {
  late MapController _mapController;

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
  }

  List<Marker> addMarkersToMap(List<LatLng>? points) {
    List<Marker> allMarkers = [];
    if (points != null) {
      for (LatLng point in points) {
        allMarkers.add(
          Marker(
            point: ll.LatLng(point.latitude, point.longitude),
            height: 12,
            width: 12,
            child: Transform.translate(
              offset: Offset(0, -12),
              child: Icon(
                Icons.place,
                color: Colors.red,
              ),
            ),
          ),
        );
      }
    }
    return allMarkers;
  }

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      mapController: _mapController,
      options: MapOptions(
        center: ll.LatLng(
            widget.startingPoint.latitude, widget.startingPoint.longitude),
        zoom: widget.startingZoom,
      ),
      children: [
        TileLayer(
          urlTemplate:
              'https://api.mapbox.com/styles/v1/khanh123/clvxw1s4600tg01pf5awmfzbd/tiles/256/{z}/{x}/{y}@2x?access_token=${widget.accessToken}',
        ),
        MarkerLayer(
          markers: addMarkersToMap(widget.points),
        ),
      ],
    );
  }
}
