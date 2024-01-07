import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:plutocart/src/models/wallet/wallet_model.dart';

class TransactionRepository {
  final dio = Dio();

  Future<Map<String, dynamic>> createTransactionInCome(
      int statementType,
      int WalletId,
      File? file,
      double stmTransaction,
      String dateTransaction,
      String? description,
      int transactionCategoryId) async {
    print("create transaction inCome repository WalletId : ${WalletId}");
    print("create transaction inCome repository file : ${file}");
    print(
        "create transaction inCome repository stmTransaction : ${stmTransaction}");
    print("create transaction inCome repository description : ${description}");
    print(
        "create transaction inCome repository transactionCategoryId : ${transactionCategoryId}");
    try {
      FormData formData;
      if (file == null) {
        formData = FormData.fromMap({
          "stmTransaction": stmTransaction,
          "statementType": statementType,
          "dateTransaction": dateTransaction,
          "description": description,
          "transactionCategoryId": transactionCategoryId,
        });
      } else {
        formData = FormData.fromMap({
          "file": await MultipartFile.fromFile(file.path),
          "stmTransaction": stmTransaction,
          "statementType": 1,
          "dateTransaction": dateTransaction,
          "description": description,
          "transactionCategoryId": transactionCategoryId,
        });
      }

      Response response = await dio.post(
        'https://capstone23.sit.kmutt.ac.th/ej1/api/wallet/${WalletId}/transaction',
        data: formData,
      );
      print(
          "respone code in process create transaction income in class repository: ${response.statusCode}");
      print(
          "respone data in process create transaction income class repository: ${response.data}");

      if (response.statusCode == 201 && response.data['data'] != null) {
        return response.data;
      } else {
        throw Exception(
            'Error Create Guest from login repository: ${response.statusCode}');
      }
    } catch (error) {
      print("Error: $error");
      throw error;
    }
  }

  Future<List<Map<String, dynamic>>> getTransactionDailyInEx() async {
       final storage =  FlutterSecureStorage();
       String? accountId = await storage.read(key: "accountId");
         int accId = int.parse(accountId!);
    try {
      Response response = await dio.get(
          'https://capstone23.sit.kmutt.ac.th/ej1/api/account/${accId}/wallet/transaction/daily-income-and-expense');
      if (response.statusCode == 200) {
        print("retuen getTransaction dailyincome and exp : ${response}");
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
