import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'logic/map_provider.dart';
import 'logic/locator.dart';

void main() async {
  // Гарантируем инициализацию плагинов Flutter
  WidgetsFlutterBinding.ensureInitialized();
  
  // Инициализируем Service Locator (GetIt)
  setupLocator();
  
  runApp(
    ChangeNotifierProvider(
      // Получаем экземпляр провайдера из локатора
      create: (_) => locator<MapProvider>(),
      child: const AlmatyMapApp(),
    ),
  );
}

class AlmatyMapApp extends StatelessWidget {
  const AlmatyMapApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Almaty Offline Map',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.blue,
      ),
      home: const MapScreen(),
    );
  }
}

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Слушаем изменения в провайдере
    final provider = context.watch<MapProvider>();

    return Scaffold(
      body: Stack(
        children: [
          // 1. Слой карты
          FlutterMap(
            mapController: provider.mapController,
            options: const MapOptions(
              initialCenter: LatLng(43.2389, 76.8897), // Центр Алматы
              initialZoom: 12.0,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.almaty_offline_map',
                // Здесь в будущем подключится FMTC через tileProvider
              ),
              // Слой маркеров достопримечательностей
              MarkerLayer(
                markers: provider.landmarks.map((shop) {
                  return Marker(
                    point: shop.location,
                    width: 80,
                    height: 80,
                    child: const Icon(
                      Icons.location_on,
                      color: Colors.red,
                      size: 40,
                    ),
                  );
                }).toList(),
              ),
            ],
          ),

          // 2. Поисковая панель (верхняя часть)
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Поиск мест (Медеу, Шымбулак...)',
                      prefixIcon: const Icon(Icons.search),
                      filled: true,
                      fillColor: Colors.white.withValues(alpha: 0.9),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    onChanged: (value) => provider.updateSearch(value),
                  ),
                ],
              ),
            ),
          ),

          // 3. Индикатор загрузки офлайн-карт
          if (provider.isDownloading)
            Positioned(
              bottom: 120,
              left: 20,
              right: 20,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      const Text('Загрузка карты Алматы для офлайн доступа...'),
                      const SizedBox(height: 10),
                      LinearProgressIndicator(value: provider.downloadProgress),
                      Text('${(provider.downloadProgress * 100).toStringAsFixed(1)}%'),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
      
      // Кнопка скачивания региона
      floatingActionButton: FloatingActionButton.extended(
        onPressed: provider.isDownloading ? null : () => provider.downloadAlmatyRegion(),
        label: const Text('Скачать карту'),
        icon: const Icon(Icons.download_for_offline),
      ),
    );
  }
}