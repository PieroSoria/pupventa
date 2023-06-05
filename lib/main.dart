import 'package:Pricechecker/page/config.dart';
import 'package:Pricechecker/page/index.dart';
import 'package:Pricechecker/page/licencia.dart';
import 'package:Pricechecker/page/login_page.dart';
import 'package:Pricechecker/page/main_screen.dart';
import 'package:Pricechecker/page/registrar.dart';
import 'package:Pricechecker/page/userruc.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final Map<String, WidgetBuilder> routes = {
    '/': (BuildContext context) => const LoginPage(),
    '/index': (BuildContext context) => const Index(),
    '/registrar': (BuildContext context) => const Registrar(),
    '/principal': (BuildContext context) => const Principal(),
    '/user': (BuildContext context) => const Userruc(),
    '/licencia': (BuildContext context) => const Licencia(),
    '/config': (BuildContext context) => const Config(),
  };
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      initialRoute: '/',
      routes: routes,
    );
  }    
}