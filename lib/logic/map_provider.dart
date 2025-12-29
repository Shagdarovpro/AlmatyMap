import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

// Простая модель данных для достопримечательности
class Landmark {
  final String name;
  final LatLng location;

  Landmark({required this.name, required this.location});
}

class MapProvider with ChangeNotifier {
  final MapController mapController = MapController();
  
  // Полный список мест
  final List<Landmark> _allLandmarks = [
    Landmark(name: 'Medeu', location: const LatLng(43.1575, 77.0590)),
    Landmark(name: 'Shymbulak', location: const LatLng(43.1285, 77.0801)),
    Landmark(name: 'Kok-Tobe', location: const LatLng(43.2323, 76.9761)),
    Landmark(name: 'Zenkov Cathedral', location: const LatLng(43.2591, 76.9535)),
  ];

  // Список для отображения (отфильтрованный)
  List<Landmark> _filteredLandmarks = [];
  
  bool _isDownloading = false;
  double _downloadProgress = 0.0;

  MapProvider() {
    _filteredLandmarks = _allLandmarks;
  }

  // Геттеры (то, что запрашивает main.dart)
  List<Landmark> get landmarks => _filteredLandmarks;
  bool get isDownloading => _isDownloading;
  double get downloadProgress => _downloadProgress;

  // Логика поиска
  void updateSearch(String query) {
    if (query.isEmpty) {
      _filteredLandmarks = _allLandmarks;
    } else {
      _filteredLandmarks = _allLandmarks
          .where((l) => l.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }

  // Имитация скачивания (твоя логика с FMTC остается здесь)
  Future<void> downloadAlmatyRegion() async {
    _isDownloading = true;
    _downloadProgress = 0.0;
    notifyListeners();

    // Вставь здесь свой реальный вызов FMTC скачивания
    for (int i = 0; i <= 10; i++) {
      await Future.delayed(const Duration(milliseconds: 500));
      _downloadProgress = i / 10;
      notifyListeners();
    }

    _isDownloading = false;
    notifyListeners();
  }
}