import 'dart:io';
import 'package:dart_calculadora_imc_dio/pessoa.dart';
import 'package:dart_calculadora_imc_dio/utils/calcular_imc.dart';
import 'package:dart_calculadora_imc_dio/utils/classificar_pessoa.dart';

void main(List<String> arguments) {
  print('Digite o seu nome: ');
  String nome = stdin.readLineSync()!;
  double peso = 0;
  double altura = 0;
  do {
    print('Digite o seu peso (em kg): ');
    try {
      peso = double.parse(stdin.readLineSync()!);
    } catch (e) {
      print("valor invalido deve ser um descimal");
      peso = 0;
    }
  } while (peso == 0);

  do {
    print('Digite a sua altura (em metros): ');
    try {
      altura = double.parse(stdin.readLineSync()!);
    } catch (e) {
      print("valor invalido deve ser um descimal");
      altura = 0;
    }
  } while (altura == 0);

  Pessoa pessoa1 = Pessoa(nome, peso, altura);

  double valorImc = calcularImc(pessoa1.getPeso(), pessoa1.getAltura());
  var classificacao = classificarPessoa(valorImc);

  print(
      "O IMC de ${pessoa1.getNome()} é $valorImc e ele está classificado com $classificacao.");
}
