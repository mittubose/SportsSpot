import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:joola_spot/domain/models/time_slot.dart';
import 'package:joola_spot/domain/models/venue.dart';
import 'package:joola_spot/presentation/screens/venue_details_screen.dart';

void main() {
  final now = DateTime.now();
  final mockVenue = Venue(
    id: '1',
    name: 'Test Venue',
    address: 'Test Address',
    latitude: 0,
    longitude: 0,
    amenities: ['WiFi', 'Parking', 'Changing Room'],
    timeSlots: [
      TimeSlot(
        id: '1',
        startTime: DateTime(now.year, now.month, now.day, 10, 0),
        endTime: DateTime(now.year, now.month, now.day, 11, 0),
        price: 500,
        isAvailable: true,
      ),
      TimeSlot(
        id: '2',
        startTime: DateTime(now.year, now.month, now.day, 11, 0),
        endTime: DateTime(now.year, now.month, now.day, 12, 0),
        price: 500,
        isAvailable: false,
      ),
    ],
    currentBookings: [],
    publicGameIds: ['game1', 'game2'],
    rating: 4.5,
    totalRatings: 10,
    isActive: true,
    createdAt: DateTime.now(),
  );

  testWidgets('VenueDetailsScreen displays venue information', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: VenueDetailsScreen(venue: mockVenue),
        ),
      ),
    );
    await tester.pumpAndSettle();

    // Test venue name and address
    expect(find.text('Test Venue'), findsOneWidget);
    expect(find.text('Test Address'), findsOneWidget);

    // Test rating display
    expect(find.text('4.5'), findsOneWidget);
    expect(find.text('(10)'), findsOneWidget);

    // Test amenities
    expect(find.text('WiFi'), findsOneWidget);
    expect(find.text('Parking'), findsOneWidget);
    expect(find.text('Changing Room'), findsOneWidget);
  });

  testWidgets('VenueDetailsScreen shows available time slots', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: VenueDetailsScreen(venue: mockVenue),
        ),
      ),
    );
    await tester.pumpAndSettle();

    // Test date selector
    expect(find.text('Available Slots'), findsOneWidget);

    // Test time slots display
    expect(find.text('10:00 - 11:00'), findsOneWidget);
  });

  testWidgets('VenueDetailsScreen handles unavailable time slots',
      (tester) async {
    final venueWithNoSlots = mockVenue.copyWith(timeSlots: []);

    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: VenueDetailsScreen(venue: venueWithNoSlots),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('No slots available for this date'), findsOneWidget);
  });

  testWidgets('VenueDetailsScreen shows public games section', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: VenueDetailsScreen(venue: mockVenue),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Public Games'), findsOneWidget);
  });

  testWidgets('VenueDetailsScreen date selection changes available slots',
      (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: VenueDetailsScreen(venue: mockVenue),
        ),
      ),
    );
    await tester.pumpAndSettle();

    // Find and tap tomorrow's date
    final tomorrow = DateTime.now().add(const Duration(days: 1));
    final tomorrowDay = tomorrow.day.toString();
    await tester.tap(find.text(tomorrowDay));
    await tester.pumpAndSettle();

    // Verify no slots message for tomorrow
    expect(find.text('No slots available for this date'), findsOneWidget);
  });
}
