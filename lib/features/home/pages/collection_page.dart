// ignore_for_file: prefer_const_constructors
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:crystalclear/features/home/widgets/collection_grid.dart';
import 'package:crystalclear/core/widgets/section_widget.dart';
import 'package:intl/intl.dart';
import '../../../core/services/db_service.dart';
import 'collection_details_page.dart';

class CollectionsPage extends StatelessWidget {
  const CollectionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Suas coletas"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Wrap(
          runSpacing: 15,
          children: [
            const Section(
              headerTitle: "Suas coletas",
              child: CollectionGrid(),
            ),
            Section(
              headerTitle: "Coletas ativas",
              child: FutureBuilder(
                future: DatabaseService.getActiveTrashCollect(1), //TODO - ID USUARIO LOGADO
                builder: (context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Erro: ${snapshot.error}');
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Text('Nenhuma coleta ativa encontrada.');
                  } else {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      padding: EdgeInsets.zero,
                      itemBuilder: (context, index) {
                        final item = snapshot.data![index];
                        return _buildListItem(context, item, true);
                      },
                    );
                  }
                },
              ),
            ),
            Section(
              headerTitle: "Últimas coletas realizadas",
              child: FutureBuilder(
                future: DatabaseService.getAllDoneTrashCollect(1), //TODO - ID USUARIO LOGADO
                builder: (context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Erro: ${snapshot.error}');
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Text('Nenhuma coleta encontrada.');
                  } else {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      padding: EdgeInsets.zero,
                      itemBuilder: (context, index) {
                        final item = snapshot.data![index];
                        return _buildListItem(context, item, false);
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListItem(BuildContext context, Map<String, dynamic> item, bool isActive) {
    final itemName = item['item'] ?? 'Nome não disponível';
    final itemAddress = item['address'] ?? 'Endereço não disponível';
    final createdAt = DateTime.parse(item['created_at']);
    final formattedDate = DateFormat('HH:mm - EEEE, dd.MM.yy').format(createdAt);
    final imagePath = File(item['image_path']);

    return Column(
      children: [
        ListTile(
          contentPadding: EdgeInsets.zero,
          leading: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                constraints: const BoxConstraints(
                  minWidth: 44,
                  minHeight: 44,
                  maxWidth: 55,
                  maxHeight: 55,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  image: DecorationImage(
                    image: FileImage(imagePath),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
          title: Text(
            itemName,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                formattedDate,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                itemAddress,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          isThreeLine: false,
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.arrow_forward_ios),
            ],
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => isActive ? CollectDetailPage(collect: item) : CollectDetailPage(collect: item),
              ),
            );
          },
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
