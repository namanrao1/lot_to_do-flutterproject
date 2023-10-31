import 'package:flutter/material.dart';
import 'package:lot_to_do/add_screen.dart';
import 'package:lot_to_do/provider_anime.dart';
import 'package:flutter/material.dart';
import 'package:lot_to_do/first_screen.dart';
import 'package:provider/provider.dart';
import 'provider_anime.dart';

// Imports JavaScript-related types

import 'package:lot_to_do/task_details.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lot_to_do/add_screen.dart';
import 'package:lot_to_do/settings_screen.dart';
 // Import your User model here
import 'package:provider/provider.dart';
import 'package:lot_to_do/setting_screen_provider.dart';
class DetailScreen extends StatelessWidget {
  User user;

  DetailScreen(this.user);


  @override
  Widget build(BuildContext context) {
    final themeModel = Provider.of<ThemeModel>(context);
    return Theme(data: themeModel.currentTheme, child:
    Scaffold(
        appBar: AppBar(
          title: Text('Task Description'),
        ),
        body:Container(
          padding: const EdgeInsets.all(21),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Task:\n${user.task}\n",
                style: TextStyle(fontSize: 21),
              ),
              Text(
                "Date:\n${user.date}\n",
                style: TextStyle(fontSize: 21),
              ),
              Text(
                "Time:\n${user.time}\n",
                style: TextStyle(fontSize: 21),
              ),
              Text(
                "Latitude:\n${user.lati}\n",
                style: TextStyle(fontSize: 21),
              ),
              Text(
                "Longitude:\n${user.longi}\n",
                style: TextStyle(fontSize: 21),
              ),
            ],
          ),
        )


    ),);
  }
}

