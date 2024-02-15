// Classe que representa un arbre amb diverses propietats
class Tree {
  String nom; // Nom de l'arbre
  String varietat; // Varietat de l'arbre
  String tipus; // Tipus de l'arbre
  bool autocton; // Booleà que indica si l'arbre és autòcton o no
  String foto; // URL de la foto de l'arbre
  String detall; // URL amb detalls addicionals de l'arbre

  // Constructor que inicialitza les propietats necessàries per a la classe Tree
  Tree({
    required this.nom,
    required this.varietat,
    required this.tipus,
    required this.autocton,
    required this.foto,
    required this.detall,
  });

  // Factoria per a crear instàncies de Tree des d'un mapa de dades
  factory Tree.fromMap(Map<String, dynamic> map) {
    return Tree(
      nom: map['nom'],
      varietat: map['varietat'],
      tipus: map['tipus'],
      autocton: map['autocton'],
      foto: map['foto'],
      detall: map['detall'],
    );
  }
}
