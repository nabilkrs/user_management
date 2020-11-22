import 'package:crudapp/models/user.dart';
import 'package:crudapp/pages/Add.dart';
import 'package:crudapp/pages/Home.dart';
import 'package:crudapp/pages/details.dart';

import 'package:flutter/material.dart';

main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        initialRoute: '/',
        routes: {
          '/add': (context) => Add(),
          //  '/':(context)=>Home(),
          //    '/details':(context)=>Details(),
        },
        theme: new ThemeData(
          brightness: Brightness.dark,
          primarySwatch: Colors.purple,
          primaryColor: const Color(0xFF212121),
          accentColor: const Color(0xFF64ffda),
          canvasColor: const Color(0xFF303030),
        ),
        debugShowCheckedModeBanner: false,
        home: Home());
  }
}
