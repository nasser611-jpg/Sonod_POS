import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;






















class PdfFourColumnExample extends StatefulWidget {

  @override
  State<PdfFourColumnExample> createState() => _PdfFourColumnExampleState();
}

class _PdfFourColumnExampleState extends State<PdfFourColumnExample> {

   late pw.Font ttf ;
@override
  void initState() {
final Uint8List fontData = File('assets/fonts/Cairo-Bold.ttf').readAsBytesSync();
 ttf = pw.Font.ttf(fontData.buffer.asByteData());
    super.initState();
  }

  final List<Map<String, dynamic>> items = [
    {'class': 'Class 1', 'unit': 'Unit 1', 'price': 10.0, 'quantity': 2},
    {'class': 'Class 2', 'unit': 'Unit 2', 'price': 20.0, 'quantity': 3},
    {'class': 'Class 3', 'unit': 'Unit 3', 'price': 15.0, 'quantity': 1},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PDF Four Column Example'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            final pdf = pw.Document();


            // Add page to PDF
            pdf.addPage(
              pw.Page(
                textDirection: pw.TextDirection.rtl,
                pageFormat: PdfPageFormat.roll80,
                build: (pw.Context context) {
                  return pw.Column(
                    children: [
                      _buildHeader(),
                      _buildTable(),
                    ],
                  );
                },
              ),
            );

            // Save PDF
            final output = await getTemporaryDirectory();
            final file = File('${output.path}/four_column_example.pdf');
            await file.writeAsBytes(await pdf.save());

            // Open PDF
            OpenFile.open(file.path);
          },
          child: Text('Generate PDF'),
        ),
      ),
    );
  }

  pw.Widget _buildHeader()
  {

    return pw.Container(
      margin: pw.EdgeInsets.only(bottom: 20),
      child: pw.Column(
        children: [
          pw.SizedBox(height: 10),
          pw.SvgImage(svg:  File('assets/albaik.svg').readAsStringSync() , width: 80 ) , // Add image widget here
          pw.SizedBox(height: 10),
          pw.Text('Date and Time: ${DateTime.now()}'),
          pw.Divider(),
        ],
      ),
    );
  }

  pw.Widget _buildTable() {
    final tableHeaders = ['الصنف', 'الوحدة', 'السعر', 'الكمية'];
    final tableRows = items.map((item) {
      return [
        item['class'],
        item['unit'],
        item['price'].toString(),
        item['quantity'].toString(),
      ];
    }).toList();

    // ignore: deprecated_member_use
    return pw.Table.fromTextArray(
      headers: tableHeaders,
      data: tableRows,
      border: pw.TableBorder.all(),
      headerStyle: pw.TextStyle(fontSize: 12, font: ttf ),
      cellAlignment: pw.Alignment.centerRight,
    );
  }
}
