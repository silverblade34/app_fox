import 'dart:io';
import 'package:app_fox/features/vehicles/controllers/detail_controller.dart';
import 'package:app_fox/core/constants/colors.dart';
import 'package:app_fox/core/constants/fonts.dart';
import 'package:app_fox/features/vehicles/presentation/widgets/fullscreen_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailPage extends GetView<DetailController> {
  const DetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Detalles del Vehículo',
          style: AppFonts.titleAppBar,
        ),
        backgroundColor: AppColors.primaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.offAllNamed("/vehicles");
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Placa: ${controller.vehicle.plaVeh}',
              style: AppFonts.heading1,
            ),
            const SizedBox(height: 20),
            Text(
              'ID: ${controller.vehicle.idIngCou}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            Obx(
              () => controller.imageMain.value.isNotEmpty
                  ? Stack(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FullScreenImage(
                                  image: Image.file(
                                    File(controller.imageMain.value),
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            );
                          },
                          child: Image.file(
                            File(controller.imageMain.value),
                            width: 130,
                            height: 130,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          top: 0,
                          right: 0,
                          child: IconButton(
                            icon: const Icon(
                              Icons.close,
                              color: Colors.white,
                            ),
                            style: const ButtonStyle(
                              padding:
                                  WidgetStatePropertyAll(EdgeInsets.all(0)),
                              backgroundColor:
                                  WidgetStatePropertyAll(Colors.red),
                            ),
                            onPressed: () {
                              controller.imageMain.value = "";
                            },
                          ),
                        ),
                      ],
                    )
                  : Image.asset(
                      'assets/images/picture.png',
                      width: 150,
                    ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                    ),
                    onPressed: () => controller.tomarFotoMain(),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Foto principal',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.secondaryColor,
                    ),
                    onPressed: () => controller.tomarFoto(),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Fotos secundarias',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Mostrar imágenes en un Wrap
            Obx(() => controller.images.isNotEmpty
                ? Wrap(
                    spacing: 10.0,
                    runSpacing: 10.0,
                    children: List.generate(
                      controller.images.length,
                      (index) {
                        return Stack(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => FullScreenImage(
                                      image: Image.file(
                                        File(controller.images[index]),
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                );
                              },
                              child: Image.file(
                                File(controller.images[index]),
                                width: 130,
                                height: 130,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned(
                              top: 0,
                              right: 0,
                              child: IconButton(
                                icon: const Icon(
                                  Icons.close,
                                  color: Colors.white,
                                ),
                                style: const ButtonStyle(
                                  padding:
                                      WidgetStatePropertyAll(EdgeInsets.all(0)),
                                  backgroundColor:
                                      WidgetStatePropertyAll(Colors.red),
                                ),
                                onPressed: () {
                                  controller.eliminarImagen(index);
                                },
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  )
                : const Center(
                    child: Text('No hay imágenes agregadas.'),
                  )),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.secondaryColor,
                    ),
                    onPressed: () {
                      controller.saveImages(context);
                    },
                    child: const Text(
                      'Cargar',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
