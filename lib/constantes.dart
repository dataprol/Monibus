import 'package:flutter/material.dart';

const kAplicativoNome = 'Projeto Monibus';
const kTipoUsuario = 'Monitor'; // Passageiro ou Monitor ou Administrador

// Estilo visual
final kDicaEstilo_1 = TextStyle(
  color: Colors.grey,
  fontFamily: 'OpenSans',
);

final kEtiquetaCampoEstilo_1 = TextStyle(
  color: Colors.red,
  fontWeight: FontWeight.bold,
  fontFamily: 'OpenSans',
);

// Banco de dados local
const kLocalTabelaPassageiros = "passageiros";
const kColunas =
    "idPessoa INTEGER PRIMARY KEY AUTOINCREMENT, nomePessoa TEXT, presenca INTEGER, idFacialPessoa TEXT";
const kTabelaCriar = "CREATE TABLE $kLocalTabelaPassageiros($kColunas);";
const kTabelaApagar = "DROP TABLE $kLocalTabelaPassageiros;";

// Web API REST
const kAPI_URI_Base = 'http://monibus.tecnologia.ws/api';
const kAPI_Chave_Usuario = 'lccrDataprol_usuarioAtual';
const kAPI_Chave_Token = 'lccrDataprol_tokenAtual';
