import 'dart:convert';

List<Passageiro> employeeFromJson(String str) =>
    List<Passageiro>.from(json.decode(str).map((x) => Passageiro.fromJson(x)));

String employeeToJson(List<Passageiro> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Passageiro {
  int? idPassageiro;
  String? nomePassageiro;
  String? identidadePassageiro;
  String? emailPassageiro;
  String? tipoPassageiro;
  String? usuarioPassageiro;
  String? senhaPassageiro;
  String? dataNascimentoPassageiro;
  String? telefone1Passageiro;
  String? enderecoLogradouroPassageiro;
  String? enderecoNumeroPassageiro;
  String? enderecoBairroPassageiro;
  String? enderecoMunicipioPassageiro;
  String? enderecoUFPassageiro;
  String? enderecoCEPPassageiro;
  String? enderecoIBGEPassageiro;
  String? enderecoSIAFIPassageiro;
  String? enderecoGIAPassageiro;
  int? presenca;

  Passageiro({
    this.idPassageiro,
    this.nomePassageiro,
    this.identidadePassageiro,
    this.emailPassageiro,
    this.tipoPassageiro,
    this.usuarioPassageiro,
    this.senhaPassageiro,
    this.dataNascimentoPassageiro,
    this.telefone1Passageiro,
    this.enderecoLogradouroPassageiro,
    this.enderecoNumeroPassageiro,
    this.enderecoBairroPassageiro,
    this.enderecoMunicipioPassageiro,
    this.enderecoUFPassageiro,
    this.enderecoCEPPassageiro,
    this.enderecoIBGEPassageiro,
    this.enderecoSIAFIPassageiro,
    this.enderecoGIAPassageiro,
    this.presenca,
  });

  factory Passageiro.fromJson(Map<String, dynamic> json) => Passageiro(
        idPassageiro: json["idPassageiro"],
        nomePassageiro: json["nomePassageiro"],
        identidadePassageiro: json["identidadePassageiro"],
        emailPassageiro: json["emailPassageiro"],
        tipoPassageiro: json["tipoPassageiro"],
        usuarioPassageiro: json["usuarioPassageiro"],
        senhaPassageiro: json["senhaPassageiro"],
        dataNascimentoPassageiro: json["dataNascimentoPassageiro"],
        telefone1Passageiro: json["telefone1Passageiro"],
        enderecoLogradouroPassageiro: json["enderecoLogradouroPassageiro"],
        enderecoNumeroPassageiro: json["enderecoNumeroPassageiro"],
        enderecoBairroPassageiro: json["enderecoBairroPassageiro"],
        enderecoMunicipioPassageiro: json["enderecoMunicipioPassageiro"],
        enderecoUFPassageiro: json["enderecoUFPassageiro"],
        enderecoCEPPassageiro: json["enderecoCEPPassageiro"],
        enderecoIBGEPassageiro: json["enderecoIBGEPassageiro"],
        enderecoSIAFIPassageiro: json["enderecoSIAFIPassageiro"],
        enderecoGIAPassageiro: json["enderecoGIAPassageiro"],
        presenca: json["presenca"],
      );

  Map<String, dynamic> toJson() => {
        "idPassageiro": idPassageiro,
        "nomePassageiro": nomePassageiro,
        "identidadePassageiro": identidadePassageiro,
        "emailPassageiro": emailPassageiro,
        "tipoPassageiro": tipoPassageiro,
        "usuarioPassageiro": usuarioPassageiro,
        "senhaPassageiro": senhaPassageiro,
        "dataNascimentoPassageiro": dataNascimentoPassageiro,
        "telefone1Passageiro": telefone1Passageiro,
        "enderecoLogradouroPassageiro": enderecoLogradouroPassageiro,
        "enderecoNumeroPassageiro": enderecoNumeroPassageiro,
        "enderecoBairroPassageiro": enderecoBairroPassageiro,
        "enderecoMunicipioPassageiro": enderecoMunicipioPassageiro,
        "enderecoUFPassageiro": enderecoUFPassageiro,
        "enderecoCEPPassageiro": enderecoCEPPassageiro,
        "enderecoIBGEPassageiro": enderecoIBGEPassageiro,
        "enderecoSIAFIPassageiro": enderecoSIAFIPassageiro,
        "enderecoGIAPassageiro": enderecoGIAPassageiro,
        "presenca": presenca,
      };
}
