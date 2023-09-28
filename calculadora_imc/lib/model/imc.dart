class IMC {
  double peso;
  double altura;

  IMC(this.peso, this.altura);

  double calcular() {
    return peso / (altura * altura);
  }

  String getClassificacao() {
    double imc = calcular();
    if (imc < 18.5) {
      return "Abaixo do peso";
    } else if (imc < 24.9) {
      return "Peso normal";
    } else if (imc < 29.9) {
      return "Sobrepeso";
    } else if (imc < 34.9) {
      return "Obesidade grau 1";
    } else if (imc < 39.9) {
      return "Obesidade grau 2";
    } else {
      return "Obesidade grau 3";
    }
  }
}