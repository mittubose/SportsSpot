import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:joola_spot/presentation/routes/app_router.dart';

void main() {
  runApp(
    const ProviderScope(
      child: JoolaSpotApp(),
    ),
  );
}

class JoolaSpotApp extends StatelessWidget {
  const JoolaSpotApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Joola Spot',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
        ),
        useMaterial3: true,
      ),
      onGenerateRoute: AppRouter.onGenerateRoute,
    );
  }
}
