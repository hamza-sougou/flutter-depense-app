import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../services/api_service.dart';
import 'depense_detail.dart';

class NouvelleDepensePage extends StatefulWidget {
  @override
  _NouvelleDepensePageState createState() => _NouvelleDepensePageState();
}

class _NouvelleDepensePageState extends State<NouvelleDepensePage> {
  final _formKey = GlobalKey<FormState>();
  String _type = "Carburant";
  String _saisie = "Manuelle";
  DateTime _date = DateTime.now();
  final _quantiteController = TextEditingController();
  final _montantController = TextEditingController();

  final ApiService apiService = ApiService();

  String getFormattedDate() {
    final DateFormat formatter = DateFormat('dd/MM/yyyy');
    return formatter.format(_date);
  }

  Future<void> _submit() async {
    if (_formKey.currentState!.validate()) {
      final data = {
        "type": _type,
        "saisie": _saisie,
        "date": _date.toIso8601String(),
        "quantite": int.parse(_quantiteController.text),
        "montant": int.parse(_montantController.text),
      };

      try {
        final depense = await apiService.createDepense(data);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => DepenseDetailPage(depense: depense),
          ),
        );
      } catch (e) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Erreur: $e")));
      }
    }
  }

  Future<void> _selectDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null && picked != _date) {
      setState(() {
        _date = picked;
      });
    }
  }

  Widget _buildTypeBox(String type, Color color, IconData icon) {
    bool selected = _type == type;
    return GestureDetector(
      onTap: () => setState(() => _type = type),
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
          border: selected ? Border.all(width: 3, color: Colors.black) : null,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 40, color: Colors.white),
            SizedBox(height: 8),
            Text(
              type,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSaisieBox(String saisie, IconData icon) {
    bool selected = _saisie == saisie;
    return GestureDetector(
      onTap: () => setState(() => _saisie = saisie),
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: selected ? Colors.blue.shade100 : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(12),
          border: selected ? Border.all(width: 2, color: Colors.blue) : null,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 40, color: Colors.black87),
            SizedBox(height: 8),
            Text(saisie, style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Nouvelle Dépense")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Type de dépense avec boxes
              Text(
                "Type de dépense",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: _buildTypeBox(
                      "Carburant",
                      Color(0xFF3b8fd9),
                      Icons.local_gas_station,
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: _buildTypeBox(
                      "Huile",
                      Color(0xFF639e11),
                      Icons.oil_barrel,
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: _buildTypeBox(
                      "Réparations",
                      Color(0xFFed7e07),
                      Icons.build,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 16),

              // Type de saisie avec boxes
              Text(
                "Type de saisie",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: _buildSaisieBox("Manuelle", Icons.edit)),
                  SizedBox(width: 8),
                  Expanded(
                    child: _buildSaisieBox("Scanner reçu", Icons.camera_alt),
                  ),
                ],
              ),

              SizedBox(height: 16),

              // Date
              ListTile(
                title: Text("Date : ${getFormattedDate()}"),
                trailing: Icon(Icons.calendar_today),
                onTap: _selectDate,
              ),

              // Quantité
              TextFormField(
                controller: _quantiteController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: "Quantité (Litres)"),
                validator:
                    (val) =>
                        val == null || val.isEmpty
                            ? "Entrez une quantité"
                            : null,
              ),

              // Montant
              TextFormField(
                controller: _montantController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: "Montant (F CFA)"),
                validator:
                    (val) =>
                        val == null || val.isEmpty ? "Entrez un montant" : null,
              ),

              SizedBox(height: 20),

              // Bouton enregistrer
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF3b8fd9),
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 16),
                ),
                onPressed: _submit,
                child: Text(
                  "Enregistrer la dépense",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
