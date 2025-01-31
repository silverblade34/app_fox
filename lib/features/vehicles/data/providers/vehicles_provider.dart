import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:dio/dio.dart';

final baseUrl = dotenv.env['API_PATH'];

class VehicleProvider {
  Future<Response> getVehicles() async {
    try {
      Dio dioClient = Dio();
      final body = {
        "code": "LIMA123"
      };

      final response = await dioClient.post(
        '$baseUrl/api/v1/plates/code',
        data: body,
      );

      return response;
    } catch (e) {
      throw Exception("Error de conexión al servidor: $e");
    }
  }
}
