import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/depense.dart';

class DepenseDetailPage extends StatelessWidget {
  final Depense depense;

  DepenseDetailPage({required this.depense});

  String getFormattedDate() {
    final DateFormat formatter = DateFormat('dd/MM/yyyy');
    return formatter.format(depense.date);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Dépense ${depense.id}")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Type: ${depense.type}"),
            Text("Saisie: ${depense.saisie}"),
            Text("Date: ${getFormattedDate()}"),
            Text("Quantité: ${depense.quantite} L"),
            Text("Montant: ${depense.montant} F CFA"),
          ],
        ),
      ),
    );
  }
}
