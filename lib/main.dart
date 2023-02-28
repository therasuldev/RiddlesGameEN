import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart' as path;
import 'package:path_provider_android/path_provider_android.dart';
import 'package:riddles_game_en/core/provider/observer.dart';
import 'package:riddles_game_en/core/service/boxes.dart';
import 'package:upgrader/upgrader.dart';

import 'app.dart';
import 'core/app/intl.dart';
import 'core/app/riddle.dart';
import 'core/model/riddle_model/riddle_model.dart';
import 'core/model/user/user.dart';
import 'core/service/service.dart';

void main() async {
  if (Platform.isAndroid) PathProviderAndroid.registerWith();
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();

  await Upgrader.clearSavedSettings();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  await path
      .getApplicationDocumentsDirectory()
      .then((directory) async => await Hive.initFlutter(directory.path));

  if (!(Hive.isAdapterRegistered(TypeId.userModelID) &&
      Hive.isAdapterRegistered(TypeId.riddleModelID))) {
    Hive.registerAdapter(UserModelAdapter());
    Hive.registerAdapter(RiddleModelAdapter());
  }

  await Hive.openBox(Boxes.riddles);
  await Hive.openBox(Boxes.games);
  await Hive.openBox(Boxes.levels);
  await Hive.openBox(Boxes.user);
  await Hive.openBox(Boxes.apptheme);
  await Hive.openBox(Boxes.applang);

  Bloc.observer = R2BlocObserver();
  final ridd = Riddle();
  ridd.intl = Intl();
  ridd.cacheService = CacheService();
  ridd.intl.locale = const Locale('en');
  ridd.intl.supportedLocales = languages;

  runApp(MyApp());
}
