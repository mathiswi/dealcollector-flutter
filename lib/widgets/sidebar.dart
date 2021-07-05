import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:dealcollector/utils.dart';

const List<String> shops = ['lidl', 'aldi', 'edeka', 'famila'];

class Sidebar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          // DrawerHeader(
          //   decoration: BoxDecoration(
          //     color: Colors.blue,
          //   ),
          //   child: Text('Drawer Header'),
          // ),
          ListTile(
            title: Text('Home'),
            onTap: () {
              Navigator.pushNamed(context, '/');
            },
          ),
          for (String name in shops)
            ListTile(
              title: Text(name.capitalizeFirstofEach),
              onTap: () {
                Navigator.pushNamed(context, '/${name}');
              },
            ),
        ],
      ),
    );
  }
}
