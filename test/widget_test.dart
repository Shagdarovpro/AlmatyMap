import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:almaty_offline_map/logic/map_provider.dart';

class MockMapProvider extends MapProvider {
  bool _isMockDownloading = false;
  @override
  bool get isDownloading => _isMockDownloading;

  @override
  Future<void> downloadAlmatyRegion() async {
    _isMockDownloading = true;
    notifyListeners();
  }
}

class TestMapWrapper extends StatelessWidget {
  const TestMapWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<MapProvider>();
    return Scaffold(
      body: Column(
        children: [
          TextField(
            key: const Key('searchField'),
            onChanged: (v) => provider.updateSearchQuery(v),
          ),
          Expanded(
            child: ListView(
              children: provider.filteredLandmarks
                  .map((l) => ListTile(title: Text(l.name)))
                  .toList(),
            ),
          ),
          if (provider.isDownloading) const LinearProgressIndicator(),
        ],
      ),
    );
  }
}

void main() {
  group('MapProvider Logic & Widget Tests', () {
    
    test('MapProvider filter logic test', () {
      final provider = MapProvider();
      provider.updateSearchQuery('Арбат');
      expect(provider.filteredLandmarks.length, 1);
      expect(provider.filteredLandmarks.first.name, 'Арбат');
    });

    testWidgets('Search filters landmarks correctly in UI', (WidgetTester tester) async {
      final provider = MapProvider();

      await tester.pumpWidget(
        ChangeNotifierProvider<MapProvider>.value(
          value: provider,
          child: const MaterialApp(home: TestMapWrapper()),
        ),
      );

      expect(find.text('Медеу'), findsOneWidget);

      await tester.enterText(find.byKey(const Key('searchField')), 'Арбат');
      await tester.pump(); 

      // ИСПРАВЛЕНИЕ: Ищем текст "Арбат", который НЕ является частью TextField
      // Ищем именно виджет типа ListTile, содержащий этот текст
      expect(
        find.descendant(
          of: find.byType(ListTile), 
          matching: find.text('Арбат')
        ), 
        findsOneWidget
      );
      
      expect(find.text('Медеу'), findsNothing);
    });

    testWidgets('Download indicator appears', (WidgetTester tester) async {
      final mock = MockMapProvider();
      await tester.pumpWidget(
        ChangeNotifierProvider<MapProvider>.value(
          value: mock,
          child: const MaterialApp(home: TestMapWrapper()),
        ),
      );

      expect(find.byType(LinearProgressIndicator), findsNothing);
      await mock.downloadAlmatyRegion();
      await tester.pump();
      expect(find.byType(LinearProgressIndicator), findsOneWidget);
    });
  });
}