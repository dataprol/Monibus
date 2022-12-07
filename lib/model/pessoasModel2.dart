class PessoaModel2 {
  late String? idPessoa;
  late String? nomePessoa;
  late String? identidadePessoa;
  late String? emailPessoa;
  late String? tipoPessoa;
  late String? usuarioPessoa;
  late String? senhaPessoa;
  late String? dataNascimentoPessoa;
  late String? telefone1Pessoa;
  late String? enderecoLogradouroPessoa;
  late String? enderecoNumeroPessoa;
  late String? enderecoBairroPessoa;
  late String? enderecoMunicipioPessoa;
  late String? enderecoUFPessoa;
  late String? enderecoCEPPessoa;
  late String? enderecoIBGEPessoa;
  late String? enderecoSIAFIPessoa;
  late String? enderecoGIAPessoa;
  late String? presencaPessoa;

  PessoaModel2({
    this.idPessoa,
    this.nomePessoa,
    this.identidadePessoa,
    this.emailPessoa,
    this.tipoPessoa,
    this.usuarioPessoa,
    this.senhaPessoa,
    this.dataNascimentoPessoa,
    this.telefone1Pessoa,
    this.enderecoLogradouroPessoa,
    this.enderecoNumeroPessoa,
    this.enderecoBairroPessoa,
    this.enderecoMunicipioPessoa,
    this.enderecoUFPessoa,
    this.enderecoCEPPessoa,
    this.enderecoIBGEPessoa,
    this.enderecoSIAFIPessoa,
    this.enderecoGIAPessoa,
    this.presencaPessoa,
  });

  PessoaModel2.fromJson(Map json)
      : idPessoa = json['idPessoa'],
        nomePessoa = json['nomePessoa'],
        identidadePessoa = json['identidadePessoa'],
        emailPessoa = json['emailPessoa'],
        tipoPessoa = json['tipoPessoa'],
        usuarioPessoa = json['usuarioPessoa'],
        senhaPessoa = json['senhaPessoa'],
        dataNascimentoPessoa = json['dataNascimentoPessoa'],
        telefone1Pessoa = json['telefone1Pessoa'],
        enderecoLogradouroPessoa = json['enderecoLogradouroPessoa'],
        enderecoNumeroPessoa = json['enderecoNumeroPessoa'],
        enderecoBairroPessoa = json['enderecoBairroPessoa'],
        enderecoMunicipioPessoa = json['enderecoMunicipioPessoa'],
        enderecoUFPessoa = json['enderecoUFPessoa'],
        enderecoCEPPessoa = json['enderecoCEPPessoa'],
        enderecoIBGEPessoa = json['enderecoIBGEPessoa'],
        enderecoSIAFIPessoa = json['enderecoSIAFIPessoa'],
        enderecoGIAPessoa = json['enderecoGIAPessoa'],
        presencaPessoa = json['presencaPessoa'];

  Map<String, dynamic> toJson() => {
        "idPessoa": idPessoa,
        "nomePessoa": nomePessoa,
        "identidadePessoa": identidadePessoa,
        "emailPessoa": emailPessoa,
        "tipoPessoa": tipoPessoa,
        "usuarioPessoa": usuarioPessoa,
        "senhaPessoa": senhaPessoa,
        "dataNascimentoPessoa": dataNascimentoPessoa,
        "telefone1Pessoa": telefone1Pessoa,
        "enderecoLogradouroPessoa": enderecoLogradouroPessoa,
        "enderecoNumeroPessoa": enderecoNumeroPessoa,
        "enderecoBairroPessoa": enderecoBairroPessoa,
        "enderecoMunicipioPessoa": enderecoMunicipioPessoa,
        "enderecoUFPessoa": enderecoUFPessoa,
        "enderecoCEPPessoa": enderecoCEPPessoa,
        "enderecoIBGEPessoa": enderecoIBGEPessoa,
        "enderecoSIAFIPessoa": enderecoSIAFIPessoa,
        "enderecoGIAPessoa": enderecoGIAPessoa,
        "presencaPessoa": presencaPessoa,
      };
}
