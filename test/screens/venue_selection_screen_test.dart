import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:joola_spot/domain/models/court.dart';
import 'package:joola_spot/domain/models/time_slot.dart';
import 'package:joola_spot/domain/models/venue.dart';
import 'package:joola_spot/domain/providers/court_provider.dart';
import 'package:joola_spot/presentation/screens/venue_selection_screen.dart';

void main() {
  final mockCourt = Court(
    id: '1',
    name: 'Test Court',
    latitude: 0,
    longitude: 0,
    address: '123 Test St',
    rating: 4.5,
    isJoolaVerified: true,
    numberOfCourts: 2,
    photoUrl: null,
    amenities: ['WiFi', 'Parking'],
    openingHours: '10:00-22:00',
    pricePerHour: 500,
  );

  testWidgets('VenueSelectionScreen displays court information',
      (tester) async {
    // Override the provider
    final container = ProviderContainer(
      overrides: [
        nearbyCourtsProvider.overrideWith((ref) => Future.value([mockCourt])),
      ],
    );

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: const MaterialApp(
          home: VenueSelectionScreen(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    // Verify court information is displayed
    expect(find.text('Test Court'), findsOneWidget);
    expect(find.text('123 Test St'), findsOneWidget);
    expect(find.text('4.5'), findsOneWidget);
    expect(find.text('₹500.0'), findsOneWidget);
    expect(find.text('per hour'), findsOneWidget);
  });

  testWidgets('VenueSelectionScreen shows time slots', (tester) async {
    // Override the provider
    final container = ProviderContainer(
      overrides: [
        nearbyCourtsProvider.overrideWith((ref) => Future.value([mockCourt])),
      ],
    );

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: const MaterialApp(
          home: VenueSelectionScreen(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    // Tap to expand time slots
    await tester.tap(find.text('Available Time Slots'));
    await tester.pumpAndSettle();

    // Verify time slots section is displayed
    expect(find.byType(FilterChip), findsWidgets);
    expect(find.byType(RangeSlider), findsNothing);
  });

  testWidgets('VenueSelectionScreen handles back navigation', (tester) async {
    // Override the provider
    final container = ProviderContainer(
      overrides: [
        nearbyCourtsProvider.overrideWith((ref) => Future.value([mockCourt])),
      ],
    );

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) => TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const VenueSelectionScreen(),
                    ),
                  );
                },
                child: const Text('Open Venue Selection'),
              ),
            ),
          ),
        ),
      ),
    );

    // Navigate to venue selection
    await tester.tap(find.text('Open Venue Selection'));
    await tester.pumpAndSettle();

    // Verify we're on the venue selection screen
    expect(find.byType(VenueSelectionScreen), findsOneWidget);

    // Tap back button
    await tester.tap(find.byIcon(Icons.arrow_back));
    await tester.pumpAndSettle();

    // Verify we're back on the previous screen
    expect(find.byType(VenueSelectionScreen), findsNothing);
    expect(find.text('Open Venue Selection'), findsOneWidget);
  });

  testWidgets('VenueSelectionScreen handles venue selection', (tester) async {
    // Override the provider
    final container = ProviderContainer(
      overrides: [
        nearbyCourtsProvider.overrideWith((ref) => Future.value([mockCourt])),
      ],
    );

    Venue? selectedVenue;

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) => TextButton(
                onPressed: () async {
                  selectedVenue = await Navigator.push<Venue>(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const VenueSelectionScreen(),
                    ),
                  );
                },
                child: const Text('Open Venue Selection'),
              ),
            ),
          ),
        ),
      ),
    );

    // Navigate to venue selection
    await tester.tap(find.text('Open Venue Selection'));
    await tester.pumpAndSettle();

    // Expand time slots
    await tester.tap(find.text('Available Time Slots'));
    await tester.pumpAndSettle();

    // Select a time slot
    await tester.tap(find.byType(FilterChip).first);
    await tester.pumpAndSettle();

    // Tap continue
    await tester.tap(find.text('Continue'));
    await tester.pumpAndSettle();

    // Verify the venue was selected and we're back on the previous screen
    expect(selectedVenue, isNotNull);
    expect(selectedVenue!.name, equals('Test Court'));
    expect(selectedVenue!.address, equals('123 Test St'));
    expect(find.byType(VenueSelectionScreen), findsNothing);
  });

  testWidgets('VenueSelectionScreen handles search and filters',
      (tester) async {
    // Override the provider
    final container = ProviderContainer(
      overrides: [
        nearbyCourtsProvider.overrideWith((ref) => Future.value([mockCourt])),
      ],
    );

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: const MaterialApp(
          home: VenueSelectionScreen(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    // Test search
    await tester.enterText(find.byType(TextField), 'Test');
    await tester.pumpAndSettle();
    expect(find.text('Test Court'), findsOneWidget);

    await tester.enterText(find.byType(TextField), 'NonExistent');
    await tester.pumpAndSettle();
    expect(find.text('No venues found'), findsOneWidget);

    // Test filters
    await tester.tap(find.byIcon(Icons.filter_list));
    await tester.pumpAndSettle();

    expect(find.text('Filter Venues'), findsOneWidget);
    expect(find.byType(SwitchListTile), findsOneWidget);
    expect(find.byType(RangeSlider), findsOneWidget);

    // Close filter dialog
    await tester.tap(find.text('Apply'));
    await tester.pumpAndSettle();
  });
}
