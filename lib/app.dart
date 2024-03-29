import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:riddles_game_en/core/provider/bloc/user/user_bloc.dart';
import 'package:riddles_game_en/core/provider/cubit/app/app_cubit.dart';
import 'package:riddles_game_en/core/provider/cubit/level/level_cubit.dart';
import 'package:riddles_game_en/start.dart';
import 'package:upgrader/upgrader.dart';

import 'core/app/intl.dart';
import 'core/provider/bloc/game/game_bloc.dart';
import 'core/provider/bloc/riddle/riddle_bloc.dart';
import 'view/widgets/widgets.dart';

class MyApp extends R2StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends R2State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => RiddleBloc()),
        BlocProvider(create: (context) => GameBloc()),
        BlocProvider(create: (context) => UserBloc()),
        BlocProvider(create: (context) => LevelCubit()),
        BlocProvider(create: (context) => AppCubit()..initApp()),
      ],
      child: BlocBuilder<AppCubit, AppState>(
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Riddles Game EN',
            theme: state.theme,
            home: UpgradeAlert(
                upgrader: Upgrader(languageCode: state.langCode),
                child: Start()),
            localizationsDelegates: [
              ridd.intl.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            builder: (context, child) => MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
              child: child ?? const SizedBox.shrink(),
            ),
            supportedLocales: languages.map((lang) => Locale(lang, '')),
            locale: Locale(state.langCode ?? ridd.intl.locale.languageCode),
          );
        },
      ),
    );
  }
}
