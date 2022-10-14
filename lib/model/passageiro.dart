class Passageiro {
  int? id;
  String? nome;
  int? presenca;

  Passageiro({
    this.id,
    this.nome,
    this.presenca,
  });

  factory Passageiro.fromMap(Map<String, dynamic> json) => Passageiro(
        id: json["id"],
        nome: json["nome"],
        presenca: json["presenca"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "nome": nome,
        "presenca": presenca,
      };
}
