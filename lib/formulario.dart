import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/categoria_enum.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';


class FormularioPage extends StatefulWidget {
  //SW - Possui estado interno que pode ser modificado
  //final String title; required this.title
  final Map?
      item; // Mapa opicional -> pode conter dados para preenchimento do formulário(edição)
  const FormularioPage({super.key, this.item});


  @override
  State<StatefulWidget> createState() => _FormularioPage();
}


class _FormularioPage extends State<FormularioPage> {
  late SharedPreferences
      _prefs; //= SharedPreferences.getInstance(); //Aramazenar dados localmente no dispositivo
  final _formKey =
      GlobalKey<FormState>(); //Acessar o formulário e validar seus campos
  final _nomeController =
      TextEditingController(); //Capturar o texto digitado no campo do nome
  final _imgController =
      TextEditingController(); //Capturar o texto digitado no campo de URL da imagem
  final _descricaoController =
      TextEditingController(); //Capturar o texto digitado no campo de descricao


  CategoriaEnum? _categoriaEnum;


  /*String? _mensagemValidacaoNome;
  String? _mensagemValidacaoImg;
  String? _mensagemValidacaoDescricao;
  String? _mensagemValidacaoCategoria;*/
  //Usados para armazenar mensagens de validacao para cada campo do formulário


  @override
  void initState() {
    super.initState(); // Chamado quando o estado do widget é inicializado
    setUpParametros(); // Inicializar varaiveis e carregar dados do armazenamento
    print(widget.item); // Imprimir conteudo no console para fins de debugging
  }


  void _validarFormulario() {
    final _formState = _formKey.currentState!;


    if (_formState.validate()) {
      final _nome = _nomeController.text;
      final _img = _imgController.text;
      final _descricao = _descricaoController.text;


      //print('Nome: $_nome');
      //print('Imagem: $_img');
      //print('Descrição: $_descricao');
      //rprint('Categoria: $_categoria');


      // _prefs.setString('nome', _nome);
      // _prefs.setString('imagem', _img);
      //_prefs.setString('descricao', _descricao);
      //_prefs.setString('categoria', _categoria);
      //_prefs.clear();
      //return;
      var itensSTR = _prefs.getString('itens') ??
          '[]'; // Carrega os dados da lista de itens do armazenamento local (itens) ou cria uma lista vazia se não existir
      List itens = jsonDecode(itensSTR);
      var mapJson = {
        // Criar um mapa contendo os dados do formulario
        'nome': _nome,
        'imagem': _img,
        'descricao': _descricao,
        'categoria': _categoriaEnum!.toJson,
      };
      if (widget.item == null) {
        //Adicionar um id ao mapa se for criado um novo item
        var uuid = Uuid();
        mapJson['id'] = uuid.v4();
      } else {
        mapJson['id'] = widget.item!['id'];
      }


      if (widget.item != null) {
        //Caso seja edição ele atualiza o id existente no mapa
        for (var i = 0; i < itens.length; i++) {
          // Percorre a lista de itens procurando o item a ser editado (pelo id) e substitui pelo novo mapa
          if (itens[i]['id'] == widget.item!['id']) {
            itens[i] = mapJson;
            break;
          }
        }
      }
      if (widget.item == null) {
        itens.add(mapJson);
      }
      _prefs.setString('itens', jsonEncode(itens));


      _formState.reset();
      _nomeController.clear();
      _imgController.clear();
      _descricaoController.clear();


      _voltarTelaHome();
    }
  }
 
  void _voltarTelaHome() {
    Navigator.pop(context);
  }


  Future<void> setUpParametros() async {
    _prefs = await SharedPreferences.getInstance();
    if (widget.item != null) {
      _nomeController.text = widget.item!['nome'];
      _imgController.text = widget.item!['imagem'];
      _descricaoController.text = widget.item!['descricao'];
      _categoriaEnum = CategoriaEnum.fromJson(widget.item!['categoria']);
      // Atualize o estado do _categoriaEnum
      setState(() {});
    }
  }


  String? _validarNome(String? valor) {
    if (valor == null || valor.isEmpty) {
      return 'O nome é obrigatório';
    }
  }


  String? _validarImg(String? valor) {
    if (valor == null || valor.isEmpty) {
      return 'O URL da imagem é obrigatório';
    } else if (!valor.endsWith('.jpg') &&
        !valor.endsWith('.png') &&
        !valor.endsWith('.jpeg')) {
      return 'Imagem inválida';
    }
  }


  String? _validarDescricao(String? valor) {
    if (valor == null || valor.isEmpty) {
      return 'A descrição é obrigatória';
    }
  }


  String? _validarCategoria(String? valor) {
    if (valor == null || valor.isEmpty) {
      return 'A categoria é obrigatória';
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nomeController,
                decoration: const InputDecoration(labelText: 'Nome'),
                validator: _validarNome,
                //errorText:
                //_mensagemValidacaoNome, // Exibe a mensagem de validação
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _imgController,
                decoration: const InputDecoration(labelText: 'Imagem'),
                validator: _validarImg,
                //errorText: _mensagemValidacaoEmail,
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _descricaoController,
                decoration: const InputDecoration(labelText: 'Descrição'),
                validator: _validarDescricao,
                //errorText: _mensagemValidacaoEmail,
              ),
              const SizedBox(height: 16.0),
              DropdownButtonFormField<CategoriaEnum>(
                decoration: const InputDecoration(labelText: 'Categoria'),
                value: _categoriaEnum, // Exibe o valor do _categoriaEnum
                onChanged: (CategoriaEnum? novoCategoria) {
                  if (novoCategoria != null) {
                    setState(() {
                      _categoriaEnum = novoCategoria;
                    });
                  }
                },
                items: CategoriaEnum.values
                    .map((opcao) => DropdownMenuItem<CategoriaEnum>(
                          value: opcao,
                          child: Text(opcao.toLabel),
                        ))
                    .toList(),
              ),
              const SizedBox(height: 32.0),
              ElevatedButton(
                onPressed: _validarFormulario, // Chama a função de validação
                child: const Text('Enviar'),
              ),
              const SizedBox(height: 32.0),
              ElevatedButton(
                onPressed: _voltarTelaHome, // Chama a função de validação
                child: const Text('Voltar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}