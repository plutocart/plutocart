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
    print("imei in process login guest in class repository: ${imei}");
    try {
      Response response = await dio.get(
        'https://capstone23.sit.kmutt.ac.th/ej1/api/login/guest',
        queryParameters: {"imei": imei},
      );
      print(
          "respone code in process login guest in class repository: ${response.statusCode}");
      print(
          "respone data in process login guest in class repository: ${response.data}");
      if (response.statusCode == 200 && response.data['data'] != null) {
        await storage.write(
          key: "accountId",
          value: response.data['data']['accountId'].toString(),
        );
        
        return response.data;
      } else {
        throw Exception('Error login guest repository data is : ${response.data['data']}');
      }
    } catch (error) {
      print("Error login repository guest: $error");
      throw error;
    }
  }

  Future<Map<String, dynamic>> createAccountGuest() async {
    initPlatformState();
    String? imei = await storage.read(key: "imei");
    print("check imei from create account guest repository login : $imei");
    try {
      Response response = await dio.post(
        'https://capstone23.sit.kmutt.ac.th/ej1/api/account/register/guest',
        data: {"imei": imei},
      );
      print(
          "respone code in process create guest in class repository: ${response.statusCode}");
      print(
          "respone data in process create guest in class repository: ${response.data}");

      if (response.statusCode == 201 && response.data['data'] != null) {
        await storage.write(
          key: "accountId",
          value: response.data['data']['accountId'].toString(),
        );
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

  // Customer

  Future<Map<String, dynamic>> createAccountMember() async {
    initPlatformState();
    await handleSignIn();
    String? imei = await storage.read(key: "imei");
    String? email = await storage.read(key: "email");
    print(
        "check imei create Account customer classs repository login : ${imei}");
    print(
        "check email create Account customer classs repository login : ${email}");
    try {
      Response response = await dio.post(
        'https://capstone23.sit.kmutt.ac.th/ej1/api/account/register/member',
        data: {"imei": imei, "email": email},
      );
      print(
          "check status code of create account customer classs repository login : ${response.statusCode}");
      if (response.data['data'] != null) {
        await storage.delete(key: "email");
        await storage.write(
          key: "accountId",
          value: response.data['data']['accountId'].toString(),
        );
        await storage.write(
          key: "email",
          value: response.data['data']['email'].toString(),
        );
        String? imei = await storage.read(
            key: "imei"); // check imei not logic oparate of this function
        String? email = await storage.read(
            key: "email"); // check email not logic oparate of this function
        print(
            "check email local storage  from repository login class Create account customer : ${email}");
        print(
            "check imei local storage  from repository login class Create account customer : ${imei}");
        print(
            "check data from repository login class Create account customer : ${response.data}");
        return response.data;
      } else {
        throw Exception(
            'Error create account customer in try: ${response.statusCode}');
      }
    } catch (error) {
      if (email != null) {
        print("check email if signup then account dupicate");
        loginMember();
      } else {
        print("Error create account customer: $error");
        await storage.write(
          key: "accountId",
          value: "unknown",
        );
      }

      throw error;
    }
  }

  Future<Map<String, dynamic>> loginMember() async {
    await initPlatformState();
    String? imei = await storage.read(key: "imei");
    String? email = await storage.read(key: "email");
    print(
        "imei in process login customer after create in class repository: ${imei}");
    print(
        "email in process login customer after create in class repository: ${email}");
    try {
      Response response = await dio.get(
        'https://capstone23.sit.kmutt.ac.th/ej1/api/login/member',
        queryParameters: {"imei": imei, "email": email},
      );
      print(
          "respone code in process login customer after create in class repository: ${response.statusCode}");
      print(
          "respone data in process login customer after create in class repository: ${response.data}");
      if (response.statusCode == 200 && response.data['data'] != null) {
        await storage.write(
          key: "accountId",
          value: response.data['data']['accountId'].toString(),
        );
        await storage.write(
          key: "email",
          value: response.data['data']['email'].toString(),
        );
        return response.data;
      } else {
        throw Exception(
            'Error login customer after create repository data is : ${response.data['data']}');
      }
    } catch (error) {
      print("Error login repository customer after create: $error");
      throw error;
    }
  }

  Future<Map<String, dynamic>> loginEmailGoogle() async {
    String? imei = await storage.read(key: "imei");
    String? email = await storage.read(key: "email");
     print("email login email google : ${email}");
      print("email login imei google : ${imei}");
    try {
      print("start sign in google account");
          Response response = await dio.get(
        'https://capstone23.sit.kmutt.ac.th/ej1/api/login/member',
        queryParameters: {"imei": imei, "email": email},
      );
      print("email google account and response:  ${response.data}" );

      if (response.statusCode == 200 ) {
        await storage.write( key: "accountId", value: response.data['data']['accountId'].toString(),
        );
        return response.data;
      } else {
        throw Exception('Error: ${'404'}');
      }
    } catch (error) {
      print("Error login customer email google sign in error: $error");
      throw error;
    }
  }

  // logout Member
    void  LogOutEmailGoolge() async {
       final storage = FlutterSecureStorage();
       storage.delete(key: "email");
         await _googleSignIn.signOut();
         await _googleSignIn.disconnect();
  }

//  logOut Guest
  void LogOutGuest() async {
      final storage = FlutterSecureStorage();
       storage.delete(key: "imei");
  }
// Google

  static GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  static Future<void> handleSignIn() async {
    print("start sign in account google");
    try {
      final storage = FlutterSecureStorage();
      storage.delete(key: "email");
      await _googleSignIn.signOut();
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      print("create and call sign in account google");
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
      await _googleSignIn.signOut();
      await storage.delete(key: "email");
    } catch (error) {
      print(error);
    }
  }
}
