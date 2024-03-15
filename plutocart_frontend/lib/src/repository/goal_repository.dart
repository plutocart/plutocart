import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class GoalRepository{
  final Dio dio = Dio();
  final FlutterSecureStorage storage = FlutterSecureStorage();


  Future<Map<String, dynamic>> createGoalByAccountId(String nameGoal , double totalGoal , double collectedMoney , String endDateGoal) async {
      await dotenv.load();
      String? accountId = await storage.read(key: "accountId");
          int acId = int.parse(accountId!);
    try {
      String? token = await storage.read(key: "token");
      Response response = await dio.post(
        '${dotenv.env['API']}/api/account/${acId}/goal',
        options: Options(
                   headers: { "Authorization": 'Bearer $token' , "${dotenv.env['HEADER_KEY']}" : dotenv.env['VALUE_HEADER'].toString()},
        ),
          queryParameters: {"nameGoal": nameGoal, "totalGoal": totalGoal , "collectedMoney" : collectedMoney ,  "endDateGoal" : endDateGoal},
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


 Future<List<dynamic>> getGoalByAccountId(int ? statusGoal) async {
  await dotenv.load();
      String? accountId = await storage.read(key: "accountId");
          int acId = int.parse(accountId!);
    try {
      String? token = await storage.read(key: "token");
      Response response = await dio.get(
        '${dotenv.env['API']}/api/account/${acId}/goal',
        options: Options(
                    headers: { "Authorization": 'Bearer $token' , "${dotenv.env['HEADER_KEY']}" : dotenv.env['VALUE_HEADER'].toString()},
                   
        ),
        queryParameters: {"status" : statusGoal == 0 ? null : statusGoal}
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

   Future<Map<String, dynamic>> deleteGoal(int goalId) async {
    final storage = new FlutterSecureStorage();
    String? accountId = await storage.read(key: "accountId");
    int id = int.parse(accountId!);
    String ? token = await storage.read(key: "token");
    print("id account in step deleteAccountById : ${id}");
    try {
      Response response = await dio.delete(
          '${dotenv.env['API']}/api/account/${id}/goal/${goalId}' , options: 
          Options(
                     headers: { "Authorization": 'Bearer $token' , "${dotenv.env['HEADER_KEY']}" : dotenv.env['VALUE_HEADER'].toString()},
          ));
      if (response.statusCode == 200) {
        print("delete goal id : ${goalId} : success");
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


   Future<Map<String, dynamic>> updateGoal(int goalId , String nameGoal , double amountGoal , double deficit , String endDateGoal) async {
    final storage =  FlutterSecureStorage();
    String? accountId = await storage.read(key: "accountId");
    String? token = await storage.read(key: "token");
    int id = int.parse(accountId!);
    try {
      print("start update goal");
      Response response = await dio.patch(
        '${dotenv.env['API']}/api/account/${id}/goal/${goalId}',
        queryParameters: {"nameGoal": nameGoal,  "totalGoal" : amountGoal , "collectedMoney" : deficit , "endDateGoal" : endDateGoal},
        options: 
          Options(
                     headers: { "Authorization": 'Bearer $token' , "${dotenv.env['HEADER_KEY']}" : dotenv.env['VALUE_HEADER'].toString()},
          ) , 
      );
      print("update email  ${response.data}");

      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('Error: ${'404'}');
      }
    } catch (error) {
      print("Error update email to member success $error");
      throw error;
    }
  }

    Future<Map<String, dynamic>> completeGoal(int goalId ) async {
    final storage =  FlutterSecureStorage();
    String? accountId = await storage.read(key: "accountId");
    String? token = await storage.read(key: "token");
    int id = int.parse(accountId!);
    try {
      print("start update goal");
      Response response = await dio.patch(
        '${dotenv.env['API']}/api/account/${id}/goal/${goalId}/complete-now',
        options: 
          Options(
                     headers: { "Authorization": 'Bearer $token' , "${dotenv.env['HEADER_KEY']}" : dotenv.env['VALUE_HEADER'].toString()},
          ) , 
      );
      print("update email  ${response.data}");

      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('Error: ${'404'}');
      }
    } catch (error) {
      print("Error update email to member success $error");
      throw error;
    }
  }

  
}