import 'package:flutter/material.dart';
import 'views/nouvelle_depense.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gestion Dépenses',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: NouvelleDepensePage(),
    );
  }
}
