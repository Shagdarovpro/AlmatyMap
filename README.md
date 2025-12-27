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
