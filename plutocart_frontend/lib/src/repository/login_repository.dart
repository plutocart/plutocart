import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_udid/flutter_udid.dart';
import 'package:plutocart/src/blocs/login_bloc/login_bloc.dart';
import 'package:plutocart/src/models/login/login_model.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:plutocart/src/pages/login/home_login.dart';

class LoginRespository {
  final dio = Dio();
  String _udid = 'Unknown';
  String email = "Unknown";
  final storage = new FlutterSecureStorage();
  Future<void> initPlatformState() async {
    String udid;
    try {
      udid = await FlutterUdid.consistentUdid;
      await storage.write(key: "imei", value: udid);
      print("udid : $udid");
    } on Error {
      udid = 'Failed to get UDID.';
    }
  }

  Future loginGuest() async {
    await initPlatformState();
    String? value = await storage.read(key: "imei");
    print("value = ${value}");
    Map<String, dynamic> requestParam = {
      "imei": value,
    };
    try {
      Response response = await dio.get(
          'https://capstone23.sit.kmutt.ac.th/ej1/api/login/guest',
          queryParameters: requestParam);
      if (response.statusCode == 200) {
        await storage.write(
            key: "accountId",
            value: response.data['data']['accountId'].toString());
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

  Future createAccountGuest() async {
    final storage = new FlutterSecureStorage();
    String? imei = await storage.read(key: "imei");
    print("imeis!! : $imei");
    try {
      Map<String, dynamic> requestBody = {
        "imei": imei,
      };
      Response response = await dio.post(
          'https://capstone23.sit.kmutt.ac.th/ej1/api/account/register/guest',
          data: requestBody);
      if (response.statusCode == 201) {
        await storage.write(
            key: "accountId",
            value: response.data['data']['accountId'].toString());
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




  
Future loginCustomer() async {
    await initPlatformState();
    String? imei = await storage.read(key: "imei");
    String? email = await storage.read(key: "email");
    print("login successfully : $imei");
    print("login successfully : $email ");
    Map<String, dynamic> requestParam = {"imei": imei, "email": email};
    try {
      Response response = await dio.get(
          'https://capstone23.sit.kmutt.ac.th/ej1/api/login/customer',
          queryParameters: requestParam);
      if (response.statusCode == 200) {
        await storage.write(
            key: "accountId",
            value: response.data['data']['accountId'].toString());
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

  Future createAccountCustomer() async {
    final storage = new FlutterSecureStorage();
    await _googleSignIn.signOut();
    await  storage.delete(key: "email");
    await handleSignIn();
    String? imei = await storage.read(key: "imei");
    String? email = await storage.read(key: "email");
     print("email2 : ${imei}");
    print("email2 : ${email}");
    try {
      Map<String, dynamic> requestBody = {"imei": imei, "email": email};
      Response response = await dio.post(
          'https://capstone23.sit.kmutt.ac.th/ej1/api/account/register/customer',
          data: requestBody);
      if (response.statusCode == 201) {
        await storage.write(key: "accountId",value: response.data['data']['accountId'].toString());
      print("email2 : ${response.data}");
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

  // Login Google

  static List<String> scopes = <String>[
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ];
  static GoogleSignIn _googleSignIn = GoogleSignIn(
    // clientId: '232792221897-6n5d0jvhfpeacnq16s630arh3rs4k5qn.apps.googleusercontent.com',
    scopes: scopes,
  );

  static Future<void> handleSignIn() async {
    final storage = new FlutterSecureStorage();
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser != null) {
        print("email: ${googleUser.email}");
        storage.write(key: "email", value: googleUser.email);
        String ? email = await storage.read(key: "email");
        print("email1 : ${email}");
      }
    } catch (error) {
      print('Error signing in: $error');
    }
  }

  // Logout goole

  static Future<void> handleSignOut() async {
    final storage = new FlutterSecureStorage();
    try {
      await _googleSignIn.disconnect();
      await _googleSignIn.signOut();
      storage.delete(key: "email");
    } catch (error) {
      print(error);
    }
  }
}
