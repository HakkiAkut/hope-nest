import 'package:hope_nest/models/advert.dart';

abstract class AdvertMethods {
  Stream<List<Advert>>? getAdverts();
  Future<Advert?> getAdvertByID({required String id});

  Stream<List<Advert>>? getAdvertsByUID({required String uid});

  Future<bool?> setAdvert({required Advert advert});
}
