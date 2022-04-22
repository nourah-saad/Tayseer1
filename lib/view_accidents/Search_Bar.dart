import 'package:flutter/material.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:tayseer2/view_accidents/view_accidents_widget.dart';
class Search_bar extends StatefulWidget {
  const Search_bar({Key? key}) : super(key: key);

  @override
  State<Search_bar> createState() => _Search_barState();
}

class _Search_barState extends State<Search_bar> {
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
                icon: new Icon(
                  Icons.chevron_left,
                  size: 50,
                ),
                color: Color(0xFF46494D),
                //size: 50,
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => ViewAccidentsWidget()),
                  );
                }),
          automaticallyImplyLeading: false,
         title: new Text('             ابحث عن موقع الحادث'),
         
         backgroundColor: Color(0xFF85BBC2),

        ),
        
body: SafeArea(
  child: Container(
    child: Column(
      children: [
        placesAutoCompleteTextField(),

     
     

 ],
      
    ),
  ),
),
    );
  }

  placesAutoCompleteTextField() {
    return Container(
      
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: GooglePlaceAutoCompleteTextField(
          textEditingController: controller,
          googleAPIKey: "AIzaSyDWbWpOKBZXqcSB3NY1Pu1tWz6HfviztF8",
          inputDecoration: InputDecoration(hintText: "                                                                                ...ابحث"),
          debounceTime: 800,
          countries: ["sa"],
          isLatLngRequired: true,
          getPlaceDetailWithLatLng: (Prediction prediction) {
            print("placeDetails" + prediction.lng.toString());
          },
          itmClick: (Prediction prediction) {
            controller.text = prediction.description!;
           final data = prediction.description!;
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>  ViewAccidentsWidget(address:controller.text ,)),
            );
            controller.selection = TextSelection.fromPosition(
                TextPosition(offset: prediction.description!.length));
          }
        // default 600 ms ,
      ),
    );
  }
}
