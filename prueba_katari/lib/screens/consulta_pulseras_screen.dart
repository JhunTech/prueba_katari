import 'package:material_ui/material_ui.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:prueba_katari/models/cedulas_model.dart'; // Importa tu modelo

class ConsultaPulserasScreen extends StatelessWidget {
  const ConsultaPulserasScreen({super.key});

    Future<List<Cedulas>> cargarDatosJson() async {
    final String respuesta = await rootBundle.loadString('assets/datos.json');
    return cedulasFromJson(respuesta);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Consultar Pulseras'),
      ),
      body: const Center(
        child: Text('Página vacía'),
      ),
    );
  }
}