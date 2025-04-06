import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:joola_spot/domain/models/court.dart';
import 'package:joola_spot/domain/providers/court_provider.dart';
import 'package:joola_spot/presentation/widgets/nearby_courts_list.dart';

void main() {
  final mockCourts = [
    Court(
      id: '1',
      name: 'Tennis Club A',
      latitude: 28.6139,
      longitude: 77.2090,
      address: '123 Sports Lane, Delhi',
      rating: 4.5,
      isJoolaVerified: true,
      numberOfCourts: 4,
      photoUrl: null,
      amenities: ['Parking', 'Changing Rooms', 'Pro Shop'],
      openingHours: '06:00-22:00',
      pricePerHour: 800,
      distance: 2.5,
    ),
    Court(
      id: '2',
      name: 'Sports Arena B',
      latitude: 28.5672,
      longitude: 77.2410,
      address: '456 Game Street, Delhi',
      rating: 4.2,
      isJoolaVerified: false,
      numberOfCourts: 2,
      photoUrl: null,
      amenities: ['Parking', 'Cafe'],
      openingHours: '07:00-21:00',
      pricePerHour: 600,
      distance: 3.1,
    ),
  ];

  testWidgets('NearbyCourtsList shows courts', (WidgetTester tester) async {
    final container = ProviderContainer(
      overrides: [
        nearbyCourtsProvider.overrideWith((ref) => Future.value(mockCourts)),
      ],
    );

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: const MaterialApp(
          home: Scaffold(
            body: NearbyCourtsList(),
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    // Verify that courts are displayed
    expect(find.byType(Card), findsOneWidget);
    expect(find.text('Tennis Club A'), findsOneWidget);
    expect(find.text('Sports Arena B'), findsOneWidget);
    expect(find.text(' 4.5 • 2.5 km'), findsOneWidget);
    expect(find.text(' 4.2 • 3.1 km'), findsOneWidget);
    expect(find.text('₹800'), findsOneWidget);
    expect(find.text('₹600'), findsOneWidget);
    expect(find.text('Joola Verified'), findsOneWidget);
  });
}
