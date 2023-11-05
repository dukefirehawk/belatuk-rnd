import 'package:angel3_validate/angel3_validate.dart';

void main() async {
  var data_orig = {
    'statusCode': 200,
    'body': {
      'cod_processo': -1,
      'ano_exercicio': '2023',
      'cod_classificacao': 169,
      'cod_assunto': 1,
      'numcgm': 140050,
      'cod_usuario': 140050,
      'cod_situacao': 2,
      'timestamp': '2023-10-09T11:09:01.955',
      'observacoes': 'Objeto teste',
      'confidencial': false,
      'resumo_assunto': 'Assunto teste',
      'id_setor': 524,
      'andamentos': [
        {
          'cod_andamento': 1,
          'cod_processo': -1,
          'ano_exercicio': '2023',
          'cod_orgao': 2,
          'cod_unidade': 89,
          'cod_departamento': 2,
          'cod_setor': 1,
          'ano_exercicio_setor': '2003',
          'cod_usuario': 140050,
          'timestamp': '2023-10-09T11:09:01.955',
          'nome_setor_destino': 'TI - Tecnologia da Informação'
        }
      ],
      'atributosProtocolo': [
        {
          'cod_atributo': 1,
          'nom_atributo': 'Anotações',
          'tipo': 't',
          'valor_padrao': '',
          'valor': 'Anotações teste'
        }
      ],
      'nome_interessado': "Isaque Neves Sant'ana",
      'nom_assunto': 'Abono de permanência'
    }
  };

  var data = {
    'statusCode': 200,
    'body': {
      'id_setor': 524,
      'confidencial': false,
      'andamentos': [
        {'ano_exercicio': 2023}
      ]
    }
  };

  var field1 = filter(data, ['body']);
  print(field1.entries);

  var schema = {
    'body': {
      'id_setor': isInt,
      'confidencial': isBool,
      'andamentos': [
        {'ano_exercicio': isInt}
      ]
    }
  };
  var validator = Validator(schema);

  var result = validator.check(data);

  if (result.errors.isEmpty) {
    print("Pass");
  } else {
    print("Fail");
    print(result.errors);
  }
}

Matcher isEquals(expectVal) {
  return predicate((dynamic value) {
    print('isEquals value: $value == $expectVal');
    return value == expectVal;
  }, 'is Equals');
}
