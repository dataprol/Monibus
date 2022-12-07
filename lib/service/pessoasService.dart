import 'package:dio/dio.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constantes.dart';
import '../model/pessoasModel.dart';

class PessoasService {
  late Dio _api;
  late String token;

  PessoasService() {
    _api = Dio();
    token = '';
    lerTokenMemLocal().then((value) => token = value);
    _api.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
      options.headers['Authorization'] = token;
      return handler.next(options);
    }));
  }

  Future<Result<Exception, List<Pessoas>>> listarPessoas() async {
    try {
      late Response response;
      response = await _api.get('$kAPI_URI_Base/pessoas');
      List<Pessoas> listaPessoas;
      if (response.data['pagination']['itemsTotal'] > 0) {
        listaPessoas = pessoasFromJson2(response.data['data']);
      } else {
        listaPessoas = [];
      }
      print(listaPessoas);

      return Success(listaPessoas);
    } on DioError catch (erro) {
      return Error(Exception(erro.response?.data));
    }
  }

  Future<Result<Exception, Pessoas>> buscarPessoaId({String? idPessoa}) async {
    try {
      late Response response;
      response = await _api.get('$kAPI_URI_Base/pessoas/$idPessoa');
      return Success(Pessoas.fromMap(response.data));
    } on DioError catch (erro) {
      return Error(Exception(erro.response?.statusMessage));
    }
  }

  Future<Result<Exception, String>> inserirPessoa({required pessoa}) async {
    try {
      late Response response;
      response = await _api.post('$kAPI_URI_Base/pessoas/', data: pessoa.toJson());
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
