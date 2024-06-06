import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final Completer<GoogleMapController> _controller = Completer();
  static const CameraPosition initialCameraPosition = CameraPosition(
    target: LatLng(-23.5505, -46.6333),
    zoom: 11,
  );

  Future<void> getCurrentLocation(BuildContext context) async {
    PermissionStatus status = await Permission.location.status;

    if (status.isDenied) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Row(
              children: [
                Icon(
                  Icons.error_outline,
                  color: Colors.red,
                ),
                SizedBox(width: 10),
                Text("Permissão negada."),
              ],
            ),
          ),
        );
      }
    } else if (status.isPermanentlyDenied) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Row(
              children: [
                Icon(
                  Icons.error_outline,
                  color: Colors.red,
                ),
                SizedBox(width: 10),
                Text("Permissão negada permanentemente."),
              ],
            ),
          ),
        );
      }
    }

    final Position position = await Geolocator.getCurrentPosition();
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(position.latitude, position.longitude),
          zoom: 15,
        ),
      ),
    );
  }

  void openSearchSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      enableDrag: true,
      isDismissible: true,
      builder: (BuildContext context) {
        return const SizedBox(
          height: 200,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  "Pesquisar",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Pesquisar",
                    prefixIcon: Icon(Icons.search),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        titleSpacing: 24,
        automaticallyImplyLeading: false,
        shadowColor: Colors.transparent,
        foregroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        toolbarHeight: 80,
        title: FloatingActionButton(
          onPressed: () => Navigator.pop(context),
          heroTag: null,
          backgroundColor: Colors.white,
          child: const Icon(
            Icons.arrow_back,
            size: 28,
          ),
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {},
            heroTag: null,
            backgroundColor: Colors.white,
            child: const Icon(
              Icons.filter_alt_outlined,
              size: 28,
            ),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            onPressed: () => openSearchSheet(context),
            heroTag: null,
            backgroundColor: Colors.white,
            child: const Icon(
              Icons.search_outlined,
              size: 28,
            ),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            onPressed: () async => getCurrentLocation(context),
            heroTag: null,
            backgroundColor: Colors.white,
            child: const Icon(
              Icons.my_location,
              color: Color(0xFFE70404),
              size: 28,
            ),
          ),
        ],
      ),
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: initialCameraPosition,
        myLocationEnabled: true,
        zoomControlsEnabled: false,
        mapToolbarEnabled: true,
        myLocationButtonEnabled: false,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }
}
