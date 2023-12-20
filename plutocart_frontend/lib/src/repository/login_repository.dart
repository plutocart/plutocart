import 'package:dio/dio.dart';
import 'package:plutocart/src/models/wallet/wallet_model.dart';

class LoginRespository{
final dio = Dio();

  Future<Wallet> loginGuest(int id) async {

    try {
      Response response = await dio.get('https://capstone23.sit.kmutt.ac.th/ej1/api/account/${id}/wallet/1');
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