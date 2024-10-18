import 'package:flutter/material.dart';

class FullScreenImage extends StatelessWidget {
  final Image image;
  const FullScreenImage({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Center(  // Centrar vertical y horizontalmente
            child: InteractiveViewer(
              panEnabled: true, // Habilitar desplazamiento
              boundaryMargin: const EdgeInsets.all(20), // Margen del límite de la imagen
              minScale: 0.5, // Escala mínima
              maxScale: 3.0, // Escala máxima
              child: image,
            ),
          ),
          Positioned(
            top: 40,
            right: 20,
            child: InkWell(
              onTap: () {
                Navigator.pop(context); // Cerrar la pantalla completa al tocar la "X"
              },
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color.fromARGB(255, 59, 59, 59).withOpacity(0.5),
                ),
                child: const Icon(
                  Icons.close,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
