import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController pesoController = TextEditingController();
  TextEditingController alturaController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String infoText = 'Informe seus dados!';

  void resetitens() {
    setState(() {
      pesoController.text = "";
      alturaController.text = "";
      infoText = 'Informe seus dados!';
      formKey = GlobalKey<FormState>();
    });
  }

  void calculate() {
    setState(() {
      double peso = double.parse(pesoController.text);
      double altura = double.parse(alturaController.text) / 100;
      double imc = peso / (altura * altura);
      if (imc < 18.6) {
        infoText = "Ta só a ripa em (${imc.toStringAsPrecision(3)})!";
      } else if (imc >= 18.6 && imc < 24.9) {
        infoText = "Ai sim em! (${imc.toStringAsPrecision(3)})!";
      } else if (imc >= 24.9 && imc < 29.9) {
        infoText = "Bora da um corridinha? (${imc.toStringAsPrecision(3)})!";
      } else if (imc >= 29.9 && imc < 34.9) {
        infoText =
            "Grau I, Fecha boca e bora corre! (${imc.toStringAsPrecision(3)})!";
      } else if (imc >= 34.9 && imc < 39.9) {
        infoText =
            "Grau II, Bora fazer um ano academia! (${imc.toStringAsPrecision(3)})!";
      } else if (imc >= 40) {
        infoText =
            "Grau III, Ai irmão bora pro hospital, tu ta bem não! (${imc.toStringAsPrecision(3)})!";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora de IMC'),
        centerTitle: true,
        backgroundColor: Colors.redAccent,
        actions: [
          IconButton(
            onPressed: resetitens,
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Icon(
                Icons.person_outline,
                size: 150,
                color: Colors.redAccent,
              ),
              TextFormField(
                // PESO -------------------------> PESO
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                    labelText: 'Peso (Kg)',
                    labelStyle: TextStyle(
                      color: Colors.redAccent,
                    )),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.redAccent,
                  fontSize: 25,
                ),
                controller: pesoController,
                validator: (value) {
                  if(value!.isEmpty){
                    return "Insira seu Peso";
                  }
                },
              ),
              TextFormField(
                // ALTURA -------------------------> ALTURA
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                    labelText: 'Altura (cm)',
                    labelStyle: TextStyle(
                      color: Colors.redAccent,
                    )),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.red,
                  fontSize: 25,
                ),
                controller: alturaController,
                validator: (value) {
                  if(value!.isEmpty){
                    return "Insira sua Altura";
                  }
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: TextButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()){
                      calculate();
                    }
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Calcular',
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              Text(
                infoText,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.redAccent,
                  fontSize: 25,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
