import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/formulario.dart';
import 'package:flutter_application_1/resources/produto-resource.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Gerenciamento extends StatefulWidget {
  const Gerenciamento({Key? key}) : super(key: key);

  @override
  State<Gerenciamento> createState() => _GerenciamentoState();
}

class _GerenciamentoState extends State<Gerenciamento> {
  late SharedPreferences
      _prefs; // _prefs - armazenar e recuperar dados localmente no dispositivo
  List itens = []; // Armazena os itens que serão exibidos na tela
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    setUpParametros();
    _controller.addListener(() {
      _carregamento();
    });
    super
        .initState(); // Chama setUpParametros para configurar os parâmeteros iniciais da aplicação
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> setUpParametros() async {
    _prefs = await SharedPreferences.getInstance();
    _carregamento(); // Recupera a instância do SharedPreferences e carrega os itens salvos
  }

  Future<void> _irTelaForm({Map? item}) async {
    // Navegação para a tela de formulário
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FormularioPage(item: item),
      ),
    );
    _carregamento(); // Chama o método novamente para atualizar a lista de itens
  }

  Future<void> _carregamento() async {
    // Recupera os itens salvos no SharedPreferences
    var itensSTR = _prefs.getString('itens') ?? '[]'; // Como uma StringJSON
    setState(() {
      itens = jsonDecode(
          itensSTR); // Decodifica a string para um objeto e atualiza a lista de itens
    });
  }

  @override
  Widget build(BuildContext context) {
    // Constroe a interface visual da aplicação
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        title: const Text('Gerenciamento de Itens'),
        actions: [
          IconButton(
            onPressed: () {
              //showSearch(
              //  context: context,
              //  delegate: CustomSearchDelegate(itens),
              //);
            },
            icon: const Icon(Icons.search),
          ),
          IconButton(
            onPressed: _irTelaForm,
            tooltip: 'Adicionar',
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: ListView(
        children: itens
            .map((e) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: ListTile(
                    leading: Container(
                      width: 150,
                      height: 150,
                      child: Image.network(
                        e['imagem'],
                        fit: BoxFit.cover,
                      ),
                    ),
                    title: Text(e['nome']),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(e['descricao']),
                        Text(e['categoria']),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        //IconButton(
                          //onPressed: () => edicao(e),
                          //icon: const Icon(Icons.edit),
                      //  ),
                        IconButton(
                          onPressed: () => _deletar(e),
                          icon: const Icon(Icons.delete),
                        ),
                      ],
                    ),
                  ),
                ))
            .toList(),
      ),
    );
  }

 

  void _deletar(Map item) async {
    // Chamado quando o botao é prssionado
    final shouldDelete = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmação de Deleção'),
          content: const Text('Você deseja deletar este item?'),
          actions: [
            
            TextButton(
              onPressed: () =>
                  Navigator.pop(context, true), // True para deletar
              child: Text('Deletar'),
            ),
            TextButton(
              onPressed: () =>
                  Navigator.pop(context, false), // False para cancelar
              child: Text('Cancelar'),
            ),
          ],
        );
      },
    );
    if (shouldDelete != null && shouldDelete) {
      final _prefs = await SharedPreferences
          .getInstance(); // Armazenar os itens localmente no dispositivo
      var itensSTR = _prefs.getString('itens') ?? '[]';
      List itens = jsonDecode(itensSTR); // Lista dos itens atualizadas

      for (var i = 0; i < itens.length; i++) {
        if (itens[i]['id'] == item['id']) {
          itens.removeAt(i);
          break;
        }
      }
      _prefs.setString('itens', jsonEncode(itens));

      _carregamento();
    }
  }
}
