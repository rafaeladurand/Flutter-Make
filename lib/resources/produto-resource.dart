import 'package:dio/dio.dart';
import 'package:flutter_application_1/modelos/produto.dart';
import 'package:flutter_application_1/resources/base-resource.dart';


class ProdutoResource extends BaseResource{
final dio = Dio();

Future<Produto> buscarProduto(String idProduto) async {
  String url = resolverParams('http://localhost:5000/buscar-produto/:idProduto', {'idProduto': idProduto});
  //print(url);
  final response = await dio.get(url);
  //print(response);
  return Produto.fromJson(response.data);
}

Future<List<Produto>> listarProduto() async {
  String url = 'http://localhost:5000/listar-produtos';
  final response = await dio.get(url);
  return Produto.listFromJson(response.data);
}

Future<String> novoProduto(Produto produto) async {
  String url = 'http://localhost:5000/novo-produto';
  final response = await dio.post(url, data: produto.toJson());
  return response.data;
}

Future<String> editarProduto(String idProduto, Produto produto) async {
  String url = resolverParams('http://localhost:5000/editar-produto/:idProduto', {'idProduto': idProduto});
  final response = await dio.put(url, data: produto.toJson());
  return response.data;
}

Future<String> apagarProduto(String idProduto) async {
  String url = resolverParams('http://localhost:5000/apagar-produto/:idProduto', {'idProduto': idProduto});
  final response = await dio.delete(url);
  return response.data;
}


}


