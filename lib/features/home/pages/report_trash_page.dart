import 'dart:io';
import 'package:crystalclear/core/services/db_service.dart';
import 'package:crystalclear/core/utils/utils.dart';
import 'package:crystalclear/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class ReportTrashPage extends StatefulWidget {
  const ReportTrashPage({super.key});

  @override
  State<ReportTrashPage> createState() => _ReportTrashPageState();
}

class _ReportTrashPageState extends State<ReportTrashPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  File? _image;
  final picker = ImagePicker();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _itemController = TextEditingController();
  String? _selectedCategory;
  List<String> categories = ["Plástico", "Metal", "Vidro", "Orgânico", "Outro"];

  @override
  void initState() {
    super.initState();
  }

  Future<Position?> getCurrentLocation(BuildContext context) async {
    PermissionStatus status = await Permission.location.status;

    if (status.isDenied) {
      if (context.mounted) {
        context.showErrorSnackbar('Permissão negada.');
      }

      return null;
    } else if (status.isPermanentlyDenied) {
      if (context.mounted) {
        context.showErrorSnackbar('Permissão negada permanentemente.');
      }

      return null;
    }

    return await Geolocator.getCurrentPosition();
  }

  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  Future<void> _saveReport(BuildContext context) async {
    final Position? currentPosition = await getCurrentLocation(context);

    if (currentPosition == null) {
      return;
    }

    int userId = 1; // TODO - Arrumar pra usuario logado
    String description = _descriptionController.text;
    String category = _selectedCategory ?? '';
    String imagePath = _image?.path ?? '';
    String? latitude = currentPosition.latitude.toString();
    String? longitude = currentPosition.longitude.toString();
    int quantity = int.tryParse(_quantityController.text) ?? 0;
    String item = _itemController.text;

    await DatabaseService.insertTrashReport(
      userId,
      description,
      category,
      imagePath,
      latitude,
      longitude,
      quantity,
      item,
    );

    if (context.mounted) {
      Navigator.pop(context);
      context.showSuccessSnackbar("Sinalização enviada com sucesso.");
    }
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
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              await _saveReport(context);
            }
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
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: _image == null
                      ? const Icon(
                          Icons.camera_alt,
                          size: 100,
                          color: Colors.white,
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.file(
                            _image!,
                            fit: BoxFit.cover,
                          ),
                        )),
            ),
            const SizedBox(height: 16),
            Form(
              key: _formKey,
              child: Wrap(
                runSpacing: 5,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Wrap(
                      runSpacing: 10,
                      children: [
                        const Text(
                          "Item",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: _itemController,
                          textCapitalization: TextCapitalization.sentences,
                          decoration: const InputDecoration(
                            hintText: 'Item',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor, insira o nome do item.';
                            }

                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Wrap(
                      runSpacing: 10,
                      children: [
                        const Text(
                          "Descrição",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: _descriptionController,
                          maxLines: null,
                          textCapitalization: TextCapitalization.sentences,
                          decoration: const InputDecoration(
                            hintText: 'Descrição',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor, insira a descrição.';
                            }

                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Wrap(
                      runSpacing: 10,
                      children: [
                        const Text(
                          "Quantidade",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: _quantityController,
                          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            hintText: 'Quantidade',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor, insira a quantidade.';
                            }

                            if (value == '0') {
                              return 'A quantidade não pode ser 0.';
                            }

                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Wrap(
                      runSpacing: 10,
                      children: [
                        const Text(
                          "Categoria",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 10),
                        DropdownButtonFormField<String>(
                          value: _selectedCategory,
                          items: categories
                              .map((category) => DropdownMenuItem<String>(
                                    value: category,
                                    child: Text(category),
                                  ))
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              _selectedCategory = value;
                            });
                          },
                          decoration: const InputDecoration(
                            hintText: "Categoria",
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor, selecione a categoria.';
                            }

                            return null;
                          },
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
