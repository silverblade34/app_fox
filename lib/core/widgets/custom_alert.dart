import 'package:flutter/material.dart';

// Función para mostrar el diálogo personalizado
void showCustomAlertDialog(
    BuildContext context, String title, String message, AlertType type) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return CustomAlertDialog(
        title: title,
        message: message,
        type: type,
      );
    },
  );
}

// Tipos de alertas
enum AlertType { info, success, error }

// Widget de alerta personalizado
class CustomAlertDialog extends StatelessWidget {
  final String title;
  final String message;
  final AlertType type;

  CustomAlertDialog({
    required this.title,
    required this.message,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      title: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildIcon(), // Icono según el tipo de alerta
          const SizedBox(height: 10),
          Text(title),
        ],
      ),
      content: Text(message),
    );
  }

  // Función para elegir el icono según el tipo de alerta
  Widget _buildIcon() {
    IconData icon;
    Color color;

    switch (type) {
      case AlertType.success:
        icon = Icons.check_circle;
        color = Colors.green;
        break;
      case AlertType.error:
        icon = Icons.error;
        color = Colors.red;
        break;
      case AlertType.info:
      default:
        icon = Icons.info;
        color = Colors.blue;
    }

    return Icon(icon, color: color, size: 40);
  }
}

void showLoadingDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false, // Evita que se cierre tocando fuera del diálogo
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: Colors.transparent, // Para hacer el fondo transparente
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(), // Indicador de carga
              SizedBox(height: 15),
              Text('Cargando...', style: TextStyle(fontSize: 16)),
            ],
          ),
        ),
      );
    },
  );
}
