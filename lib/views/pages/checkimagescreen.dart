import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';

import 'package:hive/hive.dart';

class CheckImageScreen extends StatefulWidget {
  @override
  _CheckImageScreenState createState() => _CheckImageScreenState();
}

class _CheckImageScreenState extends State<CheckImageScreen> {
  //var userData;

  Box<String> feedsBox;
  @override
  void initState() {
    super.initState();
    // SystemChrome.setEnabledSystemUIOverlays([]);

    feedsBox = Hive.box('feedsApp');
  }

  @override
  void dispose() {
    //SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0.0,
        leading: IconButton(
            icon: Icon(
              Icons.cancel,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      backgroundColor: Colors.transparent,
      body: Center(
        child: CachedNetworkImage(
          imageUrl: feedsBox.get('Image7'),
          imageBuilder: (context, imageProvider) => Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 2,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
            ),
          ),
          placeholder: (context, url) => CircularProgressIndicator(
            strokeWidth: 1.5,
            backgroundColor: Color(0xff01A0C7),
          ),
          errorWidget: (context, url, error) => CircularProgressIndicator(
            strokeWidth: 1.5,
            backgroundColor: Color(0xff01A0C7),
          ),
        ),
      ),
    );
  }
}

// class PdfScreen extends StatefulWidget {
//   final String fileUrl;
//   PdfScreen(this.fileUrl);
//   @override
//   _PdfScreenState createState() => _PdfScreenState();
// }

// class _PdfScreenState extends State<PdfScreen> {
//   String pathPDF = " ";
//   @override
//   void initState() {
//     super.initState();
//     createFileOfPdfUrl(
//             'https://empl-dev.site/files/images/workgroup_images/e8c0653fea13f91bf3c48159f7c24f78_0038f6b2b1d8f061e8df5115f9c618ac0.pdf')
//         .then((f) {
//       setState(() {
//         pathPDF = f.path;
//       });
//     });
//     print('pdfurl: ${widget.fileUrl}');
//   }

//   Future<File> createFileOfPdfUrl(String fileUrl) async {
//     final url = fileUrl;
//     final filename = url.substring(url.lastIndexOf("/") + 1);
//     var request = await HttpClient().getUrl(Uri.parse(url));
//     var response = await request.close();
//     var bytes = await consolidateHttpClientResponseBytes(response);
//     String dir = (await getApplicationDocumentsDirectory()).path;
//     File file = File('$dir/$filename');
//     await file.writeAsBytes(bytes);
//     print('PATHPDF: ${file.path}');
//     return file;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return PDFViewerScaffold(
//         appBar: AppBar(
//           title: Text("Pdf Document"),
//           actions: [IconButton(icon: Icon(Icons.share), onPressed: () {})],
//         ),
//         path: pathPDF);
//   }
// }
