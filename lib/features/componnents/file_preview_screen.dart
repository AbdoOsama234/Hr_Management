import 'dart:io';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'custom_app_bar.dart';
import 'loading_widget.dart';

class FilePreviewScreen extends StatelessWidget {
  final File file;
  final String title;

  const FilePreviewScreen({
    super.key,
    required this.file,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final String extension = file.path.split('.').last.toLowerCase();
    final bool isImage = ['jpg', 'jpeg', 'png', 'gif', 'webp'].contains(extension);
    final bool isPdf = extension == 'pdf';

    return Scaffold(
      appBar: CustomAppBar(title: title),
      body: _buildBody(isImage, isPdf),
    );
  }

  Widget _buildBody(bool isImage, bool isPdf) {
    if (isImage) {
      return PhotoView(
        imageProvider: FileImage(file),
        backgroundDecoration: const BoxDecoration(color: Colors.transparent),
        loadingBuilder: (context, event) => const Center(child: LoaderWidget()),
      );
    } else if (isPdf) {
      return SfPdfViewer.file(file);
    } else {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.insert_drive_file_outlined, size: 64, color: Colors.grey),
            const SizedBox(height: 16),
            Text(
              'Unsupported file type: .${file.path.split('.').last}',
              style: const TextStyle(color: Colors.grey),
            ),
          ],
        ),
      );
    }
  }
}
