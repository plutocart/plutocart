import 'dart:math';

import 'package:dio/dio.dart';
import 'package:plutocart/src/models/wallet/wallet_model.dart';

class walletRepository {
  final dio = Dio();

  Future createWallet(int accountId , String walletName , double walletBalance) async {
    try {
      Map<String, dynamic> requestBody = {
      "walletName": walletName,
      "walletBalance": walletBalance,
    };

      Response response = await dio.post('https://capstone23.sit.kmutt.ac.th/ej1/api/account/${accountId}/wallet' , data: requestBody);
      if (response.statusCode == 201) {
          print("create successfully");
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

  Future deleteWalletById(int accountId  , int walletId) async {
    try {
      Response response = await dio.delete(
          'https://capstone23.sit.kmutt.ac.th/ej1/api/account/${accountId}/wallet/${walletId}');
      if (response.statusCode == 200) {
           log(1);
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

 Future<dynamic> updateWallet(int accountId, int walletId, String walletName, double balanceWallet) async {
  try {
    Response response = await dio.patch(
      'https://capstone23.sit.kmutt.ac.th/ej1/api/account/$accountId/wallet/$walletId/wallet-name',
      queryParameters: {
        'wallet-name': walletName,
        'balance-wallet': balanceWallet,
      },
    );
    if (response.statusCode == 200) {
      Wallet wallet = Wallet(walletId: walletId, walletName: walletName, walletBalance: balanceWallet);
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

  Future<Wallet> updateStatusWallet(int accountId , int walletId) async {
    try {
      Response response = await dio.patch(
          'https://capstone23.sit.kmutt.ac.th/ej1/api/account/$accountId/wallet/$walletId/wallet-status');
      if (response.statusCode == 200) {
        Wallet wallet = Wallet(walletId: walletId  , walletName: "" , walletBalance: 0.0);
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
        List<dynamic> wallets = response.data!;
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

  Future<dynamic> getWalletAllStatusOn(int accountId) async {
    try {
      Response response = await dio.get(
          'https://capstone23.sit.kmutt.ac.th/ej1/api/account/${accountId}/wallet/status-on');
      if (response.statusCode == 200) {
        List<dynamic> wallets = response.data!;
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

  Future<Wallet> getWalletById(int accountId , int walletId) async {
    try {
      Response response = await dio.get(
          'https://capstone23.sit.kmutt.ac.th/ej1/api/account/${accountId}/wallet/${walletId}');
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
