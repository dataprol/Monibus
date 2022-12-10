import 'dart:convert';

class Empresas {
  late int? idEmpresa;
  late String? nomeEmpresa;
  late String? identidadeEmpresa;

  Empresas({
    this.idEmpresa,
    this.nomeEmpresa,
    this.identidadeEmpresa,
  });

  factory Empresas.fromMap(Map<String, dynamic> json) => Empresas(
        idEmpresa: json["idEmpresa"],
        nomeEmpresa: json["nomeEmpresa"],
        identidadeEmpresa: json["identidadeEmpresa"],
      );

  Map<String, dynamic> toMap() => {
        "idEmpresa": idEmpresa,
        "nomeEmpresa": nomeEmpresa,
        "identidadeEmpresa": identidadeEmpresa,
      };

  Empresas.fromJson(Map json)
      : idEmpresa = json['idEmpresa'],
        nomeEmpresa = json['nomeEmpresa'],
        identidadeEmpresa = json['identidadeEmpresa'];

  Map<String, dynamic> toJson() => {
        "idEmpresa": idEmpresa,
        "nomeEmpresa": nomeEmpresa,
        "identidadeEmpresa": identidadeEmpresa,
      };

  String pessoasToJson(List<Empresas> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
}
