import 'package:calculadora_imc/inicio_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Calculadora IMC',
    theme: ThemeData(
      primaryColor: Colors.deepPurple,
      primarySwatch: Colors.deepPurple,
      visualDensity: VisualDensity.adaptivePlatformDensity,
    ),
    home: InicioScreen(),
  ));
}
