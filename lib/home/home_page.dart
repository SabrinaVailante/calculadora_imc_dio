import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController pesoController = TextEditingController();
  double _pesoAtual = 0;
  double _pesoInicial = 77;
  double altura = 1.65;
  String situacao = '';
  DateTime data = DateTime.now();
  double imc = 0;
  double pesoEliminado = 0;
  List<Widget> listaDeCards = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 240, 107, 32),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 240, 107, 32),
        title: const Text(
          'Calculadora IMC',
          style: TextStyle(
              color: Color.fromRGBO(251, 211, 182, 1.0),
              fontSize: 20,
              fontWeight: FontWeight.w600),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildUserInfo(),
            const SizedBox(height: 10),
            _buildButtons(),
            const SizedBox(height: 10),
            _buildIMCDisplay(),
            const SizedBox(height: 20),
            _buildGraficoAnimado(),
            const SizedBox(height: 50),
            const Divider(color: Colors.white, thickness: 1),
            TextButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return Container(
                      height: 600,
                      color: Colors.white,
                      child: Center(
                        child: Scaffold(
                          appBar: AppBar(
                            iconTheme: IconThemeData(color: Colors.white),
                            title: Text("Histórico", style: TextStyle(color: Colors.white)),
                            centerTitle: true,
                            backgroundColor: Colors.orange,


                          ),
                          backgroundColor: Colors.white,
                          body: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              children: [
                                Expanded(
                                  child: ListView(
                                    children: listaDeCards.reversed.toList(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
              child: Text(
                "Histórico",
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildHistoricoCard() {
    String dataFormatada = DateFormat('dd/MM/yyyy').format(data);
    return Card(
      color: Colors.orange,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Data", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
                Text("$dataFormatada", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400)),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Peso", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
                Text("${pesoController.text}", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400)),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("IMC", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
                Text("${imc.toStringAsFixed(2)}", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400)),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Situação", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
                Text("${situacao}", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _atualizarPeso(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(
              child: Text(
            "Atualizar Peso",
            style: TextStyle(color: Colors.orange, fontWeight: FontWeight.w600),
          )),
          content: Container(
            height: 150,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Adicione aqui seu novo peso.',
                    style: TextStyle(
                        color: Colors.orange,
                        fontSize: 16,
                        fontWeight: FontWeight.w400),
                  ),
                  TextFormField(
                    controller: pesoController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      labelText: 'Peso',
                    ),
                  )
                ],
              ),
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                _handlePesoAtualizado();
                Navigator.of(context).pop(); // Fechar o diálogo após atualizar
              },
              child: Text('Atualizar', style: TextStyle(color: Colors.orange)),
            ),
          ],
        );
      },
    );
  }

  Widget _buildGraficoAnimado() {
    return Center(
      child: Lottie.asset(
        'assets/graficoAnimado.json',
        height: 200,
        fit: BoxFit.cover,
      ),
    );
  }

  void _handlePesoAtualizado() {
    double novoPeso = double.tryParse(pesoController.text) ?? 0.0;
    setState(() {
      _pesoAtual = novoPeso;
      atualizarSituacao();
      listaDeCards.add(_buildHistoricoCard());
    });
  }

  void atualizarSituacao() {
    imc = _pesoAtual / (altura * altura);
    pesoEliminado = _pesoAtual - _pesoInicial;

    if (imc < 18.5) {
      situacao = 'Abaixo do Peso';
    } else if (imc >= 18.5 && imc < 24.9) {
      situacao = 'Peso Normal';
    } else if (imc >= 24.9 && imc < 29.9) {
      situacao = 'Sobrepeso';
    } else {
      situacao = 'Obesidade';
    }
  }

  Widget _buildUserInfo() {
    return Column(
      children: [
        _buildInfoRow('Sabrina Vailante'),
        const SizedBox(height: 10),
        _buildInfoRow(altura.toStringAsFixed(2)),
        const SizedBox(height: 10),
        _buildInfoRow(pesoController.text),
        const SizedBox(height: 10),
        _buildSexAndAgeRow(),
      ],
    );
  }

  Widget _buildInfoRow(String text) {
    return Row(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: const Color.fromRGBO(243, 128, 30, 1.0),
              borderRadius: BorderRadius.circular(10),
            ),
            height: 35,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                text,
                style: const TextStyle(
                  color: Color.fromARGB(255, 230, 230, 212),
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSexAndAgeRow() {
    return Row(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: const Color.fromRGBO(243, 128, 30, 1.0),
              borderRadius: BorderRadius.circular(10),
            ),
            height: 35,
            child: Padding(
              padding: const EdgeInsets.all(1.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(255, 255, 255, 1.0),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.woman,
                        color: Color.fromRGBO(238, 107, 32, 1.0),
                      ),
                    ),
                  ),
                  const SizedBox(width: 5),
                  const Expanded(
                    flex: 1,
                    child: Icon(
                      Icons.man,
                      color: Color.fromRGBO(253, 253, 253, 1.0),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: const Color.fromRGBO(243, 128, 30, 1.0),
              borderRadius: BorderRadius.circular(10),
            ),
            height: 35,
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Idade:  30 Anos",
                style: TextStyle(
                  color: Color.fromARGB(255, 230, 230, 212),
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildButtons() {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(elevation: 1),
            onPressed: () {
              _atualizarPeso(context);
            },
            child: const Text(
              "Atualizar Peso",
              style: TextStyle(color: Colors.orange),
            ),
          ),
        )
      ],
    );
  }

  Widget _buildIMCDisplay() {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                situacao,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 25,
                ),
              ),
              Text(
                pesoEliminado.toStringAsFixed(2),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                imc.toStringAsFixed(2),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: 70,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
