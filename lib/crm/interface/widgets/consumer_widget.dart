import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget _consumerWidget(_questionController, context) {
  return Column(
    children: [
      TextField(
        controller: _questionController,
        decoration: InputDecoration(
          labelText: 'Pregunta',
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