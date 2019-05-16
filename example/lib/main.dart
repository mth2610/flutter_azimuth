import 'package:azimuth/azimuth.dart';
import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sensors Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  StreamSubscription<dynamic> azimuthStream; 
  double azimuthValue;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Azimuth Example'),
      ),
      body: Center(
        child: Text("Azimuth: $azimuthValue"),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    azimuthStream.cancel();
  }

  @override
  void initState() {
    super.initState();
    azimuthEvents.listen((AzimuthEvent event) {
      setState(() {
        azimuthValue = event.azimuth;
      });
    });
  }
}