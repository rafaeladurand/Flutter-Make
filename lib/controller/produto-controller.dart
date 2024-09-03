
import 'package:flutter_application_1/modelos/produto.dart';
import 'package:flutter_application_1/resources/produto-resource.dart';

class ProdutoController {
    final ProdutoResource produtoResource =  ProdutoResource();

   Future<void> edicao(Produto item) async {
   var produto = await produtoResource.buscarProduto(item.id!);
   print(produto.toJson());
  }

}