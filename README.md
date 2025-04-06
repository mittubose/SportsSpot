# Joola Spot - Pickleball Court Finder & Game Organizer

A Flutter-based mobile application that helps pickleball players find courts, organize games, and connect with other players.

## Development Phases

### Phase 1: Core Infrastructure & Court Discovery
**Timeline**: 

#### Features
- Basic app architecture setup
- User authentication
- Court discovery (Map & List view)
- Basic court details display

#### Technical Components
- Firebase Authentication
- Google Maps integration
- Basic state management (Riverpod)
- Court data models
- RESTful API service layer

#### Testing Strategy
```dart
// court_repository_test.dart
void main() {
  group('CourtRepository Tests', () {
    test('fetchNearbyCourtsShouldReturnValidList', () async {
      // Test court fetching within radius
    });
    
    test('courtDetailsShouldContainRequiredFields', () {
      // Validate court model fields
    });
  });
}

// location_service_test.dart
void main() {
  group('LocationService Tests', () {
    test('getCurrentLocationShouldReturnValidCoordinates', () async {
      // Test location retrieval
    });
  });
}
```

### Phase 2: Court Management & Ratings

#### Features
- Detailed court profiles
- Court ratings & reviews
- Photo uploads
- Joola verification system

#### Testing Strategy
```dart
// rating_service_test.dart
void main() {
  group('RatingService Tests', () {
    test('calculateAverageRatingShouldBeAccurate', () {
      // Test rating calculations
    });
    
    test('photoUploadShouldCompressAndStore', () async {
      // Test image handling
    });
  });
}
```

### Phase 3: Game Organization

#### Features
- Create/join games
- Player profiles
- Game scheduling
- Court availability checking

#### Testing Strategy
```dart
// game_service_test.dart
void main() {
  group('GameService Tests', () {
    test('createGameShouldValidateRequiredFields', () {
      // Test game creation validation
    });
    
    test('joinGameShouldUpdatePlayerList', () async {
      // Test player management
    });
  });
}
```

### Phase 4: Social Features & Payments

#### Features
- In-app messaging
- Friend connections
- Court booking integration
- Payment splitting

#### Testing Strategy
```dart
// chat_service_test.dart
void main() {
  group('ChatService Tests', () {
    test('messageDeliveryShouldBeReliable', () async {
      // Test message delivery
    });
  });
}

// payment_service_test.dart
void main() {
  group('PaymentService Tests', () {
    test('splitPaymentShouldDivideEvenly', () {
      // Test payment calculations
    });
  });
}
```

## Architecture

### Core Principles
- Clean Architecture
- SOLID principles
- Dependency Injection
- Repository Pattern

### Directory Structure
```
lib/
├── core/
│   ├── config/
│   ├── errors/
│   └── utils/
├── data/
│   ├── models/
│   ├── repositories/
│   └── services/
├── domain/
│   ├── entities/
│   └── usecases/
└── presentation/
    ├── screens/
    ├── widgets/
    └── providers/
```

## Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  firebase_core: ^2.24.2
  firebase_auth: ^4.15.3
  google_maps_flutter: ^2.5.0
  riverpod: ^2.4.9
  dio: ^5.4.0
  cached_network_image: ^3.3.0
  geolocator: ^10.1.0

dev_dependencies:
  flutter_test:
    sdk: flutter
  mockito: ^5.4.4
  build_runner: ^2.4.7
```

## Getting Started

1. Clone the repository
```bash
git clone https://github.com/your-org/joola-spot.git
```

2. Install dependencies
```bash
flutter pub get
```

3. Set up environment variables
```bash
cp .env.example .env
# Add your API keys
```

4. Run tests
```bash
flutter test
```

5. Run the app
```bash
flutter run
```

## Testing Guidelines

### Unit Tests
- All repositories must have 80%+ coverage
- Mock external dependencies
- Test edge cases and error scenarios

### Widget Tests
- Test all reusable widgets
- Verify widget behavior with different states
- Test user interactions

### Integration Tests
- Test complete user flows
- Verify API integrations
- Test offline functionality

## Code Style

Follow Flutter's official style guide and these additional rules:
- Use meaningful variable names
- Keep methods focused and small
- Document complex logic
- Use constants for magic numbers/strings

## CI/CD Pipeline

GitHub Actions workflow for:
- Running tests
- Code analysis
- Building APK/IPA
- Deploying to stores

## Contributing

1. Create feature branch
2. Write tests
3. Implement feature
4. Create PR with description
5. Get code review
6. Merge after approval

## License

MIT License - see LICENSE.md 