class Usuario {
  int? id;
  String? login;
  String? nome;
  int? nivel;

  Usuario({
    this.id,
    this.login,
    this.nome,
    this.nivel,
  });

  factory Usuario.fromMap(Map<String, dynamic> json) => Usuario(
        id: json["id"],
        login: json["login"],
        nome: json["nome"],
        nivel: json["nivel"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "login": login,
        "nome": nome,
        "nivel": nivel,
      };
}
