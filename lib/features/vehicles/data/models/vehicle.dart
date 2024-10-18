// To parse this JSON data, do
//
//     final vehicleDto = vehicleDtoFromJson(jsonString);

import 'dart:convert';

VehicleDto vehicleDtoFromJson(String str) =>
    VehicleDto.fromJson(json.decode(str));

String vehicleDtoToJson(VehicleDto data) => json.encode(data.toJson());

class VehicleDto {
  String message;
  bool status;
  List<Vehicle> data;

  VehicleDto({
    required this.message,
    required this.status,
    required this.data,
  });

  factory VehicleDto.fromJson(Map<String, dynamic> json) => VehicleDto(
        message: json["message"],
        status: json["status"],
        data: List<Vehicle>.from(json["data"].map((x) => Vehicle.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Vehicle {
  String idIngCou;
  int numVez;
  String plaVeh;

  Vehicle({
    required this.idIngCou,
    required this.numVez,
    required this.plaVeh,
  });

  factory Vehicle.fromJson(Map<String, dynamic> json) => Vehicle(
        idIngCou: json["IdIngCou"],
        numVez: json["NumVez"],
        plaVeh: json["PlaVeh"],
      );

  Map<String, dynamic> toJson() => {
        "IdIngCou": idIngCou,
        "NumVez": numVez,
        "PlaVeh": plaVeh,
      };
}
