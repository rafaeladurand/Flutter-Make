import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/gerencia.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  const ProductCard({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var label = Text('Adicionar ao carrinho');
    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.network(product.imageUrl),
          Text(product.name),
          Text('\$${product.price}'),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const SizedBox(height: 32.0),
              ElevatedButton.icon(
                onPressed: _adicionarCarrinho,
                icon: Icon(Icons.add_shopping_cart),
                label: label,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

void _adicionarCarrinho() {
  
}

class Product {
  final String id;
  final String name;
  final String imageUrl;
  final String price;

  const Product({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.price,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['nome'],
      imageUrl: json['imagem'],
      price: json['descricao'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': name,
      'imagem': imageUrl,
      'price': price,
    };
  }
}

class MakeupGrid extends StatelessWidget {
  final List<Product> products;
  const MakeupGrid({Key? key, required this.products}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 3,
      childAspectRatio: 0.7,
      padding: const EdgeInsets.all(8.0),
      mainAxisSpacing: 10.0,
      crossAxisSpacing: 5.0,
      children:
          products.map((product) => ProductCard(product: product)).toList(),
    );
  }
}
