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
      expect(response,
          allOf([hasStatus(200), hasContentType('application/json')]));
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
    });
  }, skip: true);
}
