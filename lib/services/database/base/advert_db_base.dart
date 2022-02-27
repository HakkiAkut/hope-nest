import 'package:hope_nest/models/advert.dart';

abstract class AdvertMethods {
  Stream<List<Advert>>? getAdverts();
  Stream<List<Advert>>? getAdvertsByUID({required String uid});
  //Future<bool?> setUser({required AppUser appUser});
}