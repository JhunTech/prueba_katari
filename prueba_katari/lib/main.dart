import 'package:material_ui/material_ui.dart';
import 'package:prueba_katari/screens/consulta_pulseras_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Katari Prueba Flutter'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final _formKey = GlobalKey<FormState>();

  final _textoController = TextEditingController();

  @override
  void dispose() {
    _textoController.dispose();
    super.dispose();
  }

  void _validarYObtenerTexto() {
    if (_formKey.currentState!.validate()) {
      String textoIngresado = _textoController.text;
      if (!validarCedulaEcuatoriana(textoIngresado)){
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Cédula incorrecta: $textoIngresado')),
        );
      }else{
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ConsultaPulserasScreen()),
        );
      }

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _textoController,
                decoration: const InputDecoration(
                  labelText: 'Ingresa tu Cédula',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Este campo no puede estar vacío';
                  }
                  if (value.length < 10) {
                    return 'Debe tener 10 caracteres';
                  }
                  return null; 
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _validarYObtenerTexto,
                child: const Text('Validar y Obtener'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


bool validarCedulaEcuatoriana(String cedula) {
  if (!RegExp(r'^\d{10}$').hasMatch(cedula)) {
    return false;
  }

  final provincia = int.parse(cedula.substring(0, 2));
  final esProvinciaValida = (provincia >= 1 && provincia <= 24) || provincia == 30;
  if (!esProvinciaValida) {
    return false;
  }

  final tercerDigito = int.parse(cedula[2]);
  if (tercerDigito >= 6) {
    return false;
  }

  const coeficientes = [2, 1, 2, 1, 2, 1, 2, 1, 2];
  var suma = 0;

  for (var i = 0; i < 9; i++) {
    var producto = int.parse(cedula[i]) * coeficientes[i];
    if (producto >= 10) {
      producto -= 9;
    }
    suma += producto;
  }

  final digitoVerificador = int.parse(cedula[9]);
  final residuo = suma % 10;
  final digitoCalculado = residuo == 0 ? 0 : 10 - residuo;

  return digitoCalculado == digitoVerificador;
}

