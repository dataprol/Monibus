import 'package:flutter/material.dart';

const kAplicativoNome = 'Projeto Monibus';
const kTipoUsuario = 'Monitor'; // Passageiro ou Monitor ou Administrador

const kCorPrimaria = Colors.red;

// Estilo visual
final kDicaEstilo_1 = TextStyle(
  color: Colors.grey,
  fontFamily: 'OpenSans',
);

final kEtiquetaCampoEstilo_1 = TextStyle(
  color: kCorPrimaria,
  fontWeight: FontWeight.bold,
  fontFamily: 'OpenSans',
);

// Banco de dados local
const kTabelaPassageiros = "passageiros";
const kTabelaPassageirosColunas = "id INTEGER PRIMARY KEY AUTOINCREMENT" +
    ", nome TEXT" +
    ", presenca INTEGER" +
    ", email TEXT" +
    ", telefone TEXT" +
    ", enderecoLogradouro TEXT" +
    ", enderecoNumero TEXT" +
    ", enderecoBairro TEXT" +
    ", enderecoMunicipio TEXT" +
    ", enderecoUF TEXT" +
    ", enderecoCEP TEXT" +
    ", enderecoIBGE TEXT" +
    ", enderecoSIAFI TEXT" +
    ", enderecoGIA TEXT";
const kTabelaPassageirosCriar = "CREATE TABLE $kTabelaPassageiros($kTabelaPassageirosColunas);";
const kTabelaPassageirosApagar = "DROP TABLE $kTabelaPassageiros;";

// Web API REST
const kAPI_URL_Arquivos = 'http://monibus.tecnologia.ws/assets/files';
const kAPI_URI_Base = 'http://monibus.tecnologia.ws/api';
const kAPI_Chave_Usuario = 'lccrDataprol_usuarioAtual';
const kAPI_Chave_Token = 'lccrDataprol_tokenAtual';
const kAPI_Chave_Empresa = 'lccrDataprol_empresaAtual';
