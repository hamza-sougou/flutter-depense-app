class Depense {
  final String id;
  final String type;
  final String saisie;
  final DateTime date;
  final int quantite;
  final int montant;

  Depense({
    required this.id,
    required this.type,
    required this.saisie,
    required this.date,
    required this.quantite,
    required this.montant,
  });

  factory Depense.fromJson(Map<String, dynamic> json) {
    return Depense(
      id: json["_id"] ?? "",
      type: json["type"],
      saisie: json["saisie"],
      date: DateTime.parse(json["date"]),
      quantite: json["quantite"],
      montant: json["montant"],
    );
  }
}
