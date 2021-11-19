import 'package:cloud_firestore/cloud_firestore.dart';

class AppUser {
  String uid;
  String? name;
  String? surname;
  String? phone;
  String? email;
  String? image;
  String? location;
  Timestamp? registrationDate;

  AppUser(
      {required this.uid,
      this.name,
      this.surname,
      this.phone,
      this.email,
      this.image,
      this.location,
      this.registrationDate});

  Map<String, dynamic> toMap() {
    return {
      "userId": uid,
      "name": name,
      "surname": surname,
      "phone": phone,
      "email": email,
      "image": image,
      "location": location,
      "registration_date": registrationDate ?? FieldValue.serverTimestamp(),
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
      registrationDate: map['registration_date'] as Timestamp,
    );
  }
}
