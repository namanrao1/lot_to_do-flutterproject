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





class AddScreen extends StatefulWidget {
  @override
  State<AddScreen> createState() => _AddScreenState();
}
// loc.Location location=loc.Location();
// loc.LocationData? _currentPosition;
// LatLng? destLocation=LatLng(37.3161,-121.9195);

DateTime selectedDate = DateTime.now();
TimeOfDay selectedTime = TimeOfDay.now();

// final Completer<GoogleMapController?> controller=Completer<GoogleMapController?>();
// String? address;
class _AddScreenState extends State<AddScreen> {



  TextEditingController taskController = TextEditingController();
  String task = "";
  TextEditingController _dateController = TextEditingController();

  TextEditingController _timeController = TextEditingController();



  TextEditingController latiController=TextEditingController();
  TextEditingController longiController=TextEditingController();

  void seltask(String a) {
    setState(() {
      task = a;
    });
  }

  // Future<void> getCurrentLocation() async {
  //   loc.Location location = loc.Location();
  //   bool _serviceEnabled;
  //   PermissionStatus _permissionGranted;
  //
  //   _serviceEnabled = await location.serviceEnabled();
  //
  //   if (!_serviceEnabled) {
  //     _serviceEnabled = await location.requestService();
  //     if (!_serviceEnabled) {
  //       return;
  //     }
  //   }
  //
  //   _permissionGranted = (await location.hasPermission()) as PermissionStatus;
  //   if (_permissionGranted == loc.PermissionStatus.denied) {
  //     _permissionGranted=(await location.requestPermission()) as PermissionStatus;
  //
  //     // Handle the denied permission case
  //   } else if (_permissionGranted == loc.PermissionStatus.granted) {
  //     return;
  //     // Handle the restricted permission case
  //   }
  //   if (_permissionGranted==loc.PermissionStatus.granted){
  //     location.changeSettings(accuracy: loc.LocationAccuracy.high);
  //     _currentPosition=await location.getLocation();
  //
  //     controller?.future.then((GoogleMapController? mapController) {
  //       if (mapController != null) {
  //         mapController.animateCamera(
  //           CameraUpdate.newCameraPosition(
  //             CameraPosition(
  //               target: LatLng(
  //                 _currentPosition!.latitude!,
  //                 _currentPosition!.longitude!,
  //               ),
  //               zoom: 16,
  //             ),
  //           ),
  //         );
  //
  //         setState(() {
  //           destLocation=LatLng(_currentPosition!.latitude!, _currentPosition!.longitude!);
  //           // Update the state here if needed
  //           // For example, you can update a variable to track that the animation is complete.
  //         });
  //       }
  //     });
  //
  //
  //   }
  // }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
        _timeController.text = picked.format(context);
      });
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        _dateController.text = DateFormat('yyyy-MM-dd').format(selectedDate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeModel = Provider.of<ThemeModel>(context, listen: true);



    return Theme(
      data: themeModel.currentTheme,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Add'),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 4, right: 2, top: 4),
              child: Text(
                "Task",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 4, right: 2, bottom: 4),
              child: TextField(
                controller: taskController, // Bind the controller to the TextField
                decoration: InputDecoration(
                  labelText: "Enter task description",
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 4, right: 2, top: 4, bottom: 4),
              child: Text(
                "Date",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 4, right: 2, bottom: 4),
              child: TextField(
                controller: _dateController,
                readOnly: true,
                decoration: InputDecoration(
                  labelText: "Enter date",
                  suffixIcon: IconButton(
                    icon: Icon(Icons.calendar_today),
                    onPressed: () {
                      _selectDate(context);
                    },
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 4, right: 2, top: 4),
              child: Text(
                "Time",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
             Padding(
                padding: EdgeInsets.only(left: 4, right: 2, top: 4),
                child: TextField(
                  controller: _timeController,
                  decoration: InputDecoration(
                    labelText: "Enter time",
                    suffixIcon: IconButton(
                      icon: Icon(Icons.access_time),
                      onPressed: () {
                        _selectTime(context);
                      },
                    ),
                  ),
                ),
              ),
            Padding(
              padding: EdgeInsets.only(left: 4, right: 2, top: 4),
              child: Text(
                "Location",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

              Padding(
                padding: EdgeInsets.only(left: 4, right: 2, ),
                child: TextField(
                  controller: latiController,
                  decoration: InputDecoration(
                    labelText: "Enter latitude",
                    suffixIcon: IconButton(
                      icon: Icon(Icons.location_on),
                      onPressed: () {

                      },
                    ),
                  ),
                ),
              ),


            Padding(
                padding: EdgeInsets.only(left: 4, right: 2, bottom: 4),
                child: TextField(
                  controller: longiController,
                  decoration: InputDecoration(
                    labelText: "Enter longitude",
                    suffixIcon: IconButton(
                      icon: Icon(Icons.location_on),
                      onPressed: () {},
                    ),
                  ),
                ),
              ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {

                    if (taskController.text != null) {

                      // DateTime selectedDateTime = DateTime(
                      //   selectedDate.year,
                      //   selectedDate.month,
                      //   selectedDate.day,
                      //   selectedTime.hour,
                      //   selectedTime.minute,
                      // );
                      // All values are non-null, you can safely call createDet
                      createDet(
                        task: taskController.text,
                        date: _dateController.text,
                        time: _timeController.text,
                        lati:double.parse(latiController.text),
                        longi:double.parse(longiController.text)// dateTime: selectedDateTime
                      );
                      final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
                      FlutterLocalNotificationsPlugin();
                      Notify n=Notify();



                      int i=1;

                      readUsers().listen((users) {
                        for (User user in users) {







                          final scheduledTime = func(user.date, user.time);


                          n.scheduleNotification(id:i,title: 'LOT-TO-DO' ,body:user.task,scheduled: scheduledTime);
                          i+=1;
                        }
                      });



                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FirstScreen(),
                        ),
                      );
                    }
                      // Handle the case where at least one value is null
                      // You can display an error message or take appropriate action
                    }
                    // Create an instance of Datapass with the entered data


                    // Navigate to the next screen while passing the data


                  ,child: Text('Save'),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Stream<List<User>> readUsers() {
  return FirebaseFirestore.instance.collection('details').snapshots().map(
        (snapshot) =>
       snapshot.docs.map(
            (doc)
          =>User.fromJson(doc.data())

      ).toList());
    }




Future<void> createDet(
    {required String task, required String date, required String time,required double lati,required double longi/*required DateTime dateTime}*/}) async {
  final docUser = FirebaseFirestore.instance.collection('details').doc();
  // You can add code here to create a document in Firestore with the provided data.
  final user = User(
    id: docUser.id,
    task: task,
    date: date,
    time: time,
    lati:lati,
    longi:longi,
    // dateTime:dateTime,
  );
  final json = user.toJson();
  await docUser.set(json);
}

class User {
  final String id;
  final String task;
  final String date;
  final String time;
  double lati;
  double longi;


  // final DateTime dateTime;


  User({
    required this.id,
    required this.task,
    required this.date,
    required this.time,
    required this.lati,
    required this.longi
     // required this.dateTime,
  });

  static User fromJson(Map<String, dynamic> json) =>
     User(
      id: json['id'] ,
      task: json['task'] ,
      date: json['date'] ,
      time: json['time'],
       lati:json['lati'],
       longi:json['longi']
       // dateTime: json['datetime'] ,
    );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'task': task,
      'date': date,
      'time': time,
      'lati':lati,
      'longi':longi
      // datetime':dateTime',
    };
  }
}









