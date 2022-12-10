import 'dart:convert';

import 'package:monibus/model/empresas_model.dart';

class Pessoas {
  late int? idPessoa;
  late String? nomePessoa;
  late String? identidadePessoa;
  late String? emailPessoa;
  late String? tipoPessoa;
  late String? usuarioPessoa;
  late String? senhaPessoa;
  late String? dataNascimentoPessoa;
  late String? telefone1Pessoa;
  late String? enderecoLogradouroPessoa;
  late String? enderecoNumeroPessoa;
  late String? enderecoBairroPessoa;
  late String? enderecoMunicipioPessoa;
  late String? enderecoUFPessoa;
  late String? enderecoCEPPessoa;
  late String? enderecoIBGEPessoa;
  late String? enderecoSIAFIPessoa;
  late String? enderecoGIAPessoa;
  late Empresas? empresa;

  Pessoas({
    this.idPessoa,
    this.nomePessoa,
    this.identidadePessoa,
    this.emailPessoa,
    this.tipoPessoa,
    this.usuarioPessoa,
    this.senhaPessoa,
    this.dataNascimentoPessoa,
    this.telefone1Pessoa,
    this.enderecoLogradouroPessoa,
    this.enderecoNumeroPessoa,
    this.enderecoBairroPessoa,
    this.enderecoMunicipioPessoa,
    this.enderecoUFPessoa,
    this.enderecoCEPPessoa,
    this.enderecoIBGEPessoa,
    this.enderecoSIAFIPessoa,
    this.enderecoGIAPessoa,
    this.empresa,
  });

  factory Pessoas.fromMap(Map<String, dynamic> json) => Pessoas(
        idPessoa: json["idPessoa"],
        nomePessoa: json["nomePessoa"],
        identidadePessoa: json["identidadePessoa"],
        emailPessoa: json["emailPessoa"],
        tipoPessoa: json["tipoPessoa"],
        usuarioPessoa: json["usuarioPessoa"],
        senhaPessoa: json["senhaPessoa"],
        dataNascimentoPessoa: json["dataNascimentoPessoa"],
        telefone1Pessoa: json["telefone1Pessoa"],
        enderecoLogradouroPessoa: json["enderecoLogradouroPessoa"],
        enderecoNumeroPessoa: json["enderecoNumeroPessoa"],
        enderecoBairroPessoa: json["enderecoBairroPessoa"],
        enderecoMunicipioPessoa: json["enderecoMunicipioPessoa"],
        enderecoUFPessoa: json["enderecoUFPessoa"],
        enderecoCEPPessoa: json["enderecoCEPPessoa"],
        enderecoIBGEPessoa: json["enderecoIBGEPessoa"],
        enderecoSIAFIPessoa: json["enderecoSIAFIPessoa"],
        enderecoGIAPessoa: json["enderecoGIAPessoa"],
        empresa: json["empresa"],
      );

  Map<String, dynamic> toMap() => {
        "idPessoa": idPessoa,
        "nomePessoa": nomePessoa,
        "identidadePessoa": identidadePessoa,
        "emailPessoa": emailPessoa,
        "tipoPessoa": tipoPessoa,
        "usuarioPessoa": usuarioPessoa,
        "senhaPessoa": senhaPessoa,
        "dataNascimentoPessoa": dataNascimentoPessoa,
        "telefone1Pessoa": telefone1Pessoa,
        "enderecoLogradouroPessoa": enderecoLogradouroPessoa,
        "enderecoNumeroPessoa": enderecoNumeroPessoa,
        "enderecoBairroPessoa": enderecoBairroPessoa,
        "enderecoMunicipioPessoa": enderecoMunicipioPessoa,
        "enderecoUFPessoa": enderecoUFPessoa,
        "enderecoCEPPessoa": enderecoCEPPessoa,
        "enderecoIBGEPessoa": enderecoIBGEPessoa,
        "enderecoSIAFIPessoa": enderecoSIAFIPessoa,
        "enderecoGIAPessoa": enderecoGIAPessoa,
        "empresa": empresa,
      };

