import 'dart:io';
import 'exceptions/AlturaInvalidaException.dart';
import 'model/pessoa.dart';

void main() {
  print("Calculadora de IMC");
  try {
    print("Digite seu nome:");
    String nome = stdin.readLineSync()!;

    print("Digite seu peso em quilogramas:");
    double peso = double.parse(stdin.readLineSync()!);

    print("Digite sua altura em metros:");
    double altura = double.parse(stdin.readLineSync()!);

    Pessoa pessoa = Pessoa(nome, peso, altura);
    double imc = pessoa.calcularIMC();
    String resultado = pessoa.interpretarResultado(imc);

    print("Nome: ${pessoa.nome}");
    print("Seu IMC é: $imc");
    print(resultado);
  } catch (e) {
    if (e is AlturaInvalidaException) {
      print("Erro: Altura inválida. ${e.mensagem}");
    } else {
      print("Erro desconhecido: $e");
    }
  }
}