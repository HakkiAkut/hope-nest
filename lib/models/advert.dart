class Advert {
  String id;
  String uid;
  String? description;
  String? name;
  String? age;
  String? kind;
  String? race;
  String? weight;
  List<String>? vaccines;

  Advert(
      {required this.id,
      required this.uid,
      this.description,
      this.name,
      this.age,
      this.kind,
      this.race,
      this.weight,
      this.vaccines});

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "userId": uid,
      "description": description,
      "name": name,
      "age": age,
      "kind": kind,
      "race": race,
      "weight": weight,
      "vaccines": vaccines,
    };
  }

  factory Advert.fromMap(Map<String, dynamic> map) {
    return Advert(
      id: map['id'] as String,
      uid: map['userId'] as String,
      description: map['description'] as String,
      name: map['name'] as String,
      age: map['age'] as String,
      kind: map['kind'] as String,
      race: map['race'] as String,
      weight: map['weight'] as String,
      vaccines: map['vaccines'] as List<String>,
    );
  }
}
