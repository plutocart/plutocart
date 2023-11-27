import 'package:dio/dio.dart';
import 'package:plutocart/src/models/wallet/wallet_model.dart';

class walletRepository {
  final dio = Dio();

  Future<dynamic> getWalletAll(int accountId) async {
    try {
      Response response = await dio.get(
          'https://capstone23.sit.kmutt.ac.th/ej1/api/account/${accountId}/wallet');
      if (response.statusCode == 200) {
        List<Wallet> wallets = response.data;
        return wallets;
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

  Future<Wallet> getWalletById(int id) async {
    try {
      Response response = await dio.get(
          'https://capstone23.sit.kmutt.ac.th/ej1/api/account/${id}/wallet/1');
      if (response.statusCode == 200) {
        Wallet responseData = Wallet.fromJson(response.data);
        return responseData;
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
