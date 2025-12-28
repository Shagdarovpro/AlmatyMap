# Almaty Offline Map 🏔️

A high-performance Flutter application designed for offline navigation in Almaty, Kazakhstan. The app allows users to explore key landmarks and download specific map regions for offline use.

## ✨ Features

* **Offline First**: Tile caching mechanism to ensure map availability without internet.
* **Smart Search**: Real-time filtering of landmarks using the Provider state management.
* **Interactive Landmarks**: Custom markers and descriptive cards for famous spots like Medeu, Shymbulak, and Kok-Tobe.
* **Dynamic Progress Tracking**: Real-time download progress bar with background task handling.

## 🛠️ Tech Stack

* **Framework**: [Flutter](https://flutter.dev)
* **State Management**: [Provider](https://pub.dev/packages/provider)
* **Mapping**: [flutter_map](https://pub.dev/packages/flutter_map) (v7.0.2)
* **Offline Engine**: [flutter_map_tile_caching](https://pub.dev/packages/flutter_map_tile_caching) (v9.1.4)
* **Geodata**: [latlong2](https://pub.dev/packages/latlong2)

## 🏗️ Architecture

The project follows a clean separation of concerns:
* **Logic Layer (`map_provider.dart`)**: Handles business logic, search filtering, and the complex Stream-based download process.
* **UI Layer (`main.dart`)**: Reactive components that rebuild based on state changes.
* **Storage**: Utilizes FMTC's ObjectBox backend for efficient tile storage.

## 🚀 Challenges & Solutions (Middle-level insights)

During development, the project faced API breaking changes in `flutter_map_tile_caching` (v9.1.x). 
**Problem**: Traditional getters like `totalTiles` or `downloaded` were deprecated.
**Solution**: Implemented a flexible progress tracking using `percentageValue` and explicit type casting to ensure compatibility with the latest package versions.

## 📸 Screenshots

| Map View | Offline Download | Search Feature |
| :---: | :---: | :---: |
| ![Map](https://via.placeholder.com/200x400?text=Map+View) | ![Download](https://via.placeholder.com/200x400?text=Progress+Bar) | ![Search](https://via.placeholder.com/200x400?text=Search+Results) |

## ⚙️ How to Run

1. Clone the repository:
   ```bash
   git clone [https://github.com/yourusername/almaty_offline_map.git](https://github.com/yourusername/almaty_offline_map.git)