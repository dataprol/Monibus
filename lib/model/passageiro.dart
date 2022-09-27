class Passageiro {
  int id;
  String nome;
  bool presenca;

  Passageiro({
    this.id = 0,
    this.nome = '',
    this.presenca = false,
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
