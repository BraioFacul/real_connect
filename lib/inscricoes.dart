import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'components/app_background.dart';
import 'components/custom_app_bar.dart';
import 'package:real_connect/helpers/sql_helper.dart';

var boxShadow = BoxShadow(
  color: Colors.black.withOpacity(0.24),
  spreadRadius: 0,
  blurRadius: 8,
  offset: Offset(0, 3),
);

double iconSize = 32;
Color cardColor = Colors.white;

class InscricoesPage extends StatefulWidget {
  const InscricoesPage({super.key});

  @override
  State<InscricoesPage> createState() => _InscricoesPageState();
}

class _InscricoesPageState extends State<InscricoesPage> {
  String? selectedFileName;
  File? selectedFile;
  late String selectedTipo;
  final DatabaseHelper _dbHelper = DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Stack(
        children: [
          const AppBackground(child: SizedBox.expand()),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: CustomAppBar(),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const SizedBox(height: 40),
                  Expanded(
                    child: ListView(
                      children: [
                        GridButton(
                          icon: Icons.school,
                          label: "Palestras",
                          onTap: () =>
                              _openFilePickerModal(context, 'palestras'),
                        ),
                        const SizedBox(height: 16),
                        GridButton(
                          icon: Icons.science_outlined,
                          label: "Iniciação Científica",
                          onTap: () => _openFilePickerModal(
                              context, 'iniciacao_cientifica'),
                        ),
                        const SizedBox(height: 16),
                        GridButton(
                          icon: Icons.article,
                          label: "Editais",
                          onTap: () => _openFilePickerModal(context, 'editais'),
                        ),
                        const SizedBox(height: 16),
                        GridButton(
                          icon: Icons.lightbulb_outline,
                          label: "Sapien",
                          onTap: () => _openFilePickerModal(context, 'sapien'),
                        ),
                        const SizedBox(height: 16),
                        GridButton(
                          icon: Icons.extension,
                          label: "Projeto Extensão",
                          onTap: () =>
                              _openFilePickerModal(context, 'projeto_extensao'),
                        ),
                        const SizedBox(height: 16),
                        GridButton(
                          icon: Icons.monitor,
                          label: "Monitoria",
                          onTap: () =>
                              _openFilePickerModal(context, 'monitoria'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _openFilePickerModal(BuildContext context, String tipo) async {
    setState(() {
      selectedTipo = tipo;
    });

    Map<String, dynamic>? imagemExistente =
        await _dbHelper.buscarImagemPorTipo(tipo);

    if (imagemExistente != null) {
      setState(() {
        selectedFile = File(imagemExistente['imagePath']);
      });
    } else {
      setState(() {
        selectedFile = null;
      });
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              contentPadding: const EdgeInsets.all(20),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Exibir imagem selecionada ou mensagem
                    if (selectedFile != null)
                      Container(
                        height: 200,
                        width: MediaQuery.of(context).size.width * 0.8,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          image: DecorationImage(
                            image: FileImage(selectedFile!),
                            fit: BoxFit.cover,
                          ),
                        ),
                      )
                    else
                      const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          "Nenhuma imagem selecionada",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                      ),
                    const SizedBox(height: 20),

                    // Botões de ação: Selecionar, Excluir, Salvar
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (selectedFile == null)
                          Expanded(
                            child: ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blueGrey[100],
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 14),
                              ),
                              onPressed: () async {
                                FilePickerResult? result =
                                    await FilePicker.platform.pickFiles(
                                  type: FileType.image,
                                );
                                if (result != null) {
                                  setState(() {
                                    selectedFile =
                                        File(result.files.single.path!);
                                    selectedFileName = result.files.single.name;
                                  });
                                }
                              },
                              icon: const Icon(Icons.upload_file,
                                  color: Colors.black),
                              label: const Text(
                                "Selecionar Arquivo",
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ),
                        if (selectedFile != null) ...[
                          Expanded(
                            child: ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red[300],
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 14),
                              ),
                              onPressed: () async {
                                await _dbHelper
                                    .deletarImagemPorTipo(selectedTipo);
                                setState(() {
                                  selectedFile = null;
                                });
                                Navigator.pop(context);
                              },
                              icon:
                                  const Icon(Icons.delete, color: Colors.white),
                              label: const Text("Excluir",
                                  style: TextStyle(color: Colors.white)),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green[300],
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 14),
                              ),
                              onPressed: () async {
                                if (selectedFile != null) {
                                  await _dbHelper.inserirImagem({
                                    'imagePath': selectedFile!.path,
                                    'tipo': selectedTipo,
                                  });
                                  Navigator.pop(context);
                                }
                              },
                              icon: const Icon(Icons.save, color: Colors.white),
                              label: const Text("Salvar",
                                  style: TextStyle(color: Colors.white)),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class GridButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const GridButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [boxShadow],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Icon(icon, size: iconSize + 4),
            ),
            Expanded(
              child: Text(
                label,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                textAlign: TextAlign.left,
              ),
            ),
            const SizedBox(width: 16),
          ],
        ),
      ),
    );
  }
}
