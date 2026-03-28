import 'dart:io';

import 'package:flutter/material.dart';

import 'package:printing/printing.dart';
//import 'package:share_plus/share_plus.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../../../../core/app_colors.dart';

class ShowPdf extends StatefulWidget {
  const ShowPdf({super.key, required this.file, required this.uri});
  final File file;
  final String uri;

  @override
  State<ShowPdf> createState() => _ShowPdfState();
}

class _ShowPdfState extends State<ShowPdf> {
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();
  @override
  void initState() {
    Printing.layoutPdf(onLayout: (_) => widget.file.readAsBytesSync());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Show pdf'),
        actions: [
          IconButton(
            onPressed: () async {
              await Printing.layoutPdf(
                onLayout: (_) => widget.file.readAsBytesSync(),
              );
            },
            icon: const Icon(Icons.print, color: AppColors.white),
          ),
          // IconButton(
          //     onPressed: () async {
          //       // await Share.shareXFiles(
          //       //   [XFile(widget.file.path)],
          //       // );
          //     },
          //     icon: const Icon(
          //       Icons.share,
          //       color: AppColors.primer,
          //     ))
        ],
      ),
      body: SfPdfViewer.file(widget.file, key: _pdfViewerKey),
    );
  }
}
