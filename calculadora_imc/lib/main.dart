import 'package:calculadora_imc/model/imc.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class InputForm extends StatelessWidget {
  final TextEditingController pesoController;
  final TextEditingController alturaController;
  final Function(double, double) onCalcularPressed;

  InputForm({
    required this.pesoController,
    required this.alturaController,
    required this.onCalcularPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: pesoController,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(labelText: 'Peso (kg)'),
        ),
        TextField(
          controller: alturaController,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(labelText: 'Altura (m)'),
        ),
        ElevatedButton(
          onPressed: () {
            double peso = double.tryParse(pesoController.text) ?? 0;
            double altura = double.tryParse(alturaController.text) ?? 0;
            onCalcularPressed(peso, altura);
          },
          child: const Text('Calcular'),
        ),
      ],
    );
  }
}

class ResultadosAnteriores extends StatelessWidget {
  final List<Map<String, dynamic>> resultados;

  ResultadosAnteriores({required this.resultados});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Resultados Anteriores:', style: TextStyle(fontSize: 18)),
        ListView.builder(
          shrinkWrap: true,
          itemCount: resultados.length,
          itemBuilder: (context, index) {
            double valorIMC = resultados[index]['imc'];
            String classificacao = resultados[index]['classificacao'];
            double peso = resultados[index]['peso'];
            double altura = resultados[index]['altura'];

            return ListTile(
              title: Text('Peso: $peso kg - Altura: $altura m'),
              subtitle: Text(
                  'IMC: ${valorIMC.toStringAsFixed(2)} - Classificação: $classificacao'),
            );
          },
        ),
      ],
    );
  }
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  TextEditingController pesoController = TextEditingController();
  TextEditingController alturaController = TextEditingController();
  List<Map<String, dynamic>> resultadosAnteriores = [];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Calculadora de IMC'),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              InputForm(
                pesoController: pesoController,
                alturaController: alturaController,
                onCalcularPressed: (peso, altura) {
                  if (altura > 0 && peso > 0) {
                    IMC imc = IMC(peso, altura);
                    String classificacao = imc.getClassificacao();
                    double valorIMC = imc.calcular();

                    setState(() {
                      resultadosAnteriores.add({
                        'imc': valorIMC,
                        'classificacao': classificacao,
                        'peso': peso,
                        'altura': altura,
                      });
                    });

                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Resultado'),
                          content: Text(
                              'Seu IMC é: ${valorIMC.toStringAsFixed(2)}\nClassificação: $classificacao'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('Fechar'),
                            ),
                          ],
                        );
                      },
                    );
                  } else {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Erro'),
                          content: const Text(
                              'Peso e altura devem ser maiores que zero.'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('Fechar'),
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
              ),
              const SizedBox(height: 16.0),
              ResultadosAnteriores(resultados: resultadosAnteriores),
            ],
          ),
        ),
      ),
    );
  }
}
