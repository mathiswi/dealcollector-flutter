import 'package:flutter/material.dart';
import 'package:dealcollector/widgets/deal_screen.dart';

void main() {
  runApp(Main());
}

class Main extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Home',
        theme: ThemeData(),
        darkTheme: ThemeData.dark(),
        // home: Home(),
        initialRoute: '/',
        routes: {
          '/': (context) => DealScreen(),
          '/lidl': (context) => DealScreen(
                shopName: 'lidl',
              ),
          '/aldi': (context) => DealScreen(
                shopName: 'aldi',
              ),
          '/edeka': (context) => DealScreen(
                shopName: 'edeka',
              ),
          '/famila': (context) => DealScreen(
                shopName: 'famila',
              ),
        });
  }
}
