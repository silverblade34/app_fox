import 'dart:async';
import 'dart:io';

import 'package:app_fox/core/widgets/custom_alert.dart';
import 'package:app_fox/features/vehicles/data/models/vehicle.dart';
import 'package:app_fox/features/vehicles/data/repositories/detail_repository.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:get/get.dart';

class DetailController extends GetxController {
  final picker = ImagePicker();
  Vehicle vehicle = Get.arguments;
  RxList<String> images = RxList([]);
  RxString imageMain = "".obs;
  DetailRepository detailRepository = DetailRepository();

  Future<void> abrirGaleria() async {
    if (await _pedirPermisoGaleria()) {
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        images.add(image.path);
      }
    } else {
      print("No ha brindado los permisos");
    }
  }

  Future<void> tomarFotoMain() async {
    if (await _pedirPermisoCamara()) {
      final XFile? image = await picker.pickImage(
        source: ImageSource.camera,
        maxWidth: 1920,
        maxHeight: 1080,
        imageQuality: 70,
      );
      if (image != null) {
        imageMain.value = image.path;
      }
    } else {
      showCustomAlertDialog(
        Get.context!,
        'Información',
        "No ha brindado los permisos",
        AlertType.info,
      );
    }
  }

  Future<void> tomarFoto() async {
    if (await _pedirPermisoCamara()) {
      final XFile? image = await picker.pickImage(
        source: ImageSource.camera,
        maxWidth: 1920,
        maxHeight: 1080,
        imageQuality: 70,
      );
      if (image != null) {
        images.add(image.path);
      }
    } else {
      showCustomAlertDialog(
        Get.context!,
        'Información',
        "No ha brindado los permisos",
        AlertType.info,
      );
    }
  }

  Future<bool> _pedirPermisoGaleria() async {
    PermissionStatus storagePermission = await Permission.storage.request();
    PermissionStatus photosPermission = await Permission.photos.request();

    return storagePermission == PermissionStatus.granted ||
        photosPermission == PermissionStatus.granted;
  }

  Future<bool> _pedirPermisoCamara() async {
    if (await Permission.camera.request().isGranted) {
      return true;
    } else {
      return false;
    }
  }

  void eliminarImagen(int index) {
    if (index >= 0 && index < images.length) {
      images.removeAt(index);
    }
  }

  saveImages(BuildContext context) async {
    try {
      if (images.isNotEmpty || imageMain.value != "") {
        showLoadingDialog(context);
        Map<String, dynamic> dataFile = {
          "IdIngCou": vehicle.idIngCou,
          "Item": "",
          "Detalle": "Enviado desde el aplicativo",
          "LogUsu": "ADMIN",
          "id_plate": vehicle.id
        };

        List<File> imagesFile = [
          File(imageMain.value),
          ...images.map((imagePath) => File(imagePath))
        ];

        await detailRepository.saveImages(dataFile, imagesFile);
        Navigator.of(Get.context!).pop();
        showCustomAlertDialog(
          Get.context!,
          'Logrado',
          "Se ha registrado correctamente",
          AlertType.success,
        );
        Timer(
          const Duration(seconds: 2),
          () => Get.offAllNamed("/vehicles"),
        );
      } else {
        showCustomAlertDialog(
          Get.context!,
          'Información',
          "Debe cargar al menos una foto",
          AlertType.info,
        );
      }
    } catch (e) {
      Navigator.of(Get.context!).pop();
      showCustomAlertDialog(
        Get.context!,
        'Alerta',
        e.toString(),
        AlertType.error,
      );
    }
  }
}
