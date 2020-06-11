import 'package:canidrink/core/config/theme/malt_theme_data.dart';
import 'package:canidrink/view/barcode-scanner/barcode_scanner_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'logic/barcode-scanner/bloc/barcodescanner_bloc.dart';

void main() => runApp(FlutterApp());

class FlutterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final String appTitle = "Can I Drink?";
    return MaterialApp(
        title: appTitle,
        theme: MaltThemeConfig.maltThemeData,
        home: BlocProvider(
          create: (context) => BarcodescannerBloc(),
          child: BarcodeScannerPage(
            pageTitle: appTitle,
          ),
        ));
  } //func
} //class
