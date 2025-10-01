# To-Do 📝

A beautiful and productive Flutter to-do list app with task scheduling.

---

## Screenshots

<img src="https://github.com/user-attachments/assets/1e5c8ee4-5ce9-4b9e-8fa9-fabce0ec11b9" alt="Image 1" width="300"/>
<img src="https://github.com/user-attachments/assets/de6bce43-de07-4ff3-9197-1fb35e2f9391" alt="Image 2" width="300"/>
<img src="https://github.com/user-attachments/assets/30b5682d-b1b7-4338-bc30-cbc1b1f22c3d" alt="Image 3" width="300"/>
<img src="https://github.com/user-attachments/assets/cfb6a661-58b0-4092-b84a-a1bc7b3d4113" alt="Image 4" width="300"/>


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
