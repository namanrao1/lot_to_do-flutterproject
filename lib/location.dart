import 'dart:math';
// import 'dart:async';
// import 'dart:developer';
// import 'dart:html';
// import 'package:location/location.dart' as loc;
//
// import 'package:google_maps_flutter/google_maps_flutter.dart';


import 'dart:ffi';
import 'package:geolocator/geolocator.dart';




import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lot_to_do/add_screen.dart';
import 'package:lot_to_do/notify.dart';
// import 'package:lot_to_do/google_map.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:lot_to_do/setting_screen_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lot_to_do/first_screen.dart';
import 'package:lot_to_do/location.dart';
// import 'package:geocoder2/geocoder2.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lot_to_do/notify.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:lot_to_do/main.dart';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:lot_to_do/first_screen.dart';

double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
  const double earthRadius = 6371; // Earth's radius in kilometers

  // Convert degrees to radians
  lat1 = _degreesToRadians(lat1);
  lon1 = _degreesToRadians(lon1);
  lat2 = _degreesToRadians(lat2);
  lon2 = _degreesToRadians(lon2);

  // Haversine formula
  double dLat = lat2 - lat1;
  double dLon = lon2 - lon1;

  double a = pow(sin(dLat / 2), 2) + cos(lat1) * cos(lat2) * pow(sin(dLon / 2), 2);
  double c = 2 * atan2(sqrt(a), sqrt(1 - a));

  // Calculate the distance in kilometers
  double distance = earthRadius * c;

  return distance;
}

double _degreesToRadians(double degrees) {
  return degrees * (pi / 180);
}



class MyApp2 extends StatefulWidget {
  const MyApp2({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp2> {
  String lat="0";
   String long="0";
  String location = "user location";

  @override
  void initState() {
    Notify n=Notify();
    super.initState();
    n.initializeNotifications();
    _livelocation();
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() {
        location = 'Location services are disabled';
      });
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.denied) {
      setState(() {
        location = 'Location permissions are denied';
      });
      return;
    }

    Position position = await Geolocator.getCurrentPosition();
    setState(() {
      lat = position.latitude.toString();
      long = position.longitude.toString();
      location = "latitude: $lat, longitude: $long";
    });
  }

  void _livelocation() {
    LocationSettings locationSettings = const LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 1,
    );

    Geolocator.getPositionStream(locationSettings: locationSettings)
        .listen((Position position) {
      setState(() {
        lat = position.latitude.toString();
        long = position.longitude.toString();

      });

      Notify n = Notify();

      readUsers2().listen((users) {
        for (User user in users) {

          if (calculateDistance(double.parse(lat), double.parse(long), user.lati,user.longi) < 1) {
            n.sendNotification(title: "LOT TO DO", body: user.task);
            print("hi");
          }
          else{
            print("bye");
          }








        }
      });




    });
  }

  @override
  Widget build(BuildContext context) {

    final themeModel = Provider.of<ThemeModel>(context, listen: true);

    return
      Theme(
        data: themeModel.currentTheme,
        child: Scaffold(
        appBar: AppBar(
          title: Text('Location'),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(padding: const EdgeInsets.all(14),
            child:  Text("User Location",style: TextStyle(
                fontSize: 24,fontWeight: FontWeight.bold
            ),),),
            Padding(padding: const EdgeInsets.all(14),
              child:  Text("Latitude:$lat",style: TextStyle(
                  fontSize: 24,
              ),),),
            Padding(padding: const EdgeInsets.all(14),
              child:  Text("Longitude:$long",style: TextStyle(
                fontSize: 24,
              ),),),

           Padding(padding: const EdgeInsets.all(14),
           child:  ElevatedButton(
             onPressed: () {
               _livelocation();
               _getCurrentLocation();
             },
             child: Text("Refresh"),
           ),)
          ],
        ),
      )
      );
  }
}
Stream<List<User>> readUsers2() {
  return FirebaseFirestore.instance.collection('details').snapshots().map(
          (snapshot) =>
          snapshot.docs.map(
                  (doc)
              =>User.fromJson(doc.data())

          ).toList());
}