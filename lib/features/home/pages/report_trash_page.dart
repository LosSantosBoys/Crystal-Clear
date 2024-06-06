import 'dart:io';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../core/services/db_service.dart';
import '../../../core/widgets/custom_button.dart';

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
  Position? _currentPosition;

  @override
  void initState() {
    super.initState();
  }

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
    setState(() {
      _currentPosition = position;
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
    String location = _currentPosition != null
        ? '(${_currentPosition!.latitude}, ${_currentPosition!.longitude})'
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
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: CustomButton(
          text: "Enviar",
          onPressed: () {
            getCurrentLocation(context).then((_) {
              _saveReport(context);
            });
          },
        ),
      ),
      body: SingleChildScrollView(
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
          ],
        ),
      ),
    );
  }
}
