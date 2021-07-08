import 'package:flutter/material.dart';
import '../../widgets/deal_screen.dart';

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
          '/': (context) => const DealScreen(),
          '/lidl': (context) => const DealScreen(
                shopName: 'lidl',
              ),
          '/aldi': (context) => const DealScreen(
                shopName: 'aldi',
              ),
          '/edeka': (context) => const DealScreen(
                shopName: 'edeka',
              ),
          '/famila': (context) => const DealScreen(
                shopName: 'famila',
              ),
        });
  }
}
