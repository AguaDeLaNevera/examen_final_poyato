class Tree {
  String nom;
  String varietat;
  String tipus;
  bool autocton;
  String foto;
  String detall;

  Tree({
    required this.nom,
    required this.varietat,
    required this.tipus,
    required this.autocton,
    required this.foto,
    required this.detall,
  });

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
