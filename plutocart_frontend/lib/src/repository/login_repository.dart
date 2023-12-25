import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_udid/flutter_udid.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginRepository {
  final Dio dio = Dio();
  final FlutterSecureStorage storage = FlutterSecureStorage();

  Future<void> initPlatformState() async {
    try {
      String udid = await FlutterUdid.consistentUdid;
      await storage.write(key: "imei", value: udid);
      print("UDID: $udid");
    } catch (error) {
      print("Failed to get UDID: $error");
      // Handle the error accordingly
    }
  }

  Future<Map<String, dynamic>> loginGuest() async {
    await initPlatformState();
    String? imei = await storage.read(key: "imei");

    try {
      Response response = await dio.get(
        'https://capstone23.sit.kmutt.ac.th/ej1/api/login/guest',
        queryParameters: {"imei": imei},
      );

      if (response.statusCode == 200) {
        await storage.write(
          key: "accountId",
          value: response.data['data']['accountId'].toString(),
        );
        return response.data;
      } else {
        throw Exception('Error: ${response.statusCode}');
      }
    } catch (error) {
      print("Error: $error");
      throw error;
    }
  }

  Future<Map<String, dynamic>> createAccountGuest() async {
    String? imei = await storage.read(key: "imei");

    try {
      Response response = await dio.post(
        'https://capstone23.sit.kmutt.ac.th/ej1/api/account/register/guest',
        data: {"imei": imei},
      );

      if (response.statusCode == 201) {
        await storage.write(
          key: "accountId",
          value: response.data['data']['accountId'].toString(),
        );
        return response.data;
      } else {
        throw Exception('Error: ${response.statusCode}');
      }
    } catch (error) {
      print("Error: $error");
      throw error;
    }
  }

  Future<Map<String, dynamic>> loginCustomer() async {
    await initPlatformState();
    String? imei = await storage.read(key: "imei");
    String? email = await storage.read(key: "email");
    print("login customer: $email"); 
    try {
      Response response = await dio.get(
        'https://capstone23.sit.kmutt.ac.th/ej1/api/login/customer',
        queryParameters: {"imei": imei, "email": email},
      );

      if (response.statusCode == 200) {
        await storage.write(
          key: "accountId",
          value: response.data['data']['accountId'].toString(),
        );
        return response.data;
      } else {
        throw Exception('Error: ${response.statusCode}');
      }
    } catch (error) {
      print("Error: $error");
      throw error;
    }
  }


  Future<Map<String, dynamic>> createAccountCustomer() async {
    await _googleSignIn.signOut();
    await storage.delete(key: "email");
    await handleSignIn();
    String? imei = await storage.read(key: "imei");
    String? email = await storage.read(key: "email");

    try {
      Response response = await dio.post(
        'https://capstone23.sit.kmutt.ac.th/ej1/api/account/register/customer',
        data: {"imei": imei, "email": email},
      );

      if (response.statusCode == 201) {
        await storage.write(
          key: "accountId",
          value: response.data['data']['accountId'].toString(),
        );
        return response.data;
      } else {
        throw Exception('Error: ${response.statusCode}');
      }
    } catch (error) {
      print("Error: $error");
      throw error;
    }
  }
Future<Map<String, dynamic>> loginEmailGoogle() async {
    await _googleSignIn.signOut();
    await storage.delete(key: "email");
    await handleSignIn();
    String? imei = await storage.read(key: "imei");
    String? email = await storage.read(key: "email");

    try {
          Response response = await dio.get(
        'https://capstone23.sit.kmutt.ac.th/ej1/api/login/customer',
        queryParameters: {"imei": imei, "email": email},
      );

      if (response.statusCode == 200) {
        await storage.write( key: "accountId", value: response.data['data']['accountId'].toString(),
        );
        return response.data;
      } else {
        throw Exception('Error: ${'404'}');
      }
    } catch (error) {
      print("Error: $error");
      throw error;
    }
  }



  static GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
    
  );

  static Future<void> handleSignIn() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser != null) {
        final storage = FlutterSecureStorage();
        await storage.write(key: "email", value: googleUser.email);
        String? email = await storage.read(key: "email");
        print("Signed in with email: $email");
      }
    } catch (error) {
      print('Error signing in: $error');
    }
  }

  static Future<void> handleSignOut() async {
    try {
      final storage = FlutterSecureStorage();
      await _googleSignIn.disconnect();
      await _googleSignIn.signOut();
      await storage.delete(key: "email");
    } catch (error) {
      print(error);
    }
  }
}
