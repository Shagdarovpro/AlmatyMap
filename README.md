# Almaty Offline Map 🏔️

![Flutter CI](https://github.com/Shagdarovpro/AlmatyMap/actions/workflows/flutter_ci.yml/badge.svg)
[![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)](https://flutter.dev)

Высокопроизводительное Flutter-приложение для офлайн-навигации по Алматы. Проект демонстрирует работу с гео-данными, кэшированием карт и автоматизированным тестированием.

## ✨ Ключевые возможности (Features)

* **Offline First**: Продвинутая система кэширования тайлов (FMTC) для работы карты без интернета.
* **Smart Search**: Интерактивный поиск по достопримечательностям с фильтрацией через Provider.
* **Progress Tracking**: Реактивный индикатор загрузки регионов на базе Streams.
* **Reliability**: Код покрыт Unit и Widget тестами (проверка логики фильтрации и UI).

## 🛠️ Технический стек (Tech Stack)

* **State Management**: Provider
* **Mapping**: flutter_map (v7.0.2)
* **Offline Engine**: flutter_map_tile_caching (v9.1.4)
* **CI/CD**: GitHub Actions (авто-тесты при каждом пуше).

## 🏗️ Архитектура

Проект разделен на логические слои:
* **Logic (`map_provider.dart`)**: Бизнес-логика, управление состоянием и поиск.
* **UI (`main.dart`)**: Реактивные компоненты, реагирующие на изменения провайдера.
* **Tests (`test/`)**: Набор тестов для обеспечения стабильности приложения.

## 🚀 Как запустить

1. Клонируйте репозиторий:
   ```bash
   git clone [https://github.com/Shagdarovpro/AlmatyMap.git](https://github.com/Shagdarovpro/AlmatyMap.git)