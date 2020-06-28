import 'package:canidrink/core/config/instance_locator.dart';
import 'package:canidrink/core/config/theme/malt_theme_data.dart';
import 'package:canidrink/logic/barcode-scanner/bloc/barcode_scanner_bloc.dart';
import 'package:canidrink/main.dart';
import 'package:canidrink/view/barcode-scanner/barcode_scanner_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    setupServiceLocator();
  });

  testWidgets('Should BarcodeScannerPage have a title when loaded',
      (WidgetTester tester) async {
    //Arrange
    final FlutterApp app = FlutterApp();
    //Act
    await tester.pumpWidget(Builder(
      builder: (BuildContext context) {
        return MaterialApp(
            title: app.appTitle,
            theme: MaltThemeConfig.maltThemeData,
            home: app.getHomePage(context, app.appTitle));
      },
    ));
    //Assert
    expect(find.text(app.appTitle), findsOneWidget);
    expect(find.byType(FloatingActionButton), findsOneWidget);
    expect(find.byKey(Key("BarcodeScannerPage")), findsOneWidget);
    expect(find.byKey(Key("ScanFloatingActionButton")), findsOneWidget);
    expect(find.byKey(Key("ScanIcon")), findsOneWidget);
  });
} //func
