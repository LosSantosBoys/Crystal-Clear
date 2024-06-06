import 'dart:io';
import 'package:crystalclear/core/services/db_service.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';

class PinDetailPage extends StatelessWidget {
  final Map<String, dynamic> pin;

  const PinDetailPage({Key? key, required this.pin}) : super(key: key);

  Future<void> _acceptCollection(BuildContext context) async {
    await DatabaseService.updateTrashReportAssignee(pin['id'], 1);

    final String address = await getAddress(pin['latitude'] is double ? pin['latitude'] : double.parse(pin['latitude']),
          pin['longitude'] is double ? pin['longitude'] : double.parse(pin['longitude']),);
    String addressPart = address;

    await DatabaseService.insertTrashCollect(
      pin['id'],
      1,
      DateTime.now().toIso8601String(),
      0,
      addressPart,
    );

    Navigator.pop(context);
  }

  Future<String> getAddress(double latitude, double longitude) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude);
    Placemark place = placemarks.first;
  
    String locality = place.locality ?? '';
    String subLocality = place.subLocality ?? '';
    String thoroughfare = place.thoroughfare ?? '';

    List<String> parts = [];

    if (locality.isNotEmpty) parts.add(locality);
    if (subLocality.isNotEmpty) parts.add(subLocality);
    if (thoroughfare.isNotEmpty) parts.add(thoroughfare);

    return parts.join(', ');  
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(pin['category']),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () => _acceptCollection(context),
          child: const Text('Aceitar coleta'),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (pin['image_path'] != null && pin['image_path'].isNotEmpty)
              Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    image: FileImage(File(pin['image_path'])),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            const SizedBox(height: 16),
            const Text("Item", style: TextStyle(fontWeight: FontWeight.bold)),
            TextField(
              enabled: false,
              decoration: InputDecoration(
                hintText: pin['item'],
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            const Text("Categoria", style: TextStyle(fontWeight: FontWeight.bold)),
            TextField(
              enabled: false,
              decoration: InputDecoration(
                hintText: pin['category'],
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            const Text("Descrição", style: TextStyle(fontWeight: FontWeight.bold)),
            TextField(
              enabled: false,
              decoration: InputDecoration(
                hintText: pin['description'],
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            const Text("Quantidade", style: TextStyle(fontWeight: FontWeight.bold)),
            TextField(
              enabled: false,
              decoration: InputDecoration(
                hintText: pin['quantity'].toString(),
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            const Text("Pontos", style: TextStyle(fontWeight: FontWeight.bold)),
            TextField(
              enabled: false,
              decoration: InputDecoration(
                hintText: pin['points'].toString(),
                border: const OutlineInputBorder(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}