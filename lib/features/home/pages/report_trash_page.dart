import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import '../../../core/services/db_service.dart';

class ReportTrashPage extends StatefulWidget {
  @override
  _ReportTrashPageState createState() => _ReportTrashPageState();
}

class _ReportTrashPageState extends State<ReportTrashPage> {
  File? _image;
  final picker = ImagePicker();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _itemController = TextEditingController();
  String? _selectedCategory;
  LocationData? _locationData;

  @override
  void initState() {
    super.initState();
    _getLocation();
  }

Future<void> _getLocation() async {
  var location = Location();
  bool _serviceEnabled;
  PermissionStatus _permissionGranted;
  LocationData? _locationData;

  _serviceEnabled = await location.serviceEnabled();
  if (!_serviceEnabled) {
    _serviceEnabled = await location.requestService();
    if (!_serviceEnabled) {
      return;
    }
  }

  _permissionGranted = await location.hasPermission();
  if (_permissionGranted == PermissionStatus.denied) {
    _permissionGranted = await location.requestPermission();
    if (_permissionGranted != PermissionStatus.granted) {
      return;
    }
  }

  _locationData = await location.getLocation();
  setState(() {
    this._locationData = _locationData;
  });
}

  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future<void> _saveReport(BuildContext context) async {
    int userId = 1; // TODO - Arrumar pra usuario logado
    String description = _descriptionController.text;
    String category = _selectedCategory ?? '';
    String imagePath = _image?.path ?? '';
    String location = _locationData != null
        ? '(${_locationData!.latitude}, ${_locationData!.longitude})'
        : '';
    int quantity = int.tryParse(_quantityController.text) ?? 0;
    String item = _itemController.text;

    await DatabaseService.insertTrashReport(
      userId,
      description,
      category,
      imagePath,
      location,
      quantity,
      item,
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sinalizar'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            GestureDetector(
              onTap: getImage,
              child: Container(
                width: double.infinity,
                height: 200,
                color: Colors.grey[300],
                child: _image == null
                    ? const Icon(Icons.camera_alt, size: 100)
                    : Image.file(_image!, fit: BoxFit.cover),
              ),
            ),
            const SizedBox(height: 16),
            const Text("Item", style: TextStyle(fontWeight: FontWeight.bold)),
            TextField(
              controller: _itemController,
              decoration: const InputDecoration(
                hintText: "Item",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            const Text("Quantidade", style: TextStyle(fontWeight: FontWeight.bold)),
            TextField(
              controller: _quantityController,
              decoration: const InputDecoration(
                hintText: "Quantidade",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            const Text("Categoria", style: TextStyle(fontWeight: FontWeight.bold)),
            DropdownButtonFormField<String>(
              value: _selectedCategory,
              items: ["Plástico", "Metal", "Vidro", "Orgânico"]
                  .map((category) => DropdownMenuItem<String>(
                        child: Text(category),
                        value: category,
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _selectedCategory = value;
                });
              },
              decoration: const InputDecoration(
                hintText: "Categoria",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            const Text("Descrição", style: TextStyle(fontWeight: FontWeight.bold)),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                hintText: "Descrição",
                border: OutlineInputBorder(),
              ),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () => _saveReport(context),
              child: const Center(child: Text("Enviar")),
            ),
          ],
        ),
      ),
    );
  }
}
