import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/gerencia.dart';
import 'package:flutter_application_1/grid.dart';
import 'package:shared_preferences/shared_preferences.dart';



class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Product> products = [];

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  Future<void> _loadProducts() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var itemsStr = prefs.getString('itens') ?? '[]';
      List items = jsonDecode(itemsStr);
      setState(() {
        products =
            items.map<Product>((item) => Product.fromJson(item)).toList();
      });
    } catch (e) {
      print('Erro ao carregar produtos: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Maquiagem'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Gerenciamento()),
              );
                _loadProducts();
              
            },
          )
        ],
      ),
      body: MakeupGrid(products: products),
    );
  }
}