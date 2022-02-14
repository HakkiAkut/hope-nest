import 'package:cloud_firestore/cloud_firestore.dart';

class Advert {
  String id;
  String uid;
  Timestamp date;
  String url;
  String? description;
  String? name;
  int? age;
  String? kind;
  String? race;
  double? weight;
  //List<String>? vaccines;

  Advert({
    required this.id,
    required this.uid,
    required this.date,
    required this.url,
    this.description,
    this.name,
    this.age,
    this.kind,
    this.race,
    this.weight,
    //this.vaccines
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "userId": uid,
      "date": date,
      "url": url,
      "description": description,
      "name": name,
      "age": age,
      "kind": kind,
      "race": race,
      "weight": weight,
      //"vaccines": vaccines,
    };
  }

  factory Advert.fromMap(Map<String, dynamic> map) {
    return Advert(
      id: map['id'] as String,
      uid: map['userId'] as String,
      date: map['date'] as Timestamp,
      url: map['url'] as String,
      description: map['description'] as String,
      name: map['name'] as String,
      age: map['age'] as int,
      kind: map['kind'] as String,
      race: map['race'] as String,
      weight: map['weight'] as double,
      //vaccines: map['vaccines'] as List<String>,
    );
  }
}
