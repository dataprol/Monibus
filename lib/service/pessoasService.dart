import 'package:dio/dio.dart';
import 'package:monibus/constantes.dart';
import 'package:monibus/model/pessoaModel.dart';
import 'package:multiple_result/multiple_result.dart';

class PessoasService {
  static Future<Result<Exception, Pessoa>> listarPessoas() async {
    try {
      late Response response;
      response = await Dio().get('$kAPI_URI_Base/pessoas/');
      return Success(Pessoa.fromMap(response.data));
    } on DioError catch (erro) {
      return Error(Exception(erro.response?.statusMessage));
    }
  }

  static Future<Result<Exception, Pessoa>> buscarPessoaId(
      {String? idPessoa}) async {
    try {
      late Response response;
      response = await Dio().get('$kAPI_URI_Base/pessoas/$idPessoa');
      return Success(Pessoa.fromMap(response.data));
    } on DioError catch (erro) {
      return Error(Exception(erro.response?.statusMessage));
    }
  }

  static Future<Result<Exception, String>> inserirPessoa(
      {required pessoa}) async {
    try {
      late Response response;
      Dio().interceptors.add(LogInterceptor(responseBody: false));
      response =
          await Dio().post('$kAPI_URI_Base/pessoas/', data: pessoa.toJson());
      return Success(response.data);
    } on DioError catch (erro) {
      return Error(Exception(erro.response?.data!));
    }
  }
}
