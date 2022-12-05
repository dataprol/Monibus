import 'dart:convert';

List<Passageiro> passageiroFromJson(String str) =>
    List<Passageiro>.from(json.decode(str).map((x) => Passageiro.fromJson(x)));

String passageiroToJson(List<Passageiro> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Passageiro {
  int? id;
  String? nome;
  int? presenca;
  String? email;
  String? telefone;
  String? enderecoLogradouro;
  String? enderecoNumero;
  String? enderecoBairro;
  String? enderecoMunicipio;
  String? enderecoUF;
  String? enderecoCEP;
  String? enderecoIBGE;
  String? enderecoSIAFI;
  String? enderecoGIA;
  Passageiro({
    this.id,
    this.nome,
    this.presenca,
    this.email,
    this.telefone,
    this.enderecoLogradouro,
    this.enderecoNumero,
    this.enderecoBairro,
    this.enderecoMunicipio,
    this.enderecoUF,
    this.enderecoCEP,
    this.enderecoIBGE,
    this.enderecoSIAFI,
    this.enderecoGIA,
  });

  factory Passageiro.fromJson(Map<String, dynamic> json) => Passageiro(
        id: json["id"],
        nome: json["nome"],
        presenca: json["presenca"],
        email: json["email"],
        telefone: json["telefone"],
        enderecoLogradouro: json["enderecoLogradouro"],
        enderecoNumero: json["enderecoNumero"],
        enderecoBairro: json["enderecoBairro"],
        enderecoMunicipio: json["enderecoMunicipio"],
        enderecoUF: json["enderecoUF"],
        enderecoCEP: json["enderecoCEP"],
        enderecoIBGE: json["enderecoIBGE"],
        enderecoSIAFI: json["enderecoSIAFI"],
        enderecoGIA: json["enderecoGIA"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nome": nome,
        "presenca": presenca,
        "email": email,
        "telefone": telefone,
        "enderecoLogradouro": enderecoLogradouro,
        "enderecoNumero": enderecoNumero,
        "enderecoBairro": enderecoBairro,
        "enderecoMunicipio": enderecoMunicipio,
        "enderecoUF": enderecoUF,
        "enderecoCEP": enderecoCEP,
        "enderecoIBGE": enderecoIBGE,
        "enderecoSIAFI": enderecoSIAFI,
        "enderecoGIA": enderecoGIA,
      };
}
