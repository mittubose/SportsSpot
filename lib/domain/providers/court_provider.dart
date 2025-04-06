import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:joola_spot/domain/models/court.dart';
import 'package:joola_spot/domain/repositories/court_repository.dart';

final courtRepositoryProvider = Provider<CourtRepository>((ref) {
  return CourtRepository();
});

final nearbyCourtsProvider = FutureProvider<List<Court>>((ref) async {
  final repository = ref.watch(courtRepositoryProvider);
  return repository.getNearby();
});

final selectedCourtProvider = StateProvider<Court?>((ref) => null);

final courtSearchQueryProvider = StateProvider<String>((ref) => '');
