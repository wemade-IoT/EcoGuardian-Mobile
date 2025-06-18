import 'package:ecoguardian/shared/infrastructure/helpers/storage_helper.dart';
import 'package:flutter/material.dart';
import '../widgets/consumer_widget.dart';

class ConsultingScreen extends StatefulWidget {

  static const String name = 'consulting_screen';

  const ConsultingScreen({super.key});

  @override
  State<ConsultingScreen> createState() => _ConsultingScreenState();
}

class _ConsultingScreenState extends State<ConsultingScreen> {
  var user = StorageHelper.getUser();
  var name = 'Consulting Screen';



  final TextEditingController _questionController = TextEditingController();



  @override

  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(title: Text(name)),
        body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const Text(
                  'Consulting Screen',
                  style: TextStyle(fontSize: 24),
                ),
                const SizedBox(height: 20),

                // Dependiendo del rol del usuario, mostramos diferentes widgets
                if (user.role == 'domestic')
                  _consumerWidget(user.role), // Para un consultor
                if (user.role == 'enterprise')
                  _consumerWidget(user.role), // Para un consultor
                if (user.role == 'specialist')
                  _specialistWidget(), // Para un administrador
              ],
            ),
        )


    );
  }

  Widget _consumerWidget(String role) {
    return Column(
      children: [
        TextField(
          controller: _questionController,
          decoration: InputDecoration(
            labelText: role == 'domestic' ?'Preguntas de tus plantas' : 'Preguntas de tus plantaciones',
            border: OutlineInputBorder(),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            if (_questionController.text.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Por favor ingresa una pregunta')),
              );
            } else {
              // Aquí podrías enviar la pregunta a un backend o realizar alguna acción
              print('Pregunta: ${_questionController.text}');
            }
          },
          child: Text('Enviar Pregunta'),
        ),
      ],
    );
  }
  Widget _specialistWidget() {
    return Column(
      children: [
        Text('Panel de especialista', style: TextStyle(fontSize: 20)),
        // Aquí puedes agregar widgets para los administradores
      ],
    );
  }
}

extension on Future {
  get role => "domestic";
}


