import 'package:flutter_test/flutter_test.dart';
import 'package:joola_spot/domain/repositories/court_repository.dart';

void main() {
  late CourtRepository repository;

  setUp(() {
    repository = CourtRepository();
  });

  group('CourtRepository', () {
    test('getNearby returns non-empty list', () async {
      final courts = await repository.getNearby();
      expect(courts, isNotEmpty);
      expect(courts.first.name, isNotEmpty);
      expect(courts.first.rating, isPositive);
    });

    test('getById returns correct court', () async {
      final courts = await repository.getNearby();
      final firstCourt = courts.first;
      final foundCourt = await repository.getById(firstCourt.id);
      expect(foundCourt.id, equals(firstCourt.id));
      expect(foundCourt.name, equals(firstCourt.name));
    });

    test('search filters courts correctly', () async {
      final courts = await repository.getNearby();
      final firstCourt = courts.first;
      final searchResults =
          await repository.search(firstCourt.name.substring(0, 3));

      expect(
        searchResults.any((court) =>
            court.id == firstCourt.id && court.name == firstCourt.name),
        isTrue,
        reason: 'Search results should contain the first court',
      );
    });

    test('search with empty query returns all courts', () async {
      final allCourts = await repository.getNearby();
      final searchResults = await repository.search('');
      expect(searchResults.length, equals(allCourts.length));
    });
  });
}
