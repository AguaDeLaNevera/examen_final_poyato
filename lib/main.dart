import 'package:flutter/material.dart';
import 'package:plantilla_login_register/providers/information.dart';
import 'package:provider/provider.dart';
import 'screens/screens.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => Information(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: 'logOrReg',
      routes: {
        '/': (context) => const HomeScreen(),
        'logOrReg': (context) => LoginOrRegisterScreen(),
        'createTree': (context) => CreateTreeScreen(),
        'treeDetails': (context) => TreeDetailsScreen(),
        'ipGeolocation': (context) =>
            IPGeolocationScreen(), // Add the route for IP Geolocation screen
      },
    );
  }
}
