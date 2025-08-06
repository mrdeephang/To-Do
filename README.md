# To-Do 📝

A beautiful and productive Flutter to-do list app with task scheduling.

---

## Features

- Add tasks with titles and descriptions
- Set due dates for tasks
- Delete task in one blow
- Clean Material Design UI
- Light/dark theme support
- Local data storage using SQLite

## Requirements

- Flutter SDK (v3.0+)
- Android Studio or VS Code
- Emulator or physical device

## Folder Structure

└─ lib/
├── database/
| ├── todo_database.dart # Main database class
│ └── migrations/ # Database migrations
│ ├── migration_1.dart # Initial schema
│ └── migration_2.dart
├── EasyConst/
| ├── color.dart
| ├── string.dart
| ├── styles.dart
├── models/
| ├── task.dart
├── providers/
| ├── theme_provider.dart
| ├── todo_provider.dart
├── screens/
| ├── addtask.dart
| ├── homescreen.dart
└── widgets/
| ├── empty.dart
| ├── task_card.dart
├── main.dart

## How to Run

1. Clone the repository
2. Run `flutter pub get`
3. Run `flutter run`

## Future Enhancement

- Improve UI
- Add Task Categories
- Implement Cloud Sync
- Add Reminder
- Add Exact Time

## Author

Copyright © 2025 Deephang Thegim. All rights reserved.
