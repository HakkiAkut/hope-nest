import 'package:hope_nest/models/advert.dart';

abstract class AdvertMethods {
  Stream<List<Advert>> getAdverts();
  //Future<bool?> setUser({required AppUser appUser});
}