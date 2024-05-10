import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/grid.dart';


class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Maquiagem'),
      ),
      body: const MakeupGrid(),
    );
  }
}