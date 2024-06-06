import 'dart:io';
import 'package:crystalclear/core/services/db_service.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../../core/widgets/custom_button.dart';

class CollectDetailPage extends StatefulWidget {
  final Map<String, dynamic> collect;

  const CollectDetailPage({Key? key, required this.collect}) : super(key: key);

  @override
  _CollectDetailPageState createState() => _CollectDetailPageState();
}

class _CollectDetailPageState extends State<CollectDetailPage> {
  File? _image;
  final picker = ImagePicker();
  int? points;

  String _calculateTimeRemaining(String creationDate) {
    DateTime createdAt = DateTime.parse(creationDate);
    DateTime expirationDate = createdAt.add(Duration(hours: 24));
    Duration remainingTime = expirationDate.difference(DateTime.now());

    if (remainingTime.inHours > 0) {
      return 'Tempo restante: ${remainingTime.inHours} horas';
    } else {
      return 'Tempo restante: ${remainingTime.inMinutes} minutos';
    }
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

  Future<void> _finalizeCollection(BuildContext context) async {
      String imagePath = _image?.path ?? '';
      int idReport = widget.collect['id_report'];
      int id = widget.collect['id'];
      int idAssignee = widget.collect['id_assignee'];

      await DatabaseService.markTrashCollectionAsDone(idReport, id, imagePath);
      await DatabaseService.updateUserPoints(idAssignee, points!);

      Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
    _fetchPoints();
  }

  Future<void> _fetchPoints() async {
    try {
      Map<String, dynamic> report = await DatabaseService.getTrashReportById(widget.collect['id_report']);
      setState(() {
        points = report['points'];
      });
    } catch (e) {
      print('Error fetching points: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.collect['item'] ?? 'Item Desconhecido'),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: CustomButton(
          text: "Finalizar coleta",
          onPressed: () => _finalizeCollection(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
            Text(
              widget.collect['item'] ?? 'Item Desconhecido',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            FutureBuilder<Map<String, dynamic>>(
              future: DatabaseService.getTrashReportById(widget.collect['id_report']),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }
                if (snapshot.hasError) {
                  return const Text('Erro ao carregar categoria e descrição');
                }
                if (!snapshot.hasData) {
                  return const Text('Categoria e descrição não disponíveis');
                }
                points = snapshot.data!['points'];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Categoria e Descrição", style: TextStyle(fontWeight: FontWeight.bold)),
                    Text('${snapshot.data!['category'] ?? 'Categoria desconhecida'} - ${snapshot.data!['description'] ?? 'Descrição desconhecida'}'),
                  ],
                );
              },
            ),
            const SizedBox(height: 16),
            const Text("Endereço", style: TextStyle(fontWeight: FontWeight.bold)),
            Text(
              widget.collect['address'] ?? 'Endereço não disponível',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            const Text("Tempo restante", style: TextStyle(fontWeight: FontWeight.bold)),
            Text(
              _calculateTimeRemaining(widget.collect['created_at'] ?? DateTime.now().toIso8601String()),
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
