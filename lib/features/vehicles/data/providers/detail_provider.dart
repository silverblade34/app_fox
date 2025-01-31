import 'dart:convert';
import 'dart:io';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart' as path;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:dio/dio.dart';

final baseUrl = dotenv.env['API_PATH'];

class DetailProvider {
  Future<Response> createEvidence(
      Map<String, dynamic> payload, List<File> images) async {
    try {
      Dio dioClient = Dio();
      print("Enviando.....");
      print(jsonEncode(payload));
      final formData = FormData.fromMap(
        {
          ...payload,
          'files': [
            for (var image in images)
              await MultipartFile.fromFile(
                image.path,
                filename: path.basename(image.path),
                contentType: DioMediaType('image', 'jpeg'),
              ),
          ],
        },
      );

      final response = await dioClient.post(
        '$baseUrl/api/v1/evidence/create',
        data: formData,
        options: Options(
          headers: {
            'Content-Type': 'multipart/form-data',
          },
        ),
      );

      return response;
    } catch (e) {
      throw Exception("Error de conexión al servidor: $e");
    }
  }
}
