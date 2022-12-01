import 'dart:convert';

class Pessoa {
  int? idPessoa;
  String? nomePessoa;
  String? identidadePessoa;
  String? emailPessoa;
  String? tipoPessoa;
  String? usuarioPessoa;
  String? senhaPessoa;
  String? dataNascimentoPessoa;
  String? telefone1Pessoa;
  String? enderecoLogradouroPessoa;
  String? enderecoNumeroPessoa;
  String? enderecoBairroPessoa;
  String? enderecoMunicipioPessoa;
  String? enderecoUFPessoa;
  String? enderecoCEPPessoa;
  String? enderecoIBGEPessoa;
  String? enderecoSIAFIPessoa;
  String? enderecoGIAPessoa;

  Pessoa({
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
  });

  factory Pessoa.fromMap(Map<String, dynamic> json) => Pessoa(
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
      };

  factory Pessoa.fromJson(String str) => Pessoa.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());
}
