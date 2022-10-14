import 'package:flutter/material.dart';

const kAplicativo = 'Projeto Monibus';
const kTipoUsuario = 'Monitor'; // Passageiro ou Monitor ou Administrador

final kDicaEstilo_1 = TextStyle(
  color: Colors.grey,
  fontFamily: 'OpenSans',
);

final kEtiquetaCampoEstilo_1 = TextStyle(
  color: Colors.red,
  fontWeight: FontWeight.bold,
  fontFamily: 'OpenSans',
);

const kTabelaCriar = "CREATE TABLE pessoas("
    "idPessoa INTEGER PRIMARY KEY AUTOINCREMENT,"
    "nomePessoa TEXT,"
    "presenca INTEGER"
    "idFacialPessoa TEXT"
    ");";

const kTabelaApagar = "DROP TABLE passageiros;";
