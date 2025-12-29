import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_tile_caching/flutter_map_tile_caching.dart';
import 'package:latlong2/latlong.dart';

class Landmark {
  final String name;
  final LatLng location;
  final IconData icon;
  Landmark(this.name, this.location, this.icon);
}

class MapProvider extends ChangeNotifier {
  final MapController mapController = MapController();

  double _downloadProgress = 0.0;
  bool _isDownloading = false;
  String _searchQuery = '';

  double get downloadProgress => _downloadProgress;
  bool get isDownloading => _isDownloading;
  String get searchQuery => _searchQuery;

  final List<Landmark> allLandmarks = [
    Landmark('Медеу', const LatLng(43.1574, 77.0590), Icons.ice_skating),
    Landmark('Шымбулак', const LatLng(43.1285, 77.0812), Icons.downhill_skiing),
    Landmark('Кок-Тобе', const LatLng(43.2323, 76.9760), Icons.terrain),
    Landmark('Парк 28 Панфиловцев', const LatLng(43.2594, 76.9541), Icons.museum),
    Landmark('Арбат', const LatLng(43.2620, 76.9425), Icons.directions_walk),
  ];

  List<Landmark> get filteredLandmarks => allLandmarks
      .where((l) => l.name.toLowerCase().contains(_searchQuery.toLowerCase()))
      .toList();

  void updateSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  Future<void> downloadAlmatyRegion() async {
    if (_isDownloading) return;

    const store = FMTCStore('AlmatyTiles');
    
    // Определяем регион для скачивания
    final region = RectangleRegion(
      LatLngBounds(
        const LatLng(43.1000, 76.8000),
        const LatLng(43.3500, 77.1000),
      ),
    );

    // Параметры скачивания
    final downloadableRegion = region.toDownloadable(
      minZoom: 12,
      maxZoom: 16,
      options: TileLayer(
        urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
        userAgentPackageName: 'com.example.almaty_offline_map',
      ),
    );

    _isDownloading = true;
    _downloadProgress = 0.0;
    notifyListeners();

    // Запуск скачивания (Специфично для версии 8.1.1)
    final downloadStream = store.download.startForeground(
      region: downloadableRegion,
      parallelThreads: 5,
    );

    downloadStream.listen(
      (progress) {
        // В версии 8.1.1 геттеры называются так:
        final int current = progress.successfulTiles;
        final int total = progress.maxTiles;

        if (total > 0) {
          _downloadProgress = current / total;
        }
        
        // Завершение загрузки
        if (current >= total && total > 0) {
          _isDownloading = false;
        }
        notifyListeners();
      },
      onError: (err) {
        _isDownloading = false;
        notifyListeners();
        debugPrint('Ошибка при скачивании: $err');
      },
    );
  }
}