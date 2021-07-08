import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../utils.dart';

const List<String> shops = ['lidl', 'aldi', 'edeka', 'famila'];

class Sidebar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
            height: 80.0,
            padding: const EdgeInsets.all(16),
            child: const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Dealcollector',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
          ),
          ListTile(
            title: const Text('Home'),
            onTap: () {
              Navigator.pushNamed(context, '/');
            },
          ),
          for (String name in shops)
            ListTile(
              title: Text(name.capitalizeFirstofEach),
              onTap: () {
                Navigator.pushNamed(context, '/$name');
              },
            ),
        ],
      ),
    );
  }
}
