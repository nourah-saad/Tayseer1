import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

Future<dynamic> generateAndPrintArabicPdf(String ID_one,String car1,String Driver_one,String falut_one,String ID_tow,String car2,String Driver_tow,String falut_three,String address,String status,String date,String time) async {

  final Document pdfDocument = Document();
  final image =MemoryImage(
    (await rootBundle.load('lib/images/accident2.png')).buffer.asUint8List(),
  );

  var arabicFont = Font.ttf(await rootBundle.load("images/HacenTunisia.ttf"));

  pdfDocument.addPage(Page(
      theme: ThemeData.withFont(
        base: arabicFont,
      ),
      pageFormat: PdfPageFormat.roll80,
      build: (Context context) {
        return Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Directionality(
                            textDirection: TextDirection.rtl,
                            child: Center(
                                child: Text(
                                    'الطرف الأول:', style: TextStyle(
                                  fontSize: 10,
                                ))
                            )
                        ),

                      ]
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Directionality(
                            textDirection: TextDirection.rtl,
                            child: Center(
                                child: Text(
                                    Driver_one, style: TextStyle(
                                  fontSize: 10,
                                ))
                            )
                        ),
                        Directionality(
                            textDirection: TextDirection.rtl,
                            child: Center(
                                child: Text('الإسم:', style: TextStyle(
                                  fontSize: 10,
                                ))
                            )
                        ),
                      ]
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Directionality(
                            textDirection: TextDirection.rtl,
                            child: Center(
                                child: Text(
                                    car1, style: TextStyle(
                                  fontSize: 10,
                                ))
                            )
                        ),
                        Directionality(
                            textDirection: TextDirection.rtl,
                            child: Center(
                                child: Text('رقم اللوحة:', style: TextStyle(
                                  fontSize: 10,
                                ))
                            )
                        ),
                      ]
                  ),

                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Directionality(
                            textDirection: TextDirection.rtl,
                            child: Center(
                                child: Text(
                                    ID_one, style: TextStyle(
                                  fontSize: 10,
                                ))
                            )
                        ),
                        Directionality(
                            textDirection: TextDirection.rtl,
                            child: Center(
                                child: Text(' رقم الهوية/الإقامة:', style: TextStyle(
                                  fontSize: 10,
                                ))
                            )
                        ),
                      ]
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Directionality(
                            textDirection: TextDirection.rtl,
                            child: Center(
                                child: Text(
                                    falut_one, style: TextStyle(
                                  fontSize: 10,
                                ))
                            )
                        ),
                        Directionality(
                            textDirection: TextDirection.rtl,
                            child: Center(
                                child: Text('نسبة الخطأ:', style: TextStyle(
                                  fontSize: 10,
                                ))
                            )
                        ),
                      ]
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Directionality(
                            textDirection: TextDirection.rtl,
                            child: Center(
                                child: Text(
                                    ' الطرف الثاني:', style: TextStyle(
                                  fontSize: 10,
                                ))
                            )
                        ),

                      ]
                  ),

                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Directionality(
                            textDirection: TextDirection.rtl,
                            child: Center(
                                child: Text(
                                    Driver_tow, style: TextStyle(
                                  fontSize: 10,
                                ))
                            )
                        ),
                        Directionality(
                            textDirection: TextDirection.rtl,
                            child: Center(
                                child: Text('الإسم: ', style: TextStyle(
                                  fontSize: 10,
                                ))
                            )
                        ),
                      ]
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Directionality(
                            textDirection: TextDirection.rtl,
                            child: Center(
                                child: Text(
                                    car2, style: TextStyle(
                                  fontSize: 10,
                                ))
                            )
                        ),
                        Directionality(
                            textDirection: TextDirection.rtl,
                            child: Center(
                                child: Text('رقم اللوحة: ', style: TextStyle(
                                  fontSize: 10,
                                ))
                            )
                        ),
                      ]
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Directionality(
                            textDirection: TextDirection.rtl,
                            child: Center(
                                child: Text(
                                   ID_tow, style: TextStyle(
                                  fontSize: 10,
                                ))
                            )
                        ),
                        Directionality(
                            textDirection: TextDirection.rtl,
                            child: Center(
                                child: Text('رقم الهوية/الإقامة: ', style: TextStyle(
                                  fontSize: 10,
                                ))
                            )
                        ),
                      ]
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Directionality(
                            textDirection: TextDirection.rtl,
                            child: Center(
                                child: Text(
                                    falut_three, style: TextStyle(
                                  fontSize: 10,
                                ))
                            )
                        ),
                        Directionality(
                            textDirection: TextDirection.rtl,
                            child: Center(
                                child: Text('نسبة الخطأ:', style: TextStyle(
                                  fontSize: 10,
                                ))
                            )
                        ),
                      ]
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Directionality(
                            textDirection: TextDirection.rtl,
                            child: Center(
                                child: Text(
                                   address, style: TextStyle(
                                  fontSize: 10,
                                ))
                            )
                        ),
                        Directionality(
                            textDirection: TextDirection.rtl,
                            child: Center(
                                child: Text('الموقع: ', style: TextStyle(
                                  fontSize: 10,
                                ))
                            )
                        ),
                      ]
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Directionality(
                            textDirection: TextDirection.rtl,
                            child: Center(
                                child: Text(
                                    date, style: TextStyle(
                                  fontSize: 10,
                                ))
                            )
                        ),
                        Directionality(
                            textDirection: TextDirection.rtl,
                            child: Center(
                                child: Text('الموقع: ', style: TextStyle(
                                  fontSize: 10,
                                ))
                            )
                        ),
                      ]
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Directionality(
                            textDirection: TextDirection.rtl,
                            child: Center(
                                child: Text(
                                    status, style: TextStyle(
                                  fontSize: 10,
                                ))
                            )
                        ),
                        Directionality(
                            textDirection: TextDirection.rtl,
                            child: Center(
                                child: Text(' حالة التقرير:', style: TextStyle(
                                  fontSize: 10,
                                ))
                            )
                        ),
                      ]
                  ),
                  // Container(
                  //
                  //   child: new Image('assets/tree.jpg'),
                  //   alignment: Alignment.center,
                  // ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Directionality(
                            textDirection: TextDirection.rtl,
                            child: Center(
                                child: Text(
                                    '  0506040215 ', style: TextStyle(
                                  fontSize: 10,
                                ))
                            )
                        ),
                        Directionality(
                            textDirection: TextDirection.rtl,
                            child: Center(
                                child: Text('حالة التقرير:', style: TextStyle(
                                  fontSize: 10,
                                ))
                            )
                        ),
                      ]
                  ),

                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Directionality(
                            textDirection: TextDirection.rtl,
                            child: Center(
                                child: Text(
                                    '  0506040215 ', style: TextStyle(
                                  fontSize: 10,
                                ))
                            )
                        ),
                        Directionality(
                            textDirection: TextDirection.rtl,
                            child: Center(
                                child: Text('تخطيط الحادث:', style: TextStyle(
                                  fontSize: 10,
                                ))
                            )
                        ),
                      ]
                  ),
                   // Container(
                  //   alignment: Alignment.center,
                  //   child: Image(image),
                  // ),
                  Container(
                    alignment: Alignment.center,
                    child: Image(image,width: 50,alignment: Alignment.center),
                  ),


                ]
            )
        );
      }
  ));

  final String dir = (await getApplicationDocumentsDirectory()).path;
  final String path = '$dir/1.pdf';
  final File file = File(path);

  final bytes =await pdfDocument.save();
  await file.writeAsBytes(bytes);

  return file;

}


