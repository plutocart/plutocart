import 'package:dio/dio.dart';

class TransactionCategoryRepository{
  final Dio dio = Dio();



  Future<dynamic> getTransactionTypeIncome() async {
    try {
      print("start trasaction income in getTransactionTypeIncome Repository");
      Response  response = await dio.get('https://capstone23.sit.kmutt.ac.th/ej1/api/transaction-category/income');
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
      Response  response = await dio.get('https://capstone23.sit.kmutt.ac.th/ej1/api/transaction-category/expense');
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