import 'dart:io';
import 'dart:typed_data';
import 'package:pdf/pdf.dart';
import 'package:flutter/material.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:sonod_point_of_sell/core/util/format_number.dart';
import 'package:sonod_point_of_sell/core/util/formatted_proudct.dart';


// ignore: use_key_in_widget_constructors
class PdfFourColumnExample extends StatefulWidget {
final List<FormattedProduct>formattedproudct;
final double paidAmount;
final double stayedAmount;
final double totalAmount;

  const PdfFourColumnExample({super.key, required this.formattedproudct, required this.paidAmount, required this.stayedAmount, required this.totalAmount});
  @override
  State<PdfFourColumnExample> createState() => _PdfFourColumnExampleState();
}

class _PdfFourColumnExampleState extends State<PdfFourColumnExample> {

   late pw.Font ttf ;
    late pw.Font ttfHeader ;
@override
  void initState() {
final Uint8List fontData = File('assets/fonts/vazirmatn_regular.ttf').readAsBytesSync();
 ttf = pw.Font.ttf(fontData.buffer.asByteData());
 final Uint8List fontDataHeader = File('assets/fonts/vazirmatn_bold.ttf').readAsBytesSync();
 ttfHeader = pw.Font.ttf(fontDataHeader.buffer.asByteData());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PDF Four Column Example'),
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
                      _billHeader(),
                      _billTable(),
                      _billInfo(),
                    ],
                  );
                },
              ),

              //TODO Test multipage 
              // pw.MultiPage(
              // textDirection: pw.TextDirection.rtl,
              // pageFormat: PdfPageFormat.roll80,
                
              //   build:(context) {
              //       return[ pw.Column(
              //       children: [
              //         _billHeader(),
              //         _billTable(),
              //         _billInfo(),
              //       ],
              //     ), pw.Column(
              //       children: [
              //         _billHeader(),
              //         _billTable(),
              //         _billInfo(),
              //       ],
              //     )];
              //   }, )
              
            );
             pdf.addPage(
    pw.Page(
      textDirection: pw.TextDirection.rtl,
      pageFormat: PdfPageFormat.roll80,
      build: (pw.Context context) {
        return pw.Column(
          children: [
            _billHeader(),
            _billTable(),
            _billInfo(),
          ],
        );
      },
    ),
  );
   pdf.addPage(
    pw.Page(
      textDirection: pw.TextDirection.rtl,
      pageFormat: PdfPageFormat.roll80,
      build: (pw.Context context) {
        return pw.Column(
          children: [
            _billHeader(),
            _billTable(),
            _billInfo(),
          ],
        );
      },
    ),
  );

            // Save PDF
            // final output = await getTemporaryDirectory();
            // final file = File('${output.path}/bill.pdf');
            // await file.writeAsBytes(await pdf.save());

            // // Open PDF
            // OpenFile.open(file.path);

            

// direct print 
Printing.directPrintPdf(printer: const Printer(url: "",name: ""), onLayout: (format)async => await pdf.save(),);

          },
          child: const Text('Generate PDF'),
        ),
      ),
    );
  }

  pw.Widget _billHeader()
  {

    return pw.Container(
      margin: const pw.EdgeInsets.only(bottom: 20),
      child: pw.Column(
        children: [
          pw.SizedBox(height: 10),
          pw.SvgImage(svg:  File('assets/albaik.svg').readAsStringSync() , width: 80 ) ,// Add image widget here
          pw.SizedBox(height: 10),
          //TODO:: رقم الطلب
          pw.Text('التاريخ : ${formatDateString(DateTime.now().toString())}', style: pw.TextStyle(fontSize: 10, font: ttf  , )),
          pw.Divider(),
        ],
      ),
    );
  }
  pw.Widget _billInfo()
  {

    return pw.Container(
      margin: const pw.EdgeInsets.only(bottom: 20),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.stretch,
        children: [
          pw.SizedBox(height: 10),
          pw.Text('المبلغ الاجمالي : ${widget.totalAmount}',style: pw.TextStyle(fontSize: 8, font: ttf  ,)),
          pw.Text('المبلغ المدفوع : ${widget.paidAmount}',style: pw.TextStyle(fontSize: 8, font: ttf  ,)),
          pw.Text('المبلغ المتبقي : ${widget.stayedAmount}',style: pw.TextStyle(fontSize: 8, font: ttf  ,)),
        ],
      ),
    );
  }

  pw.Widget _billTable() {

    final tableHeaders = [ 'السعر','الكمية', 'الوحدة', 'الصنف'];
    final tableRows = widget.formattedproudct.map((item) {
  
      return [
        item.totalPrice.toString(),
       item.count.toString(),
        item.unit,
        item.productName,
      ];
    }).toList();

    // ignore: deprecated_member_use
    return pw.Directionality(textDirection: pw.TextDirection.rtl,child:    pw.Table.fromTextArray(
   
      headers: tableHeaders,
      data: tableRows,
      border: pw.TableBorder.all(width: 0.5),
    
      headerStyle: pw.TextStyle(fontSize: 10, font: ttfHeader  ),
      cellStyle:pw.TextStyle(fontSize: 9, font: ttf  ,) ,
      cellAlignment: pw.Alignment.center,
    ) );
      }
}
