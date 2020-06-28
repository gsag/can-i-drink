import 'package:canidrink/core/config/theme/malt_theme_data.dart';
import 'package:canidrink/view/barcode-scanner/barcode_scanner_page.dart';
import 'package:flare_splash_screen/flare_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/config/instance_locator.dart';
import 'logic/barcode-scanner/bloc/barcode_scanner_bloc.dart';

void main() {
  setupServiceLocator();
  runApp(FlutterApp());
} //func

class FlutterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final String appTitle = "Can I Drink?";
    final String splashPath = "assets/splash/splash.flr";
    final String splashAnimationName = "Splash";

    return MaterialApp(
      title: appTitle,
      theme: MaltThemeConfig.maltThemeData,
      home: SplashScreen.navigate(
        name: splashPath,
        startAnimation: splashAnimationName,
        next: (context) => this._getHomeWidget(context, appTitle),
        until: () => Future.delayed(Duration(seconds: 2)),
      ),
    );
  } //func

  Widget _getHomeWidget(BuildContext context, String appTitle) {
    final provider = BlocProvider(
      create: (context) => BarcodeScannerBloc(),
      child: BarcodeScannerPage(
        key: Key("BarcodeScannerPage"),
        pageTitle: appTitle,
      ),
    );
    return provider;
  } //func
} //class
