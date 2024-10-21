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
        int fileSizeInBytes = await File(image.path).length();

        double fileSizeInKB = fileSizeInBytes / 1024;

        double fileSizeInMB = fileSizeInKB / 1024;
        print(
            'Tamaño de la imagen en KB: ${fileSizeInKB.toStringAsFixed(2)} KB');
        print(
            'Tamaño de la imagen en MB: ${fileSizeInMB.toStringAsFixed(2)} MB');
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
      if (images.isNotEmpty) {
        showLoadingDialog(context);
        Map<String, dynamic> dataFile = {
          "IdIngCou": vehicle.idIngCou,
          "NumVez": vehicle.numVez,
          "Item": "4568",
          "Detalle": "Detalle 1234",
          "LogUsu": "ADMIN",
          "ChkCert": 1,
          "ChkCloud": 0,
          "PathCloud": "",
        };

        List<File> imagesFile =
            images.map((imagePath) => File(imagePath)).toList();
        final response =
            await detailRepository.saveImages(dataFile, imagesFile);
        Navigator.of(Get.context!).pop();
        showCustomAlertDialog(
          Get.context!,
          'Logrado',
          response["message"],
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
