import 'dart:io';
import 'package:christiandimene/common_widgets/custom_appbar.dart';
import 'package:christiandimene/features/certification/model/pdf_model_response.dart';
import 'package:christiandimene/helpers/navigation_service.dart';
import 'package:christiandimene/networks/endpoints.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class PdfViewerScreen extends StatefulWidget {
  FileElement? data;

  PdfViewerScreen({required this.data, super.key});
  @override
  _PdfViewerScreenState createState() => _PdfViewerScreenState();
}

class _PdfViewerScreenState extends State<PdfViewerScreen> {
  String? localPath;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    downloadPdf(baseUrl + widget.data!.filePath.toString());
  }

  Future<void> downloadPdf(String url) async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final directory = await getApplicationDocumentsDirectory();
        final filePath =
            '${directory.path}/${Uri.parse(url).pathSegments.last}';
        final file = File(filePath);
        await file.writeAsBytes(response.bodyBytes);

        if (await file.exists()) {
          print('File downloaded to: $filePath');
          setState(() {
            localPath = filePath;
            loading = false;
          });
        } else {
          print('File does not exist');
        }
      } else {
        print('Failed to download PDF. Status Code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error downloading PDF: $e');
      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        title: "Document File",
        onCallBack: () {
          NavigationService.goBack;
        },
      ),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : localPath != null
              ? PDFView(
                  filePath: localPath!,
                  enableSwipe: true,
                  swipeHorizontal: false,
                  autoSpacing: true,
                  pageFling: true,
                  onError: (error) {
                    print('PDFView error: $error');
                  },
                  onRender: (pages) {
                    print('PDF rendered with $pages pages');
                  },
                )
              : Center(child: Text('Failed to load PDF')),
    );
  }
}
