import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:joola_spot/domain/models/group.dart';
import 'package:joola_spot/domain/models/player.dart';
import 'package:joola_spot/domain/models/chat.dart';
import 'package:joola_spot/presentation/screens/group_management_screen.dart';

void main() {
  late Group mockGroup;
  late List<PlayerProfile> mockMembers;
  late List<ChatMessage> mockMessages;

  setUp(() {
    mockMembers = [
      PlayerProfile(
        id: 'player1',
        name: 'John Doe',
        rating: 4.5,
        gamesPlayed: 20,
        profilePicUrl: 'https://example.com/pic1.jpg',
      ),
      PlayerProfile(
        id: 'player2',
        name: 'Jane Smith',
        rating: 4.2,
        gamesPlayed: 15,
        profilePicUrl: 'https://example.com/pic2.jpg',
      ),
    ];

    mockMessages = [
      ChatMessage(
        id: '1',
        senderId: '1',
        message: 'Hello everyone!',
        timestamp: DateTime.now(),
      ),
    ];

    mockGroup = Group(
      id: 'group1',
      name: 'Tennis Enthusiasts',
      description: 'A group for tennis lovers',
      adminId: 'player1',
      memberIds: ['player1', 'player2'],
      members: mockMembers,
      chatMessages: mockMessages,
      createdAt: DateTime.now(),
      isActive: true,
    );
  });

  testWidgets('GroupManagementScreen displays group info', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: GroupManagementScreen(group: mockGroup),
        ),
      ),
    );

    expect(find.text('Tennis Enthusiasts'), findsOneWidget);
    expect(find.text('A group for tennis lovers'), findsOneWidget);
    expect(find.text('Members (2)'), findsOneWidget);
  });

  testWidgets('GroupManagementScreen shows member list', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: GroupManagementScreen(group: mockGroup),
        ),
      ),
    );

    expect(find.text('John Doe'), findsOneWidget);
    expect(find.text('Jane Smith'), findsOneWidget);
    expect(find.text('Admin'), findsOneWidget);
  });

  testWidgets('GroupManagementScreen handles member actions', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: GroupManagementScreen(group: mockGroup),
        ),
      ),
    );

    // Open member actions menu
    await tester.tap(find.byIcon(Icons.more_vert).first);
    await tester.pumpAndSettle();

    expect(find.text('Remove from Group'), findsOneWidget);
    expect(find.text('Make Admin'), findsOneWidget);

    // Test remove member action
    await tester.tap(find.text('Remove from Group'));
    await tester.pumpAndSettle();

    expect(find.text('Member removed'), findsOneWidget);
  });

  testWidgets('GroupManagementScreen shows chat section', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: GroupManagementScreen(group: mockGroup),
        ),
      ),
    );

    expect(find.text('Group Chat'), findsOneWidget);
    expect(find.text('Hello everyone!'), findsOneWidget);

    // Test message input
    await tester.enterText(
      find.byType(TextField),
      'New message',
    );
    await tester.tap(find.byIcon(Icons.send));
    await tester.pumpAndSettle();

    expect(find.text('New message'), findsOneWidget);
  });

  testWidgets('GroupManagementScreen handles group settings', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: GroupManagementScreen(group: mockGroup),
        ),
      ),
    );

    // Open settings
    await tester.tap(find.byIcon(Icons.settings));
    await tester.pumpAndSettle();

    expect(find.text('Group Settings'), findsOneWidget);
    expect(find.text('Edit Group Info'), findsOneWidget);
    expect(find.text('Privacy Settings'), findsOneWidget);

    // Test edit group name
    await tester.tap(find.text('Edit Group Info'));
    await tester.pumpAndSettle();

    await tester.enterText(
      find.byType(TextField).first,
      'New Group Name',
    );
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();

    expect(find.text('New Group Name'), findsOneWidget);
  });

  testWidgets('GroupManagementScreen handles member invites', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: GroupManagementScreen(group: mockGroup),
        ),
      ),
    );

    await tester.tap(find.text('Invite Members'));
    await tester.pumpAndSettle();

    expect(find.text('Search Players'), findsOneWidget);

    // Test player search
    await tester.enterText(
      find.byType(TextField),
      'Mike',
    );
    await tester.pump();

    expect(find.text('Mike Johnson'), findsOneWidget);

    // Test send invite
    await tester.tap(find.text('Invite'));
    await tester.pumpAndSettle();

    expect(find.text('Invitation sent'), findsOneWidget);
  });
}
