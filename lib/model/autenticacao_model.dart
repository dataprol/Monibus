import 'dart:convert';
import 'package:string_validator/string_validator.dart' as validador;

class AutenticacaoModel {
  AutenticacaoModel({
    this.usuario,
    this.senha,
  });

  late final String? usuario;
  late final String? senha;

  AutenticacaoModel copyWith({
    String? usuario,
    String? password,
  }) =>
      AutenticacaoModel(
        usuario: usuario ?? '',
        senha: senha ?? '',
      );

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
        "login": usuario,
        "password": senha,
      };

  bool get validoSenha =>
      senha != null && senha!.isNotEmpty && senha!.length > 5;

  bool get validoSenhaNova =>
      senha != null &&
      senha!.isNotEmpty &&
      senha!.length > 7 &&
      !validador.isNumeric(senha!) &&
      !validador.isAlpha(senha!) &&
      validador.isAlphanumeric(senha!);

  bool get validoUsuario =>
      usuario != null &&
      usuario!.length > 3 &&
      usuario!.isNotEmpty &&
      !validador.isNumeric(usuario!);
}
