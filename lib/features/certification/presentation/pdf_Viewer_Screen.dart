import 'dart:io';
import 'package:christiandimene/gen/colors.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class PdfViewerScreen extends StatefulWidget {
  @override
  _PdfViewerScreenState createState() => _PdfViewerScreenState();
}

class _PdfViewerScreenState extends State<PdfViewerScreen> {
  String? localPath;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    downloadPdf(
        'https://christiandimene.reigeeky.com/uploads/course_files/5gbejdsjjkbayzfnlilj-6038e4ae-9b52-4885-a93b-40273a20d98dpdf.pdf');
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
      appBar: AppBar(
        title: Text('PDF File'),
        backgroundColor: AppColors.allPrimaryColor,
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
