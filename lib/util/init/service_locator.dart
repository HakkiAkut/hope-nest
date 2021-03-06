import 'package:get_it/get_it.dart';
import 'package:hope_nest/repository/repository.dart';
import 'package:hope_nest/services/auth/firebase/auth.dart';
import 'package:hope_nest/services/database/firebase/database_service.dart';
import 'package:hope_nest/services/notification/firebase/notification_service.dart';
import 'package:hope_nest/services/storage/firebase/storage_service.dart';

GetIt serviceLocator = GetIt.instance;

void initializeLocator() {
  serviceLocator.registerLazySingleton(
      () => AuthService()); // Firebase Authentication Service
  serviceLocator.registerLazySingleton(() => Repository());
  serviceLocator.registerLazySingleton(() => UserDatabaseService());
  serviceLocator.registerLazySingleton(
      () => StorageService()); // Firestore Database Service
  serviceLocator.registerLazySingleton(() => FCMNotifications());
}