  Pessoas.fromJson(Map json)
      : idPessoa = json['idPessoa'],
        nomePessoa = json['nomePessoa'],
        identidadePessoa = json['identidadePessoa'],
        emailPessoa = json['emailPessoa'],
        tipoPessoa = json['tipoPessoa'],
        usuarioPessoa = json['usuarioPessoa'],
        senhaPessoa = json['senhaPessoa'],
        dataNascimentoPessoa = json['dataNascimentoPessoa'],
        telefone1Pessoa = json['telefone1Pessoa'],
        enderecoLogradouroPessoa = json['enderecoLogradouroPessoa'],
        enderecoNumeroPessoa = json['enderecoNumeroPessoa'],
        enderecoBairroPessoa = json['enderecoBairroPessoa'],
        enderecoMunicipioPessoa = json['enderecoMunicipioPessoa'],
        enderecoUFPessoa = json['enderecoUFPessoa'],
        enderecoCEPPessoa = json['enderecoCEPPessoa'],
        enderecoIBGEPessoa = json['enderecoIBGEPessoa'],
        enderecoSIAFIPessoa = json['enderecoSIAFIPessoa'],
        enderecoGIAPessoa = json['enderecoGIAPessoa'],
        empresa = json['empresa'];

  factory Pessoas.fromJson2(Map<String, dynamic> json) => Pessoas(
        idPessoa: json["idPessoa"],
        nomePessoa: json["nomePessoa"],
        identidadePessoa: json["identidadePessoa"],
        emailPessoa: json["emailPessoa"],
        tipoPessoa: json["tipoPessoa"],
        usuarioPessoa: json["usuarioPessoa"],
        senhaPessoa: json["senhaPessoa"],
        dataNascimentoPessoa: json["dataNascimentoPessoa"],
        telefone1Pessoa: json["telefone1Pessoa"],
        enderecoLogradouroPessoa: json["enderecoLogradouroPessoa"],
        enderecoNumeroPessoa: json["enderecoNumeroPessoa"],
        enderecoBairroPessoa: json["enderecoBairroPessoa"],
        enderecoMunicipioPessoa: json["enderecoMunicipioPessoa"],
        enderecoUFPessoa: json["enderecoUFPessoa"],
        enderecoCEPPessoa: json["enderecoCEPPessoa"],
        enderecoIBGEPessoa: json["enderecoIBGEPessoa"],
        enderecoSIAFIPessoa: json["enderecoSIAFIPessoa"],
        enderecoGIAPessoa: json["enderecoGIAPessoa"],
        empresa: json["empresa"],
      );

  Map<String, dynamic> toJson() => {
        "idPessoa": idPessoa,
        "nomePessoa": nomePessoa,
        "identidadePessoa": identidadePessoa,
        "emailPessoa": emailPessoa,
        "tipoPessoa": tipoPessoa,
        "usuarioPessoa": usuarioPessoa,
        "senhaPessoa": senhaPessoa,
        "dataNascimentoPessoa": dataNascimentoPessoa,
        "telefone1Pessoa": telefone1Pessoa,
        "enderecoLogradouroPessoa": enderecoLogradouroPessoa,
        "enderecoNumeroPessoa": enderecoNumeroPessoa,
        "enderecoBairroPessoa": enderecoBairroPessoa,
        "enderecoMunicipioPessoa": enderecoMunicipioPessoa,
        "enderecoUFPessoa": enderecoUFPessoa,
        "enderecoCEPPessoa": enderecoCEPPessoa,
        "enderecoIBGEPessoa": enderecoIBGEPessoa,
        "enderecoSIAFIPessoa": enderecoSIAFIPessoa,
        "enderecoGIAPessoa": enderecoGIAPessoa,
        "empresa": empresa,
      };

  String toJson2() => json.encode(toMap());
}

List<Pessoas> pessoasFromJson(String str) => List<Pessoas>.from(json.decode(str).map((x) => Pessoas.fromJson(x)));
List<Pessoas> pessoasFromJson2(String str) => List<Pessoas>.from(json.decode(str).map((x) => Pessoas.fromJson2(x)));

String pessoasToJson(List<Pessoas> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
