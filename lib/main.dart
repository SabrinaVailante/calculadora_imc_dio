import 'package:calculadoraimc/home/home_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meu App IMC',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Center(
            child: Scaffold(
                backgroundColor: Color.fromARGB(255, 240, 107, 32),
                body: Center(
                    child: Text("Calculadora IMC",
                        style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 1),
                            fontWeight: FontWeight.w500,
                            fontSize: 20))))));
  }
}
