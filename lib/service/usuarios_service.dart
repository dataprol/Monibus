import 'package:dio/dio.dart';
import 'package:monibus/constantes.dart';
import 'package:multiple_result/multiple_result.dart';

class UsuariosService {
  static Future<Result<Exception, String>> inserirUsuario(
      {required pessoa}) async {
    try {
      late Response response;
      Dio().interceptors.add(LogInterceptor(responseBody: false));
      response = await Dio()
          .post('$kAPI_URI_Base/usuarios/cadastrar', data: pessoa.toJson());
      return Success(response.data);
    } on DioError catch (erro) {
      return Error(Exception(erro.response?.data!));
    }
  }
}
