import 'dart:io';

import 'package:app_fox/features/vehicles/data/providers/detail_provider.dart';

class DetailRepository {
  DetailProvider detailProvider = DetailProvider();

  Future<dynamic> saveImages(
      Map<String, dynamic> payload, List<File> images) async {
    final response = await detailProvider.createEvidence(payload, images);
    if (response.data == null) {
      throw Exception("No se recibieron datos en la respuesta");
    } else if (response.statusCode == 400) {
      throw Exception("Error desconocido");
    } else if (response.data["status"] == false) {
      throw Exception(response.data["message"]);
    }
    final body = response.data;
    return body;
  }
}
