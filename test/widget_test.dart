import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_saloon_app/app.dart';
import 'package:flutter_saloon_app/data/salon_data.dart';

void main() {
  test('contains all 16 supplied Jaipur listings', () {
    expect(kSalons, hasLength(16));
    expect(kSalons.map((salon) => salon.name), contains('D’Looks Beauty'));
    expect(kSalons.map((salon) => salon.name), contains('Style ’n’ Scissors'));
  });

  testWidgets('shows the Jaipur listings and supports searching', (
    tester,
  ) async {
    await tester.pumpWidget(const SalonApp());

    expect(find.text('Jaipur Salons & Parlours'), findsOneWidget);
    expect(find.text('16 of 16 listings'), findsOneWidget);

    await tester.enterText(find.byType(TextField), 'bridal makeup');
    await tester.pump();

    expect(find.text('4 of 16 listings'), findsOneWidget);
    expect(find.text('Woomen’z Unisex Salon'), findsOneWidget);
  });
}
