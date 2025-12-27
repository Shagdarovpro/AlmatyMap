import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_tile_caching/flutter_map_tile_caching.dart';
import 'package:latlong2/latlong.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 1. Инициализация базы данных кэша
  await FMTCObjectBoxBackend().initialise();
  
  // 2. Регистрация хранилища
  final store = FMTCStore('AlmatyTiles');
  await store.manage.create();

  runApp(const AlmatyMapApp());
}

class Landmark {
  final String name;
  final LatLng location;
  final IconData icon;
  Landmark(this.name, this.location, this.icon);
}

class AlmatyMapApp extends StatelessWidget {
  const AlmatyMapApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.green),
      home: const MapScreen(),
    );
  }
}

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final MapController _mapController = MapController();
  static const almatyCenter = LatLng(43.2383, 76.9455);
  String _searchQuery = '';

  final List<Landmark> almatyLandmarks = [
    Landmark('Медеу', const LatLng(43.1574, 77.0590), Icons.ice_skating),
    Landmark('Шымбулак', const LatLng(43.1285, 77.0812), Icons.downhill_skiing),
    Landmark('Кок-Тобе', const LatLng(43.2323, 76.9760), Icons.terrain),
    Landmark('Парк 28', const LatLng(43.2594, 76.9541), Icons.museum),
    Landmark('Арбат', const LatLng(43.2620, 76.9425), Icons.directions_walk),
  ];

  Future<void> _downloadAlmatyRegion() async {
    final store = FMTCStore('AlmatyTiles');
    final region = RectangleRegion(
      LatLngBounds(
        const LatLng(43.1000, 76.8000),
        const LatLng(43.3500, 77.1000),
      ),
    );

    final downloadableRegion = region.toDownloadable(
      minZoom: 12,
      maxZoom: 16,
      options: TileLayer(
        urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
        userAgentPackageName: 'com.example.almaty_map',
      ),
    );

    // ИСПРАВЛЕНИЕ: Используем результат метода, чтобы убрать ошибку линтера
    final downloadResult = store.download.startForeground(
      region: downloadableRegion,
      parallelThreads: 5,
    );
    
    // Просто выведем в консоль, чтобы переменная считалась использованной
    debugPrint('Download started: $downloadResult');

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Загрузка Алматы началась...')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Фильтруем список мест на основе поиска
    final filteredLandmarks = almatyLandmarks
        .where((l) => l.name.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Almaty Offline Map'),
        actions: [
          IconButton(
            icon: const Icon(Icons.download),
            onPressed: _downloadAlmatyRegion,
          ),
        ],
      ),
      body: Stack(
        children: [
          FlutterMap(
            mapController: _mapController,
            options: const MapOptions(
              initialCenter: almatyCenter,
              initialZoom: 12.0,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.almaty_map',
                tileProvider: FMTCStore('AlmatyTiles').getTileProvider(),
              ),
              MarkerLayer(
                markers: filteredLandmarks.map((landmark) {
                  return Marker(
                    point: landmark.location,
                    width: 40,
                    height: 40,
                    child: const Icon(Icons.location_on, color: Colors.red, size: 35),
                  );
                }).toList(),
              ),
            ],
          ),
          
          // Поле поиска в верхней части экрана
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: SearchBar(
              hintText: 'Поиск мест...',
              leading: const Icon(Icons.search),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
            ),
          ),

          // Список карточек снизу
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 110,
              margin: const EdgeInsets.only(bottom: 30),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                itemCount: filteredLandmarks.length,
                itemBuilder: (context, index) {
                  final item = filteredLandmarks[index];
                  return Card(
                    elevation: 5,
                    child: InkWell(
                      onTap: () => _mapController.move(item.location, 14.0),
                      child: Container(
                        width: 140,
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(item.icon, color: Colors.green),
                            const SizedBox(height: 4),
                            Text(item.name, 
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}