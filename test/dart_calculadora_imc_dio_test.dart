import 'package:dart_calculadora_imc_dio/pessoa.dart';
import 'package:dart_calculadora_imc_dio/utils/calcular_imc.dart';
import 'package:test/test.dart';


void main() {
  test('Teste de cálculo de IMC', () {
    // Valores de exemplo
    double peso = 70.0;
    double altura = 1.75;
    double resultadoEsperado = 22.86; // O valor do IMC esperado com esses valores

    // Chama a função calcularImc
    double resultadoReal = calcularImc(peso, altura);

    // Verifica se o resultado é igual ao valor esperado com uma margem de erro aceitável
    expect(resultadoReal, closeTo(resultadoEsperado, 0.01));
  });
}