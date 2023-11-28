import 'package:dio/dio.dart';
import 'package:plutocart/src/models/wallet/wallet_model.dart';

class walletRepository {
  final dio = Dio();

 Future<dynamic> updateWallet(int accountId, int accountWallet, String walletName, double balanceWallet) async {
  try {
    Response response = await dio.patch(
      'https://capstone23.sit.kmutt.ac.th/ej1/api/account/$accountId/wallet/$accountWallet/wallet-name',
      queryParameters: {
        'wallet-name': walletName,
        'balance-wallet': balanceWallet,
      },
    );
    if (response.statusCode == 200) {
      Wallet wallet = Wallet(walletId: 1, walletName: walletName, statusWallet: 1, walletBalance: balanceWallet);
      return wallet;
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

  Future<Wallet> getWalletById(int accountId) async {
    try {
      Response response = await dio.get(
          'https://capstone23.sit.kmutt.ac.th/ej1/api/account/${accountId}/wallet/1');
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
