<<<<<<< HEAD
# 🏔️ Almaty Offline Guide

[![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)](https://dart.dev)
[![Repo](https://img.shields.io/badge/Repository-Link-green?style=for-the-badge&logo=github)](https://github.com/Shagdarovpro/AlmatyMap.git)

Мобильное приложение для навигации по Алматы с полноценным **Offline-first** подходом. Позволяет пользователям искать достопримечательности и пользоваться картой без доступа к сети (в горах, в самолете или при отсутствии роуминга).

## 🚀 Ссылка на проект
**GitHub Repository:** [https://github.com/Shagdarovpro/AlmatyMap.git](https://github.com/Shagdarovpro/AlmatyMap.git)

---

## 🌟 Ключевые возможности

* **Offline Tile Caching:** Автоматическое и ручное сохранение фрагментов карты (тайлов) в локальную базу данных.
* **Bulk Download:** Возможность пакетного скачивания выбранного региона (весь город Алматы) для полной автономности.
* **Live Search:** Интерактивный поиск по списку достопримечательностей (Медеу, Шымбулак, Кок-Тобе и др.) с фильтрацией в реальном времени.
* **Download Progress:** Визуальный индикатор прогресса загрузки (Progress Bar) с использованием реактивных потоков (Streams).
* **Map Control:** Удобное управление камерой и перемещение к объектам при клике на карточки.

## 🛠 Технический стек

* **Maps:** `flutter_map` (OpenStreetMap).
* **Storage:** `flutter_map_tile_caching` (на базе ObjectBox NoSQL) — для высокопроизводительного хранения тайлов.
* **Data:** `latlong2` для работы с географическими координатами.
* **UI:** Material 3, Stack layout для наложения слоев поиска и прогресса.

## ⚙️ Архитектурные особенности

1.  **Reactive State Management:** Состояние загрузки и прогресс-бара обновляется через `setState` на основе прослушивания `Stream` от загрузчика.
2.  **Foreground Service:** Загрузка больших регионов оптимизирована для работы в фоне, чтобы процесс не прерывался системой.
3.  **Search Logic:** Реализована эффективная фильтрация коллекций объектов "на лету" без лишних перерисовок карты.

## 📦 Установка и запуск

1.  Клонируйте репозиторий:
    ```bash
    git clone [https://github.com/Shagdarovpro/AlmatyMap.git](https://github.com/Shagdarovpro/AlmatyMap.git)
    ```
2.  Перейдите в папку проекта:
    ```bash
    cd AlmatyMap
    ```
3.  Установите зависимости:
    ```bash
    flutter pub get
    ```
4.  Запустите на эмуляторе или реальном устройстве:
    ```bash
    flutter run
    ```

## 📍 Дальнейшие планы (Roadmap)
- [ ] Добавление маршрутов для трекинга в горах.
- [ ] Определение текущего местоположения через GPS.
- [ ] Темная тема для экономии заряда в походах.

---
Разработано Shagdarovpro как демонстрация работы с гео-данными и локальным хранением во Flutter.
=======
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
>>>>>>> 3915107 (feat: upgrade to FMTC 9.1.4, add landmark search, and implement widget tests)
