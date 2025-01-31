import 'package:app_fox/features/vehicles/data/models/vehicle.dart';
import 'package:app_fox/features/vehicles/data/providers/vehicles_provider.dart';

class VehiclesRepository {
  VehicleProvider vehicleProvider = VehicleProvider();

  Future<VehicleDto> getVehicles() async {
    print("-----------------------------1");
    final response = await vehicleProvider.getVehicles();
    print("-----------------------------2");
    print(response.data);
    if (response.data == null) {
      print("-----------------------------3");
      throw Exception("No se recibieron datos en la respuesta");
    } else if (response.statusCode == 400) {
      print("-----------------------------4");
      throw Exception("Error desconocido");
    } else if (response.data["status"] == false) {
      print("-----------------------------5");
      throw Exception(response.data["message"]);
    }
    print("-----------------------------6");
    final body = response.data;
    VehicleDto data = VehicleDto.fromJson(body);
    return data;
  }
}
