import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';


class pdfScreen extends StatefulWidget {
  const pdfScreen({Key? key}) : super(key: key);

  @override
  State<pdfScreen> createState() => _pdfScreenState();
}

class _pdfScreenState extends State<pdfScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            child: SfPdfViewer.network(
                'https://cdn.syncfusion.com/content/PDFViewer/flutter-succinctly.pdf')));
  }
}
