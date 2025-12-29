import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:almaty_offline_map/main.dart';
import 'package:almaty_offline_map/logic/map_provider.dart';
import 'package:almaty_offline_map/logic/locator.dart';

void main() {
  // Настраиваем локатор перед тестами
  setUpAll(() {
    // Если локатор уже настроен, сбрасываем его, чтобы избежать дубликатов в тестах
    if (locator.isRegistered<MapProvider>()) {
      locator.unregister<MapProvider>();
    }
    setupLocator();
  });

  testWidgets('Search bar filtering test', (WidgetTester tester) async {
    // Запускаем приложение
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => locator<MapProvider>(),
        child: const AlmatyMapApp(),
      ),
    );

    // Находим текстовое поле поиска
    final searchField = find.byType(TextField);
    expect(searchField, findsOneWidget);

    // Вводим текст "Medeu"
    await tester.enterText(searchField, 'Medeu');
    await tester.pump(); // Даем время на перерисовку

    // Проверяем, что поиск сработал (через провайдер)
    final provider = locator<MapProvider>();
    expect(provider.landmarks.length, 1);
    expect(provider.landmarks.first.name, 'Medeu');
  });
}