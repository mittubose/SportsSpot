import 'package:joola_spot/domain/models/court.dart';

class CourtRepository {
  // TODO: Implement actual API calls
  Future<List<Court>> getNearby() async {
    await Future.delayed(const Duration(seconds: 1));
    return [
      Court(
        id: '1',
        name: 'DLF Sports Complex',
        latitude: 12.9716,
        longitude: 77.5946,
        address: 'DLF Phase 1, Gurgaon, Haryana',
        rating: 4.5,
        isJoolaVerified: true,
        numberOfCourts: 4,
        distance: 2.5,
        photoUrl: null,
        amenities: ['Parking', 'Changing Rooms', 'Cafeteria'],
        openingHours: '6:00 AM - 10:00 PM',
        pricePerHour: 800,
      ),
      Court(
        id: '2',
        name: 'Siri Fort Sports Complex',
        latitude: 28.5529,
        longitude: 77.2167,
        address: 'August Kranti Marg, New Delhi',
        rating: 4.8,
        isJoolaVerified: true,
        numberOfCourts: 6,
        distance: 3.2,
        photoUrl: null,
        amenities: ['Parking', 'Pro Shop', 'Coaching'],
        openingHours: '5:00 AM - 9:00 PM',
        pricePerHour: 600,
      ),
      Court(
        id: '3',
        name: 'Koramangala Indoor Stadium',
        latitude: 12.9279,
        longitude: 77.6271,
        address: '4th Block, Koramangala, Bangalore',
        rating: 4.2,
        isJoolaVerified: false,
        numberOfCourts: 2,
        distance: 1.8,
        photoUrl: null,
        amenities: ['Parking', 'Equipment Rental'],
        openingHours: '7:00 AM - 11:00 PM',
        pricePerHour: 500,
      ),
      Court(
        id: '4',
        name: 'Powai Sports Club',
        latitude: 19.1176,
        longitude: 72.9060,
        address: 'Powai, Mumbai, Maharashtra',
        rating: 4.6,
        isJoolaVerified: true,
        numberOfCourts: 3,
        distance: 4.1,
        photoUrl: null,
        amenities: ['Parking', 'Changing Rooms', 'Swimming Pool'],
        openingHours: '6:00 AM - 10:00 PM',
        pricePerHour: 700,
      ),
    ];
  }

  Future<Court> getById(String id) async {
    final courts = await getNearby();
    return courts.firstWhere((court) => court.id == id);
  }

  Future<List<Court>> search(String query) async {
    final courts = await getNearby();
    if (query.isEmpty) return courts;

    return courts
        .where((court) =>
            court.name.toLowerCase().contains(query.toLowerCase()) ||
            court.address.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }
}
