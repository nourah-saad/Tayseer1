import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:geocoding/geocoding.dart';
import 'package:intl/intl.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:tayseer2/view_accidents/pdf_g.dart';
import 'dart:io' show Platform;

class AccidentReportWidget extends StatefulWidget {
  final id;
  const AccidentReportWidget({Key? key, this.id}) : super(key: key);

  @override
  _AccidentReportWidgetState createState() => _AccidentReportWidgetState();
}

class _AccidentReportWidgetState extends State<AccidentReportWidget> {
  File? file;
  @override
  void initState() {
    //pdf();
    fetchdata();

    super.initState();
  }

  final scaffoldKey = GlobalKey<ScaffoldState>();
  dynamic address = '',
      adate = '',
      atime = '',
      time = '',
      status = '',
      driver1 = '',
      car1 = '',
      id1 = '',
      falut1 = '',
      driver2 = '',
      car2 = '',
      id2 = '',
      falut2 = '',
      accident_type = '';
  GeoPoint? location;
  final Accidents = FirebaseFirestore.instance.collection('Accident');
  void GetAddressFromLatLong(LatLng l) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(l.latitude, l.longitude);
    // print(placemarks);
    Placemark place = placemarks[0];
    setState(() {
      address = '${place.street} ${place.subLocality}, ${place.locality}';
    });
    print('the adrres is ${address}');
  }

  void _onLoading(context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          child: new Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              new CircularProgressIndicator(),
              new Text("Loading"),
            ],
          ),
        );
      },
    );
    new Future.delayed(new Duration(seconds: 4), () {});
  }

  Future<void> fetchdata() async {
//_onLoading(context);
    var docSnapshot = await Accidents.doc(widget.id).get();

    if (docSnapshot.exists) {
      Map<String, dynamic>? data = docSnapshot.data();

      setState(() {
        //accident info

        location = data!['Location'];
        time = data['Date_time'].toDate();
        status = data['status'].toString();
        falut1 = data['Fault_assessment'][0].toString();
        falut2 = data['Fault_assessment'][1].toString();
        accident_type = data['accident_type'].toString();
        car1 = data['Cars_Involved'][0]['Car_plateNo'].toString();
        car2 = data['Cars_Involved'][1]['Car_plateNo'].toString();
        driver1 = data['Drivers_Involved'][0]['name'].toString();
        id1 = data['Drivers_Involved'][0]['Driver_Id'].toString();
        driver2 = data['Drivers_Involved'][1]['name'].toString();
        id2 = data['Drivers_Involved'][1]['Driver_Id'].toString();
      });
      print("-------------------------${falut1}-----------------------");
    }

    setState(() {
      adate = DateFormat('yyyy-MM-dd').format(time!);
      atime = DateFormat.Hms().format(time!);
    });

    GetAddressFromLatLong(LatLng(location!.latitude, location!.longitude));
  }

  Future<void> share() async {
    await FlutterShare.shareFile(
      title: 'Example share',
      text: 'Example share text',
      filePath: file!.path,
      chooserTitle: 'Example Chooser Title',
    );
  }

  void pdf() async {
    const String paragraphText =
        'Adobe Systems Incorporated\'s Portable Document Format (PDF) is the de facto'
        'document. It\'s the only universally accepted file format that allows pixel-perfect layouts.'
        'In addition, PDF supports user interaction and collaborative workflows that are not'
        'possible with printed documents.';
    const String paragraphTextt = 'الطرف الأول\n'
        'الإسم:\n'
        'رقم اللوحة:\n'
        'نسبة الخطأ:\n'
        'الطرف الثاني:\n'
        'الإسم:\n'
        'رقم اللوحة:\n'
        'نسبة الخطأ:\n'
        ':الموقع\n'
        ' :التاريخ:\n'
        ' :الوقت:\n'
        'حالة التقرير\n'
        ':تخطيط الحادث:\n';
// Create a new PDF document.

    final PdfDocument document = PdfDocument();
// Add a new page to the document.
    final PdfPage page = document.pages.add();

    final Uint8List fontData =
        File('fonts/Lateef_Regular.ttf').readAsBytesSync();
//Create a PDF true type font object.
    final PdfFont font = PdfTrueTypeFont(fontData, 12);
    final textDirection = PdfTextDirection.none;
//Saves the document
    File('Output.pdf').writeAsBytes(document.save());
// Create a new PDF text element class and draw the flow layout text.
    final PdfLayoutResult layoutResult = PdfTextElement(
            text: paragraphText,
            format: PdfStringFormat(
              textDirection: textDirection,
            ),
            font: font,
            brush: PdfSolidBrush(PdfColor(0, 0, 0)))
        .draw(
            page: page,
            bounds: Rect.fromLTWH(
                0, 0, page.getClientSize().width, page.getClientSize().height),
            format: PdfLayoutFormat(layoutType: PdfLayoutType.paginate))!;
    page.graphics.drawLine(
        PdfPen(PdfColor(255, 0, 0)),
        Offset(0, layoutResult.bounds.bottom + 10),
        Offset(page.getClientSize().width, layoutResult.bounds.bottom + 10));
// Draw the next paragraph/content.
    List<int> bytes = document.save();
// Save the document.
    Directory directory = (await getApplicationDocumentsDirectory());
    //Get directory path
    String path = directory.path;

    file = File('$path/Output.pdf');
    await file!.writeAsBytes(bytes, flush: true);
// Dispose the document.
    document.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Color(0xFFD8EBEE),
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 130, 0, 0),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 1,
              decoration: BoxDecoration(
                color: Color(0xFFD8EBEE),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(0),
                  bottomRight: Radius.circular(0),
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 40, 20, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                              padding: EdgeInsets.all(10),
                              child: InkWell(
                                  onTap: () {
                                    // Share.shareFiles([file!.path], text: 'Great picture');
                                    getPdfPath();
                                  },
                                  child: Icon(Icons.camera_enhance))),
                          Spacer(),
                          Text(
                            'الطرف الأول',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 18,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 10, 20, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            '${driver1} ',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: Color(0xFF46494D),
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            '  :الإسم',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: Color(0xFF46494D),
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 5, 20, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            '${car1}',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: Color(0xFF46494D),
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            '  :رقم اللوحة',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: Color(0xFF46494D),
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 5, 20, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            '${falut1}',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: Color(0xFFEB6666),
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            '   :نسبة الخطأ',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: Color(0xFF46494D),
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 20, 20, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'الطرف الثاني',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 5, 20, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            '   ${driver2} ',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: Color(0xFF46494D),
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            '   :الإسم',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: Color(0xFF46494D),
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 5, 20, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            '${car2}',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: Color(0xFF46494D),
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            '  :رقم اللوحة',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: Color(0xFF46494D),
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 5, 20, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            '${falut2}',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: Color(0xFFEB6666),
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            '   :نسبة الخطأ',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: Color(0xFF46494D),
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 20, 20, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Flexible(
                            child: Text(
                              'الموقع: ${address}',
                              overflow: TextOverflow.visible,
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                color: Color(0xFF46494D),
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 5, 20, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            '${adate}',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: Color(0xFF46494D),
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            '  :التاريخ',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: Color(0xFF46494D),
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 5, 20, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            '${atime}',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: Color(0xFF46494D),
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            ' :الوقت',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: Color(0xFF46494D),
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 5, 20, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            '${status}',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: Color.fromARGB(255, 80, 129, 75),
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            '  : حالة التقرير',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: Color(0xFF46494D),
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 5, 20, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            '  :تخطيط الحادث',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: Color(0xFF46494D),
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 17,
                    ),
                    Container(
                      height: 200,
                      width: 200,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: accident_type == 'S1'
                              ? AssetImage('lib/images/accident1.png')
                              : AssetImage('lib/images/accident2.png'),
                          fit: BoxFit.fill,
                        ),
                        shape: BoxShape.rectangle,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(10, 60, 0, 0),
            child: IconButton(
              icon: new Icon(
                Icons.chevron_left,
                size: 50,
              ),
              color: Color(0xFF46494D),
              //size: 50,
              onPressed: () async => Navigator.pop(context),
            ),
          ),
          Align(
            alignment: AlignmentDirectional(0, -0.82),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 5),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                    child: Text(
                      'تقرير الحادث',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 30,
                        color: Color(0xFF46494D),
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void getPdfPath() async {
    final File file = await generateAndPrintArabicPdf(id1, car1, driver1,
        falut1, id2, car2, driver2, falut2, address, status, adate, atime);
    Share.shareFiles([file.path], text: 'Great picture');

    print('"init function $file');
  }
}
