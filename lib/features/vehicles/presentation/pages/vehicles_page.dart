import 'package:app_fox/features/vehicles/controllers/vehicles_controller.dart';
import 'package:app_fox/core/constants/colors.dart';
import 'package:app_fox/core/constants/fonts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VehiclesPage extends GetView<VehiclesController> {
  const VehiclesPage({super.key});

  @override
  Widget build(BuildContext context) {

 
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Lista de Vehículos',
          style: AppFonts.titleAppBar,
        ),
        backgroundColor: AppColors.primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: vehiculos.when(
          data: (vehiculosList) => ListView.builder(
            itemCount: vehiculosList.length,
            itemBuilder: (context, index) {
              final vehiculo = vehiculosList[index];
              return Card(
                child: ListTile(
                  leading: const Icon(Icons.directions_car),
                  title: Text(vehiculo.plaVeh),
                  subtitle: Text('ID: ${vehiculo.idIngCou}'),
                  onTap: () {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      '/vehicle_detail',
                      (Route<dynamic> route) => false,
                      arguments: vehiculo,
                    );
                  },
                ),
              );
            },
          ),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) => Center(child: Text('Error: $error')),
        ),
      ),
    );
  }
}