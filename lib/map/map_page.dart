import 'package:flutter/material.dart';
import 'package:maplibre_gl/maplibre_gl.dart';

/// TEMPORARY MapTiler demo key (works for testing)
const _maptilerApiKey = 'get_your_own_key';

/// You can change styles: streets-v2, outdoor-v2, satellite, etc.
const _styleUrl = 'https://api.maptiler.com/maps/streets-v2/style.json';

class MapPage extends StatelessWidget {
  const MapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Map View')),
      body: const _MapView(),
    );
  }
}

class _MapView extends StatefulWidget {
  const _MapView({super.key});
  @override
  State<_MapView> createState() => _MapViewState();
}

class _MapViewState extends State<_MapView> {
  MaplibreMapController? controller;

  @override
  Widget build(BuildContext context) {
    return MaplibreMap(
      styleString: '$_styleUrl?key=$_maptilerApiKey',
      myLocationEnabled: true,
      trackCameraPosition: true,
      initialCameraPosition: const CameraPosition(
        // Durban example
        target: LatLng(-29.8587, 31.0218),
        zoom: 11,
      ),
      onMapCreated: (ctrl) => controller = ctrl,
    );
  }
}
 
