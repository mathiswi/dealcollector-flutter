import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../utils.dart';

class Route {
  String name;
  String route;

  Route({
    required this.name,
    required this.route,
  });
}

final List<Route> routes = [
  Route(name: 'Home', route: '/'),
  Route(name: 'Lidl', route: '/lidl'),
  Route(name: 'Aldi', route: '/aldi'),
  Route(name: 'Edeka', route: '/edeka'),
  Route(name: 'Famila', route: '/famila'),
];

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
          for (Route entry in routes)
            ListTile(
              title: Text(
                entry.name.capitalizeFirstofEach,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color:
                        (ModalRoute.of(context)?.settings.name == entry.route)
                            ? Colors.blue.shade400
                            : Colors.white),
              ),
              onTap: () {
                Navigator.pushNamed(context, entry.route);
              },
            ),
        ],
      ),
    );
  }
}
