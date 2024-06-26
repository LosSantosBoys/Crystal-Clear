import 'dart:async';
import 'package:crystalclear/core/services/db_service.dart';
import 'package:crystalclear/core/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

import 'pin_detail_page.dart';

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

  Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _loadPins();
  }

Future<void> _loadPins() async {
  List<Map<String, dynamic>> pins = await DatabaseService.getAllTrashReports();
  setState(() {
    _markers = pins.map((pin) {
      return Marker(
        markerId: MarkerId(pin['id'].toString()),
        position: LatLng(
          pin['latitude'] is double ? pin['latitude'] : double.parse(pin['latitude']),
          pin['longitude'] is double ? pin['longitude'] : double.parse(pin['longitude']),
        ),
        infoWindow: InfoWindow(
          title: pin['category'],
          snippet: pin['description'],
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PinDetailPage(pin: pin),
              ),
            );
          },
        ),
      );
    }).toSet();
  });
}



  Future<void> getCurrentLocation(BuildContext context) async {
    PermissionStatus status = await Permission.location.status;

    if (status.isDenied) {
      if (context.mounted) {
        context.showErrorSnackbar("Permissão negada. Por favor, habilite a localização nas configurações do seu dispositivo.");
      }

      await Permission.location.request();
    } else if (status.isPermanentlyDenied) {
      if (context.mounted) {
        context.showErrorSnackbar("Permissão negada permanentemente. Por favor, habilite a localização nas configurações do seu dispositivo.");
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
        markers: _markers,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }
}