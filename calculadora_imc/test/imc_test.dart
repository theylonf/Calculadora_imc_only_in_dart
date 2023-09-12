import 'package:calculadora_imc/exceptions/AlturaInvalidaException.dart';
import 'package:calculadora_imc/model/pessoa.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Pessoa', () {
    test('calcularIMC deve retornar o valor correto', () {
      final pessoa = Pessoa('João', 70, 1.75);
      expect(pessoa.calcularIMC(), closeTo(22.86, 0.01));
    });

    test('interpretarResultado deve retornar "Abaixo do peso"', () {
      final pessoa = Pessoa('Maria', 50, 1.75);
      expect(pessoa.interpretarResultado(16.33), equals('Abaixo do peso'));
    });

    test('interpretarResultado deve retornar "Peso normal"', () {
      final pessoa = Pessoa('Carlos', 70, 1.75);
      expect(pessoa.interpretarResultado(22.86), equals('Peso normal'));
    });

    test('interpretarResultado deve retornar "Sobrepeso"', () {
      final pessoa = Pessoa('Ana', 80, 1.75);
      expect(pessoa.interpretarResultado(26.12), equals('Sobrepeso'));
    });

    test('lançar exceção AlturaInvalidaException para altura <= 0', () {
      expect(() => Pessoa('Pedro', 70, 0).calcularIMC(),
          throwsA(isA<AlturaInvalidaException>()));
    });
  });
}
