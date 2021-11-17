import 'package:get_it/get_it.dart';
import 'package:hope_nest/services/auth/firebase/auth.dart';

GetIt serviceLocator = GetIt.instance;

void initializeLocator() {
  serviceLocator
      .registerLazySingleton(() => AuthService()); // Firebase Authentication Service
}