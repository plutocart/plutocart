import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class GraphRepository {
  final Dio dio = Dio();
  final FlutterSecureStorage storage = FlutterSecureStorage();

  Future<Map<String,dynamic>> getTransactionForGraphByAccountId(int? stmType) async {
    await dotenv.load();
    String? accountId = await storage.read(key: "accountId");
    int acId = int.parse(accountId!);
    try {
      String? token = await storage.read(key: "token");
      Response response = await dio
          .get('${dotenv.env['API']}/api/account/${acId}/graph/${stmType}',
              options: Options(
                headers: {
                  "Authorization": 'Bearer $token',
                  "${dotenv.env['HEADER_KEY']}":
                      dotenv.env['VALUE_HEADER'].toString()
                },
              ),
              queryParameters: {"stm-type": stmType});
      print(
          "respone code in process get graph in class repository: ${response.statusCode}");
      print(
          "respone data in process get graph in class repository: ${response.data}");

      if (response.statusCode == 200 && response.data['data'] != null) {
        return response.data['data'];
      } else {
        throw Exception(
            'Error get Goal from goal repository: ${response.statusCode}');
      }
    } catch (error) {
      print("Error: $error");
      throw error;
    }
  }
}
