import 'dart:convert';
import 'package:flutter/material.dart';


class ProductCard extends StatelessWidget {
  const ProductCard({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.network(product.imageUrl),
          Text(product.name),
          Text('\$${product.price}'),
        ],
      ),
    );
  }
}

class Product {
  final String id;
  final String name;
  final String imageUrl;
  final double price;

  const Product({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.price,
  });
}

class MakeupGrid extends StatelessWidget {
  const MakeupGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final products = [
      // Adicione seus produtos aqui
      Product(
        id: '1',
        name: 'Batom Marrom',
        imageUrl:
            'https://www.marimariamakeup.com/arquivos/ids/164519-undefined-undefined/batom-stick-ginger-glow-true-tampa-laranja-mari-maria-makeup.png?v=638394602964630000',
        price: 36.99,
      ),
      Product(
        id: '2',
        name: 'Ilumidador',
        imageUrl:
            'https://www.marimariamakeup.com/arquivos/ids/163635-undefined-undefined/iluminador-facial-aurora-embalagem-laranja-rosa-mari-maria-makeup.png?v=638258914850800000',
        price: 39.99,
      ),
      Product(
        id: '3',
        name: 'Pincel',
        imageUrl:
            'https://www.marimariamakeup.com/arquivos/ids/164709-undefined-undefined/Pincel-maquiagem-cerdas-laranja-contorno-e-iluminacao-ginger-glow-Mari-Maria-Makeup.png?v=638403205694430000',
        price: 79.99,
      ),
      Product(
        id: '4',
        name: 'Esponja',
        imageUrl:
            'https://www.marimariamakeup.com/arquivos/ids/164706-undefined-undefined/puffer-esponja-de-aplicacao-detalhes-mari-maria-make-up-frente.png?v=638403201632400000',
        price: 10.00,
      ),
      // ...
    ];
    return GridView.count(
      crossAxisCount: 3,
      childAspectRatio: 0.7, // Adjust based on your desired image aspect ratio
      padding: const EdgeInsets.all(8.0), // Add some padding around the grid
      mainAxisSpacing: 10.0, // Space between rows
      crossAxisSpacing: 5.0, // Space between columns
      children:
          products.map((product) => ProductCard(product: product)).toList(),
    );
  }
  
}
