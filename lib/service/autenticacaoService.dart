import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:monibus/constantes.dart';
import 'package:multiple_result/multiple_result.dart';

import '../model/autenticacaoModel.dart';

class AutenticacaoService {
  late Dio _api;
  late AutenticacaoModel login;

  AutenticacaoService() {
    _api = Dio();
    _api.interceptors.add(LogInterceptor(responseBody: false));
    _api.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
      return handler.next(options);
    }));
  }

  Future<Result<Exception, Response>> validarUsuario(
      AutenticacaoModel login) async {
    try {
      late Response response;
      response = await _api.post('$kAPI_URI_Base/usuarios/vlogin',
          data:
              '{"username": "${login.usuario}","password": "${login.senha}"}');
      return Success(jsonDecode(response.data));
    } on DioError catch (erro) {
      return Error(Exception(erro.response?.data));
    }
  }

  Future<Result<Exception, String>> validarToken(String token) async {
    try {
      late Response response;
      response = await _api.post('$kAPI_URI_Base/usuarios/vtoken');
      return Success(jsonDecode(response.data));
    } on DioError catch (erro) {
      return Error(Exception(erro.response?.statusMessage));
    }
  }
}
