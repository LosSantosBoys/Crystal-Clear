import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SampleMap extends StatefulWidget {
  const SampleMap({super.key});

  @override
  State<SampleMap> createState() => _SampleMapState();
}

class _SampleMapState extends State<SampleMap> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return GoogleMap(
      mapType: MapType.normal,
      initialCameraPosition: const CameraPosition(
        target: LatLng(-23.5505, -46.6333),
        zoom: 11,
      ),
      zoomGesturesEnabled: false,
      zoomControlsEnabled: false,
      onTap: (_) => Navigator.pushNamed(context, '/map'),
    );
  }
}
