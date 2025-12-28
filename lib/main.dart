import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_tile_caching/flutter_map_tile_caching.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
// ВНИМАНИЕ: Путь должен соответствовать папке в проводнике!
import 'logic/map_provider.dart'; 

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FMTCObjectBoxBackend().initialise();
  await const FMTCStore('AlmatyTiles').manage.create();

  runApp(
    ChangeNotifierProvider(
      create: (_) => MapProvider(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MapScreen(),
      ),
    ),
  );
}

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<MapProvider>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Almaty Offline'),
        actions: [
          IconButton(
            icon: Icon(provider.isDownloading ? Icons.sync : Icons.download),
            onPressed: () => provider.downloadAlmatyRegion(),
          ),
        ],
      ),
      body: Stack(
        children: [
          FlutterMap(
            mapController: provider.mapController,
            options: const MapOptions(
              initialCenter: LatLng(43.2383, 76.9455),
              initialZoom: 12,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                tileProvider: const FMTCStore('AlmatyTiles').getTileProvider(),
              ),
              MarkerLayer(
                markers: provider.filteredLandmarks.map((l) => Marker(
                  point: l.location,
                  child: const Icon(Icons.location_on, color: Colors.red),
                )).toList(),
              ),
            ],
          ),
          if (provider.isDownloading)
            LinearProgressIndicator(value: provider.downloadProgress),
        ],
      ),
    );
  }
}