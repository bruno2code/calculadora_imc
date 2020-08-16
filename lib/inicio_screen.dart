import 'package:flutter/material.dart';

class InicioScreen extends StatefulWidget {
  @override
  _InicioScreenState createState() => _InicioScreenState();
}

class _InicioScreenState extends State<InicioScreen> {
  TextEditingController peso = TextEditingController();
  TextEditingController altura = TextEditingController();
  final FocusNode _fcAltura = FocusNode();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _infoText = "Informe seus dados";

  void _resetFields() {
    peso.text = "";
    altura.text = "";

    setState(() {
      _infoText = "Informe seus dados!";
      _formKey = GlobalKey<FormState>();
    });
  }

  void calculate() {
    setState(() {
      final double weight = double.parse(peso.text);
      final double height = double.parse(altura.text) / 100;

      final double imc = weight / (height * height);

      if (imc < 18.6) {
        _infoText = "Abaixo do Peso! (IMC: ${imc.toStringAsPrecision(3)})";
      }
      if (imc >= 18.6 && imc <= 24.9) {
        _infoText = "Peso ideal! (IMC: ${imc.toStringAsPrecision(3)})";
      }
      if (imc >= 24.9 && imc <= 29.9) {
        _infoText =
            "Levemente acima do peso! (IMC: ${imc.toStringAsPrecision(3)})";
      }
      if (imc >= 29.9 && imc <= 34.9) {
        _infoText = "Obesidade grau I! (IMC: ${imc.toStringAsPrecision(3)})";
      }
      if (imc >= 34.9 && imc <= 39.9) {
        _infoText = "Obesidade grau II! (IMC: ${imc.toStringAsPrecision(3)})";
      }
      if (imc >= 40.0) {
        _infoText = "Obesidade grau III! (IMC: ${imc.toStringAsPrecision(3)})";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Calculadora de IMC"),
          centerTitle: true,
          backgroundColor: Theme.of(context).primaryColor,
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: _resetFields,
            )
          ],
        ),
        backgroundColor: Colors.deepPurple[50],
        body: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Icon(Icons.network_check,
                      size: 120.0, color: Theme.of(context).primaryColor),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Text(
                      _infoText,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Theme.of(context).primaryColor, fontSize: 20),
                    ),
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: "Peso em KG",
                        labelStyle:
                            TextStyle(color: Theme.of(context).primaryColor)),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Theme.of(context).primaryColor, fontSize: 16),
                    controller: peso,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Insira seu peso!";
                      } else {
                        return null;
                      }
                    },
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_fcAltura);
                    },
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: "Altura em CM",
                        labelStyle:
                            TextStyle(color: Theme.of(context).primaryColor)),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Theme.of(context).primaryColor, fontSize: 16),
                    controller: altura,
                    focusNode: _fcAltura,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Insira sua altura!";
                      } else {
                        return null;
                      }
                    },
                    onFieldSubmitted: (_) {
                      if (_formKey.currentState.validate()) {
                        calculate();
                      }
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                    child: Container(
                      height: 50.0,
                      child: RaisedButton(
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            calculate();
                          }
                        },
                        color: Theme.of(context).primaryColor,
                        child: const Text(
                          "Calcular",
                          style: TextStyle(color: Colors.white, fontSize: 25.0),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )));
  }
}
