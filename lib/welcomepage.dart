import 'dart:async'; // Import the async library
import 'package:flutter/material.dart';
import 'package:pharmacyonduty/screens/cityscreen.dart';

void main() {
  runApp(const MaterialApp(
    home: WelcomePage(),
  ));
}

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  void initState() {
    super.initState();
    // Uygulama başlangıcında ve CityScreen'den geri dönüldüğünde timer başlatılır
    startTimer();
  }

  void startTimer() {
    // 3 saniye sonra, CityScreen ekranına geçiş yapar
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => CityScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/Nöbetci.jpg'),
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
