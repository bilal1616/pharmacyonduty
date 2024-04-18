import 'package:flutter/material.dart';
import 'package:pharmacyonduty/welcomepage.dart';
import 'package:provider/provider.dart';
import 'package:pharmacyonduty/provider/city_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CityProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: WelcomePage(),
      ),
    );
  }
}
