import 'package:cloud_firestore/cloud_firestore.dart';

class AppUser {
  String uid;
  String? name;
  String? surname;
  String? phone;
  String? email;
  String? image;
  String? location;
  String? description;
  Timestamp? registrationDate;
  bool? isAdmin;
  bool? isBanned;

  AppUser(
      {required this.uid,
      this.name,
      this.surname,
      this.phone,
      this.email,
      this.image,
      this.location,
      this.description,
      this.registrationDate,
      this.isAdmin,
        this.isBanned});

  Map<String, dynamic> toMap() {
    return {
      "userId": uid,
      "name": name,
      "surname": surname,
      "phone": phone,
      "email": email,
      "image": image ?? "",
      "location": location,
      "description": description ?? "An animal lover",
      "registration_date": registrationDate ?? FieldValue.serverTimestamp(),
      "isAdmin":isAdmin,
      "isBanned":isBanned
    };
  }

  factory AppUser.fromMap(Map<String, dynamic> map) {
    return AppUser(
      uid: map['userId'] as String,
      name: map['name'] as String,
      surname: map['surname'] as String,
      phone: map['phone'] as String,
      email: map['email'] as String,
      image: map['image'] as String,
      location: map['location'] as String,
      description: map['description'] as String,
      registrationDate: map['registration_date'] as Timestamp,
      isAdmin: map['isAdmin'] as bool,
      isBanned: map['isBanned'] as bool,
    );
  }
}
