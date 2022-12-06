import 'package:dio/dio.dart';
import 'package:monibus/constantes.dart';
import 'package:monibus/model/pessoaModel.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PessoasService {
  late Dio _api;
  late var token;

  PessoasService() {
    _api = Dio();
    lerTokenMemLocal().then((value) => token = value);
    print(token);
    _api.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
      options.headers['Authorization'] = token;
      return handler.next(options);
    }));
  }

  Future<Result<Exception, Pessoa>> listarPessoas() async {
    try {
      late Response response;
      response = await _api.get('$kAPI_URI_Base/pessoas/');
      return Success(Pessoa.fromMap(response.data));
    } on DioError catch (erro) {
      return Error(Exception(erro.response?.statusMessage));
    }
  }

  Future<Result<Exception, Pessoa>> buscarPessoaId({String? idPessoa}) async {
    try {
      late Response response;
      response = await _api.get('$kAPI_URI_Base/pessoas/$idPessoa');
      return Success(Pessoa.fromMap(response.data));
    } on DioError catch (erro) {
      return Error(Exception(erro.response?.statusMessage));
    }
  }

  Future<Result<Exception, String>> inserirPessoa({required pessoa}) async {
    try {
      late Response response;
      response =
          await _api.post('$kAPI_URI_Base/pessoas/', data: pessoa.toJson());
      return Success(response.data);
    } on DioError catch (erro) {
      return Error(Exception(erro.response?.data!));
    }
  }

  Future<String> lerTokenMemLocal() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(kAPI_Chave_Token) ?? '';
  }
}
