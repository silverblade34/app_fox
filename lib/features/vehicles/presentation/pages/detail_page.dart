import 'package:app_fox/features/vehicles/controllers/detail_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailPage extends GetView<DetailController> {
  const DetailPage({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
    appBar: AppBar(title: Text('DetailPage')),

    body: SafeArea(
      child: Text('DetailController'))
    );
  }
}