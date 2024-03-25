import 'package:dio/dio.dart';

class GraphRepository {
  final Dio dio = Dio();
//  Future<List<dynamic>> getGoalByAccountId(int ? statusGoal) async {
//   await dotenv.load();
//       String? accountId = await storage.read(key: "accountId");
//           int acId = int.parse(accountId!);
//     try {
//       String? token = await storage.read(key: "token");
//       Response response = await dio.get(
//         '${dotenv.env['API']}/api/account/${acId}/goal',
//         options: Options(
//                     headers: { "Authorization": 'Bearer $token' , "${dotenv.env['HEADER_KEY']}" : dotenv.env['VALUE_HEADER'].toString()},

//         ),
//         queryParameters: {"status" : statusGoal == 0 ? null : statusGoal}
//       );
//       print(
//           "respone code in process get goal in class repository: ${response.statusCode}");
//       print(
//           "respone data in process get goal in class repository: ${response.data}");

//       if (response.statusCode == 200 && response.data['data'] != null) {
//         return response.data['data'];
//       } else {
//         throw Exception(
//             'Error get Goal from goal repository: ${response.statusCode}');
//       }
//     } catch (error) {
//       print("Error: $error");
//       throw error;
//     }
//   }
}
