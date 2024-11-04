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
  late String
      selectedTipo; 
  final DatabaseHelper _dbHelper =
      DatabaseHelper(); 

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Stack(
        children: [
          const AppBackground(
            child: SizedBox.expand(),
          ),
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
                          onTap: () => _openFilePickerModal(context, 'sapien'),
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
        selectedFile = File(
            imagemExistente['imagePath']); 
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
              contentPadding: const EdgeInsets.all(20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              content: SizedBox(
                width: double.maxFinite,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (selectedFile != null)
                      Image.file(
                        selectedFile!,
                        height: 150,
                        fit: BoxFit.cover,
                      )
                    else
                      const Text("Nenhuma imagem selecionada"),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () async {
                        FilePickerResult? result =
                            await FilePicker.platform.pickFiles(
                          type: FileType.image,
                        );
                        if (result != null) {
                          setState(() {
                            selectedFile = File(result.files.single.path!);
                            selectedFileName = result.files.single.name;
                          });
                        }
                      },
                      child: const Text(
                        "Selecionar Arquivo",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (selectedFile != null)
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                            ),
                            onPressed: () async {
                              await _dbHelper
                                  .deletarImagemPorTipo(selectedTipo);
                              setState(() {
                                selectedFile = null; 
                              });
                            },
                            child: const Text(
                              "Deletar",
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
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
                          child: const Text(
                            "Salvar",
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
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

  GridButton({
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
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
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
