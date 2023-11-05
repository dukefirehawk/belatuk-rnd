import 'package:angel3_container/mirrors.dart';
import 'package:angel3_framework/angel3_framework.dart';
import 'package:angel3_framework/http.dart';
import 'package:angel3_test/angel3_test.dart';
import 'package:angel3_validate/server.dart';
import 'package:logging/logging.dart';
import 'package:test/test.dart';

void main() async {
  late Angel app;
  late AngelHttp http;
  late TestClient client;

  void printRecord(LogRecord rec) {
    print('${rec.time}: ${rec.level.name}: ${rec.loggerName}: ${rec.message}');
    if (rec.error != null) print(rec.error);
    if (rec.stackTrace != null) print(rec.stackTrace);
  }

  Matcher isEquals(dynamic expectVal) {
    return predicate((dynamic value) {
      print('value: $value, expectVal: $expectVal');

      return value == expectVal;
    }, 'is Equals $expectVal');
  }

  final Validator echoSchema = Validator({'messa*': isString});

  final Validator orderItemSchema = Validator({
    'id': [isInt, isPositive],
    'item_no': isString,
    'item_name': isString,
    'quantity': [isInt, isEquals(10)],
    'description?': isString
  });

  final Validator orderSchema = Validator({
    'id': [isInt, isPositive],
    'order_no': isString,
    'order_items*': [isList, everyElement(orderItemSchema)]
  }, defaultValues: {
    'order_items': []
  });

  setUp(() async {
    app = Angel(reflector: MirrorsReflector());
    http = AngelHttp(app, useZone: false);

    var orderItem = {
      'id': 1,
      'item_no': 'a1',
      'item_name': 'Apple',
      'quantity': 11,
      'description': 1
    };

    var formData = {
      'id': 1,
      'order_no': '2',
      'order_items': [orderItem]
    };

    // app.chain([validate(orderSchema)]).get()
    app.get('/echo', (RequestContext req, res) async {
      await req.parseBody();
      res.json(formData);
      //res.write('Hello, ${req.bodyAsMap['message']}!');
    });

    app.logger = Logger('angel3')..onRecord.listen(printRecord);
    client = await connectTo(app);
  });

  tearDown(() async {
    await client.close();
    await http.close();
  });

  group('server', () {
    test('validate', () async {
      var response =
          await client.get(Uri.parse('/echo'), headers: {'accept': '*/*'});
      //print('Response: ${response.body}');
      expect(
          response,
          allOf([
            hasStatus(200),
            hasContentType('application/json'),
            hasValidBody(orderSchema)
          ]));
    });
  });

  group('json', () {
    test('test simple matcher', () {
      var a = "ABA";
      var b = "ABA";

      expect(a, equals(b));
    });

    test('test json matcher', () {
      var data = {'statusCode': 200};

      var validator1 = Validator({'statusCode': isInt});

      expect(data, allOf([hasValidBody(validator1)]));
      /*
    print('Test 2');
    var res = {
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

    expect(
        res,
        allOf([
          hasStatus(200),
          hasValidBody(Validator({
            'cod_processo': isInt,
            'ano_exercicio': isEquals('2023'),
            'cod_classificacao': isEquals(169),
            'cod_assunto': isEquals(1),
            'numcgm': isEquals(140050),

            //here I simulate that I get a wrong value
            //'cod_usuario': isEquals(14005025),
          }))
        ]));
        */
    });
  }, skip: true);
}

/*
Matcher hasStatus(int expectVal) {
  return predicate((dynamic value) {
    var statusCode = value['statusCode'];
    print('$statusCode == $expectVal');
    return statusCode == expectVal;
  }, 'is statusCode 400');
}
*/

