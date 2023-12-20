import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:plutocart/src/models/login/login_model.dart';
import 'package:plutocart/src/models/wallet/wallet_model.dart';

class LoginRespository{
final dio = Dio();

  Future<Login> loginGuest() async {
    final storage = new FlutterSecureStorage();

    String? value = await storage.read(key: "imei");
    Map<String, dynamic> requestParam = {
      "imei": value,
    };
    try {
      Response response = await dio.get('https://capstone23.sit.kmutt.ac.th/ej1/api/login/guest' , queryParameters: requestParam);
      if (response.statusCode == 200) {
        Login responseData = Login.fromJson(response.data);
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