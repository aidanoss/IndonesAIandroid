import 'package:flutter/material.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';

class AnalisisScreen extends StatefulWidget {
  const AnalisisScreen({super.key});

  @override
  _AnalisisScreenState createState() => _AnalisisScreenState();
}

class _AnalisisScreenState extends State<AnalisisScreen> {
  File? _selectedFile;
  String? _fileName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Analisis'),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Upload a file or image for analysis',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            _buildUploadCard(
              context,
              icon: Icons.upload_file,
              title: 'Upload File',
              subtitle: 'PDF, DOC, TXT',
              onTap: _pickFile,
            ),
            const SizedBox(height: 16),
            _buildUploadCard(
              context,
              icon: Icons.image,
              title: 'Upload Image',
              subtitle: 'JPG, PNG, GIF',
              onTap: _pickImage,
            ),
            const SizedBox(height: 20),
            if (_fileName != null)
              Text('Selected: $_fileName',
                  style: const TextStyle(fontStyle: FontStyle.italic)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _selectedFile != null ? _analyzeFile : null,
              child: const Text('Analyze'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUploadCard(BuildContext context,
      {required IconData icon,
      required String title,
      required String subtitle,
      required VoidCallback onTap}) {
    return Card(
      elevation: 2,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Icon(icon, size: 48, color: Theme.of(context).primaryColor),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    Text(subtitle,
                        style: TextStyle(
                            color:
                                Theme.of(context).textTheme.bodySmall?.color)),
                  ],
                ),
              ),
              Icon(Icons.arrow_forward_ios,
                  color: Theme.of(context).primaryColor),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx', 'txt'],
    );

    if (result != null) {
      setState(() {
        _selectedFile = File(result.files.single.path!);
        _fileName = result.files.single.name;
      });
    }
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _selectedFile = File(image.path);
        _fileName = image.name;
      });
    }
  }

  void _analyzeFile() {
    // TODO: Implement file analysis
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Analyzing $_fileName...')),
    );
  }
}
