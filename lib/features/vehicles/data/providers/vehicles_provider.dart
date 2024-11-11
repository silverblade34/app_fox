import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:dio/dio.dart';

final baseUrl = dotenv.env['API_PATH'];

class VehicleProvider {
  Future<Response> getVehicles() async {
    try {
      Dio dioClient = Dio();
      print('$baseUrl/api/plates/list');
      final response = await dioClient.get('$baseUrl/api/plates/list');
      return response;
    } catch (e) {
      throw Exception("Error de conexión al servidor: $e");
    }
  }
}
