import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:monibus/constantes.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/autenticacao_model.dart';

class AutenticacaoService {
  late Dio _api;
  late AutenticacaoModel login;

  AutenticacaoService() {
    _api = Dio();
    _api.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
      return handler.next(options);
    }));
  }

  Future<Result<String, Response>> validarUsuario(AutenticacaoModel login) async {
    late Response response;
    try {
      response = await _api.post('$kAPI_URI_Base/usuarios/vlogin', data: {'username': '${login.usuario}', 'password': '${login.senha}'});
      var retorno = response.data['data']['token'];
      retorno ??= '';
      if (kDebugMode) {
        print(response.statusCode);
        print(response.statusMessage);
        print(response.data['data']);
      }
      return Success(response);
    } on DioError catch (erro) {
      var retorno = erro.response?.data['data']['message'];
      retorno ??= erro.response.toString();
      if (kDebugMode) {
        print(erro.response?.statusCode);
        print(erro.response?.statusMessage);
        print(erro.error);
        print(erro.message);
      }
      return Error((retorno));
    }
  }

  Future<Result<String, Response>> validarToken(String token) async {
    late Response response;
    try {
      _api.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
        options.headers['Authorization'] = token;
        return handler.next(options);
      }));
      response = await _api.post('$kAPI_URI_Base/usuarios/vtoken');
      var retorno = response.data['message'];
      retorno ??= '';
      return Success(response);
    } on DioError catch (erro) {
      var retorno = erro.response?.data['data']['message'];
      retorno ??= erro.response.toString();
      return Error((retorno));
    }
  }

  Future<bool> desconectarUsuario(context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(kAPI_Chave_UsuarioNome);
    await prefs.remove(kAPI_Chave_Token);
    exit(0);
  }

  Future<String> lerUsuarioMemLocal() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(kAPI_Chave_UsuarioNome) ?? '';
  }

  Future<String> lerTokenMemLocal() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(kAPI_Chave_Token) ?? '';
  }

  Future<bool> salvarUsuarioMemLocal(String cUsuario, String cToken) async {
    final prefs = await SharedPreferences.getInstance();
    if (await prefs.setString(kAPI_Chave_UsuarioNome, cUsuario)) return true;
    if (await prefs.setString(kAPI_Chave_Token, cToken)) return true;
    return false;
  }

  Future<bool> removerUsuarioMemLocal() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    if (await prefs.remove(kAPI_Chave_UsuarioNome)) return true;
    if (await prefs.remove(kAPI_Chave_Token)) return true;
    return false;
  }
}
