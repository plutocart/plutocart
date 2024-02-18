import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class DebtRepository {
  final Dio dio = Dio();
  final FlutterSecureStorage storage = FlutterSecureStorage();

  Future<Map<String, dynamic>> updateDebt(
      int debtId,
      String nameOfYourDebt,
      double totalDebt,
      int totalPeriod,
      int paidPeriod,
      double monthlyPayment,
      double debtPaid,
      String moneyLender,
      String latestPayDate) async {
    String? accountId = await storage.read(key: "accountId");
    String? token = await storage.read(key: "token");
    int id = int.parse(accountId!);
    try {
      print("start update goal");
      Response response = await dio.patch(
        '${dotenv.env['API']}/api/account/${id}/debt/${debtId}',
        queryParameters: {
          "nameDebt": nameOfYourDebt,
          "amountDebt": totalDebt,
          "payPeriod": totalPeriod,
          "numOfPaidPeriod": paidPeriod,
          "paidDebtPerPeriod": monthlyPayment,
          "totalPaidDebt": debtPaid,
          "moneyLender": moneyLender,
          "latestPayDate": latestPayDate
        },
        options: Options(
          headers: {
            "Authorization": 'Bearer $token',
            "${dotenv.env['HEADER_KEY']}": dotenv.env['VALUE_HEADER'].toString()
          },
        ),
      );

      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('Error: ${'404'}');
      }
    } catch (error) {
      print("Error update debt $error");
      throw error;
    }
  }

  Future<List<dynamic>> getDebtByAccountId() async {
    await dotenv.load();
    String? accountId = await storage.read(key: "accountId");
    int acId = int.parse(accountId!);
    try {
      String? token = await storage.read(key: "token");
      Response response = await dio.get(
        '${dotenv.env['API']}/api/account/${acId}/debt',
        options: Options(
          headers: {
            "Authorization": 'Bearer $token',
            "${dotenv.env['HEADER_KEY']}": dotenv.env['VALUE_HEADER'].toString()
          },
        ),
      );
      print(
          "respone code in process get debt in class repository: ${response.statusCode}");
      print(
          "respone data in process get debt in class repository: ${response.data}");

      if (response.statusCode == 200 && response.data['data'] != null) {
        return response.data['data'];
      } else {
        throw Exception(
            'Error get debt from debt repository: ${response.statusCode}');
      }
    } catch (error) {
      print("Error: $error");
      throw error;
    }
  }

  Future<Map<String, dynamic>> createDebtByAccountId(
    String nameOfYourDebt,
    double totalDebt,
    int totalPeriod,
    int paidPeriod,
    double monthlyPayment,
    double debtPaid,
    String moneyLender,
    String debtDate,
  ) async {
    await dotenv.load();
    String? accountId = await storage.read(key: "accountId");
    int acId = int.parse(accountId!);
    try {
      String? token = await storage.read(key: "token");
      Response response = await dio.post(
        '${dotenv.env['API']}/api/account/${acId}/debt',
        options: Options(
          headers: {
            "Authorization": 'Bearer $token',
            "${dotenv.env['HEADER_KEY']}": dotenv.env['VALUE_HEADER'].toString()
          },
        ),
        queryParameters: {
          "nameDebt": nameOfYourDebt,
          "amountDebt": totalDebt,
          "payPeriod": totalPeriod,
          "numOfPaidPeriod": paidPeriod,
          "paidDebtPerPeriod": monthlyPayment,
          "totalPaidDebt": debtPaid,
          "moneyLender": moneyLender,
          "latestPayDate": debtDate
        },
      );
      print(
          "respone code in process create debbt in class repository: ${response.statusCode}");
      print(
          "respone data in process create debt in class repository: ${response.data}");

      if (response.statusCode == 201 && response.data['data'] != null) {
        return response.data;
      } else {
        throw Exception(
            'Error Create debt from debt repository: ${response.statusCode}');
      }
    } catch (error) {
      print("Error: $error");
      throw error;
    }
  }

  Future<Map<String, dynamic>> deleteDebt(int debtId) async {
    final storage = new FlutterSecureStorage();
    String? accountId = await storage.read(key: "accountId");
    int id = int.parse(accountId!);
    String? token = await storage.read(key: "token");
    print("id account in step deleteAccountById : ${id}");
    try {
      Response response = await dio.delete(
          '${dotenv.env['API']}/api/account/${id}/debt/${debtId}',
          options: Options(
            headers: {
              "Authorization": 'Bearer $token',
              "${dotenv.env['HEADER_KEY']}":
                  dotenv.env['VALUE_HEADER'].toString()
            },
          ));
      if (response.statusCode == 200) {
        print("delete debt id : ${debtId} : success");
        return response.data;
      } else if (response.statusCode == 404) {
        throw Exception('Resource not found');
      } else {
        throw Exception('Unexpected error occurred: ${response.statusCode}');
      }
    } catch (error, stacktrace) {
      print("Error: $error - Stacktrace: $stacktrace");
      throw error;
    }
  }
}
