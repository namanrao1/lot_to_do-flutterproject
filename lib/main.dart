
import 'package:lot_to_do/location.dart';

import 'package:flutter/material.dart';
import 'package:lot_to_do/anime.dart';
import 'package:lot_to_do/notify.dart';
import 'package:lot_to_do/setting_screen_provider.dart';
import 'package:provider/provider.dart';
import 'provider_anime.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'package:alarm/alarm.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tzdata;
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/timezone.dart';






Future main() async{
  Notify n=Notify();


  WidgetsFlutterBinding.ensureInitialized();




  await Firebase.initializeApp();
  tzdata.initializeTimeZones();
  n.initializeNotifications();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create:(context)=>ThemeModel()),
        ChangeNotifierProvider(create: (context) => AnimatiProvider()),


      ],

      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      home:  Animati(),
    );
  }
}


