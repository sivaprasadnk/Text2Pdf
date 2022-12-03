library text2pdf;

import 'dart:io';

import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class Text2Pdf {
  /// Function to generate pdf file from a given String data, and opens the File after generation.
  ///
  /// [content] parameter cannot be null. It sets tha pdf content.
  ///
  /// [outputFilePath] paramater is optional. Sets the path of generated Pdf File.
  ///
  /// [pageMargin] paramater is optional. Sets the margin around pdf file. Defaults to 20

  static Future<void> generatePdf(
    String content, {
    String? outputFilePath,
    double? pageMargin,
  }) async {
    final pdf = pw.Document();
    final font = await PdfGoogleFonts.openSansRegular();
    var myTheme = pw.ThemeData.withFont(
      base: font,
    );
    pdf.addPage(
      pw.Page(
        theme: myTheme,
        margin: pw.EdgeInsets.all(pageMargin ?? 20),
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Text(content);
        },
      ),
    ); //
    final output = await getTemporaryDirectory();
    var path = outputFilePath ?? "${output.path}/output.pdf";
    final file = File(path);
    await file.writeAsBytes(await pdf.save()).then((value) {
      OpenFilex.open(value.path);
    });
  }
}
