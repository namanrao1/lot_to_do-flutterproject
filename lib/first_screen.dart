// Imports JavaScript-related types




import 'package:lot_to_do/location.dart';
import 'package:lot_to_do/task_details.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lot_to_do/add_screen.dart';
import 'package:lot_to_do/settings_screen.dart';
 // Import your User model here
import 'package:provider/provider.dart';
import 'package:lot_to_do/setting_screen_provider.dart';



class FirstScreen extends StatefulWidget {
  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  @override
  void initState() {
    super.initState();
    Firebase.initializeApp(); // Initialize Firebase
  }
 // Create an instance of the data manager

// Inside your widget or screen where you're using the UserDataManager
// To delete a user, call the deleteUser method
  void deleteUser(String userId) {
    final docUser=FirebaseFirestore.instance.collection('details').doc(userId);
    docUser.delete();
  }


  Widget buildUser(User user) {
    return Dismissible(
      key: Key(user.id), // Use a unique key for each user
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Icon(
          Icons.delete,
          color: Colors.white,
        ),
      ),
      onDismissed: (direction) {
        // Handle the item removal, you may want to call a function to delete the user
        // Here, we assume a hypothetical deleteUser function
        deleteUser(user.id);
      },
      child: GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => DetailScreen(user)));
        },
        child: ListTile(
          leading: CircleAvatar(child: Text("${user.task[0]}"),),
          title: Text(user.task),
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    final themeModel = Provider.of<ThemeModel>(context);

    return Theme(
      data: themeModel.currentTheme,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Daily Scheduler"),
        ),
        body: StreamBuilder<List<User>>(
          stream: readUsers(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final users = snapshot.data!;
              // Add this line
              return ListView(
                children: users.map(buildUser).toList(),
              );
            } else {
              print('HI');
              return ListView(
                children: [],
              );

              }

          },
        ),

        // Pass the list to the widget

        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              const DrawerHeader(
                decoration: BoxDecoration(color: Colors.blue),
                child: Text(
                  "Options",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.notes),
                title: Text("Tasks"),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.push(context, MaterialPageRoute(builder: (context) => FirstScreen()));
                },
              ),
              ListTile(
                leading: Icon(Icons.add),
                title: Text("Add"),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.push(context, MaterialPageRoute(builder: (context) => AddScreen()));
                },
              ),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text("Settings"),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SettingScreen()));},),
    ListTile(
    leading: Icon(Icons.location_on),
    title: Text("Location"),
    onTap: () {


    Navigator.of(context).pop();
    Navigator.push(context, MaterialPageRoute(builder: (context) => MyApp2()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}


