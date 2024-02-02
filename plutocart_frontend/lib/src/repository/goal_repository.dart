import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
class GoalRepository{
  final Dio dio = Dio();
  final FlutterSecureStorage storage = FlutterSecureStorage();

  Future<Map<String, dynamic>> createGoalByAccountId(String nameGoal , double amountGoal , double deficit , String endDateGoal) async {
      String? accountId = await storage.read(key: "accountId");
          int acId = int.parse(accountId!);
    try {
      String? token = await storage.read(key: "token");
      Response response = await dio.post(
        'https://capstone23.sit.kmutt.ac.th/ej1/api/account/${acId}/goal',
        options: Options(
           headers: { "Authorization": 'Bearer $token'},
        ),
          queryParameters: {"nameGoal": nameGoal, "amountGoal": amountGoal , "deficit" : deficit ,  "endDateGoal" : endDateGoal},
      );
      print(
          "respone code in process create goal in class repository: ${response.statusCode}");
      print(
          "respone data in process create goal in class repository: ${response.data}");

      if (response.statusCode == 201 && response.data['data'] != null) {
        return response.data;
      } else {
        throw Exception(
            'Error Create Goal from goal repository: ${response.statusCode}');
      }
    } catch (error) {
      print("Error: $error");
      throw error;
    }
  }


 Future<List<dynamic>> getGoalByAccountId() async {
      String? accountId = await storage.read(key: "accountId");
          int acId = int.parse(accountId!);
    try {
      String? token = await storage.read(key: "token");
      Response response = await dio.get(
        'https://capstone23.sit.kmutt.ac.th/ej1/api/account/${acId}/goal',
        options: Options(
           headers: { "Authorization": 'Bearer $token'},
        ),
      );
      print(
          "respone code in process get goal in class repository: ${response.statusCode}");
      print(
          "respone data in process get goal in class repository: ${response.data}");

      if (response.statusCode == 200 && response.data['data'] != null) {
        return response.data['data'];
      } else {
        throw Exception(
            'Error get Goal from goal repository: ${response.statusCode}');
      }
    } catch (error) {
      print("Error: $error");
      throw error;
    }
  }

  
}