import 'package:canidrink/core/config/instance_locator.dart';
import 'package:canidrink/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    setupServiceLocator();
  });

  testWidgets('Should BarcodeScannerPage have a title when loaded',
      (WidgetTester tester) async {
    //Arrange
    final String title = "Can I Drink?";
    //Act
    await tester.pumpWidget(FlutterApp());
    //Assert
    expect(find.text(title), findsOneWidget);
    expect(find.byType(FloatingActionButton), findsOneWidget);
    expect(find.byKey(Key("BarcodeScannerPage")), findsOneWidget);
    expect(find.byKey(Key("ScanFloatingActionButton")), findsOneWidget);
    expect(find.byKey(Key("ScanIcon")), findsOneWidget);
  });
} //func
