import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class TransactionCategoryRepository{
  final Dio dio = Dio();



  Future<dynamic> getTransactionTypeIncome() async {
    try {
      print("start trasaction income in getTransactionTypeIncome Repository");
      Response  response = await dio.get('${dotenv.env['API']}/api/transaction-category/income' , 
      options: Options(
         headers: { "${dotenv.env['HEADER_KEY']}" : dotenv.env['VALUE_HEADER'].toString()},
      ));
        print("check status code get transaction category repository income : ${response.statusCode} ");
        if(response.statusCode == 200){
            Map<String , dynamic> transactionCategory =  response.data;
          return transactionCategory;
        }
      return response.data;
    } catch (error, stacktrace) {
      print("Error: $error - Stacktrace: $stacktrace");
      throw error;
    }
  }

  Future<dynamic> getTransactionTypeExpense() async {
    try {
      print("start trasaction income in getTransactionTypeExpense Repository");
      Response  response = await dio.get('${dotenv.env['API']}/api/transaction-category/expense', 
      options: Options(
         headers: { "${dotenv.env['HEADER_KEY']}" : dotenv.env['VALUE_HEADER'].toString()},
      ) );
        print("check status code get transaction category repository income : ${response.statusCode} ");
        if(response.statusCode == 200){
            Map<String , dynamic> transactionCategory =  response.data;
          return transactionCategory;
        }
      return response.data;
    } catch (error, stacktrace) {
      print("Error: $error - Stacktrace: $stacktrace");
      throw error;
    }
  }
}