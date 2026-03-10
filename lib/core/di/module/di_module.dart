import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

@module
abstract class DIModule {
  @preResolve
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();

  InternetConnectionChecker get connectionChecker =>
      InternetConnectionChecker.instance;
  // AuthServiceClient getAuthService(Dio client) => AuthServiceClient(client);
  // AuthServiceClient getAuthService(Dio client) => AuthServiceClient(client);
  // UserPeofileService getUserPeofileService(Dio client) =>
  //     UserPeofileService(client);

  // StorePeofileService getStorePeofileService(Dio client) =>
  //     StorePeofileService(client);

  // AboutUsService aboutUsService(Dio client) => AboutUsService(client);

  // ProudectsService proudectsService(Dio client) => ProudectsService(client);
  // HomeService homeService(Dio client) => HomeService(client);
  // AddressService addressService(Dio client) => AddressService(client);
  // ComputerAssemblyService computerAssemblyService(Dio client) =>
  //     ComputerAssemblyService(client);

  // NotificationService notificationService(Dio client) =>
  //     NotificationService(client);

  // CartService cartService(Dio client) => CartService(client);

  // OrderPaymentService orderPaymentService(Dio client) =>
  //     OrderPaymentService(client);

  // PromoCodeService promoCodeService(Dio client) => PromoCodeService(client);

  Key getKey() => UniqueKey();
}
