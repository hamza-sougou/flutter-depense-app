import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/depense.dart';

class ApiService {
  final String baseUrl = "http://10.0.2.2:3000/api/depenses";
  // ⚠️ 10.0.2.2 pour accéder au localhost depuis Android Emulator

  Future<Depense> createDepense(Map<String, dynamic> data) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(data),
    );

    if (response.statusCode == 201) {
      return Depense.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Erreur lors de la création de la dépense");
    }
  }
}
