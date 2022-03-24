import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:geolocator/geolocator.dart';
import 'package:tayseer2/assistants/requset_assistant.dart';
import 'package:tayseer2/global/global.dart';
import 'package:tayseer2/global/map_key.dart';
import 'package:tayseer2/infoHandler/app_info.dart';
import 'package:tayseer2/models/directions.dart';
import 'package:tayseer2/models/driver_model.dart';
import 'package:provider/provider.dart';

class AssistantMethods {
  static Future<String> searchAddressForGeographicCoOrdinates(
      Position position, context) async {
    String apiUrl =
        "https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=$mapKey";
    String humanReadableAddress = "";

    var requestResponse = await RequestAssistant.receiveRequest(apiUrl);

    if (requestResponse != "Error Occurred, Failed. No Response.") {
      humanReadableAddress = requestResponse["results"][0]["formatted_address"];

      Directions userPickUpAddress = Directions();
      userPickUpAddress.locationLatitude = position.latitude;
      userPickUpAddress.locationLongitude = position.longitude;
      userPickUpAddress.locationName = humanReadableAddress;

      Provider.of<AppInfo>(context, listen: false)
          .updatePickUpLocationAddress(userPickUpAddress);
    }

    return humanReadableAddress;
  }

  static void readCurrentOnlineDriverInfo() async {
    currentFirebaseUser = fAuth.currentUser;

    var userRef = await FirebaseFirestore.instance
        .collection('Driver')
        .doc(currentFirebaseUser!.uid)
        .get();

    if (userRef.exists) {
      driverModelCurrentInfo = DriverModel(
        id: userRef.reference.id,
        did: userRef.data()!['Driver_Id'],
        email: userRef.data()!["email"],
        name: userRef.data()!["name"],
        nationality: userRef.data()!["nationality"],
        phone: userRef.data()!["phone"],
        sex: userRef.data()!["sex"],
      );
    }
  }
}
