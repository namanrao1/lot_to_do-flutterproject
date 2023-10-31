import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lot_to_do/setting_screen_provider.dart';

class SettingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeModel = Provider.of<ThemeModel>(context,listen: true);

    return Theme(
      data:themeModel.currentTheme,
      child:Scaffold(
        appBar: AppBar(
          title:const  Text('Settings'),
        ),
        body: Column(
          children: <Widget>[
            const ListTile(
              title: Text(
                "Choose Theme:",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            RadioListTile<ThemeData>(
              title: const Text("Light Theme"),
              value: ThemeData.light(),
              groupValue: themeModel.currentTheme,
              onChanged: (ThemeData? value) {
                if (value != null) {
                  themeModel.setTheme(value);
                }
              },
            ),
            RadioListTile<ThemeData>(
              title: const Text("Dark Theme"),
              value: ThemeData.dark(),
              groupValue: themeModel.currentTheme,
              onChanged: (ThemeData? value) {
                if (value != null) {
                  themeModel.setTheme(value);
                }
              },
            ),
            // More theme options
          ],
        ),
      )
    );
  }
}
