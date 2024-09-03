class Produto {
  String? id;
  String? nomeProduto;
  String? corProduto;


  Produto({this.id, this.nomeProduto, this.corProduto});

  Produto.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    nomeProduto = json['nomeProduto'];
    corProduto = json['corProduto'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['nomeProduto'] = this.nomeProduto;
    data['corProduto'] = this.corProduto;
    return data;
  }

 static List<Produto> listFromJson(List listJson){
    List<Produto> listaProduto = [];
    for (var el in listJson) {
      var value = Produto.fromJson(el); 
      listaProduto.add(value); 
      }
      return listaProduto;
  }
}
