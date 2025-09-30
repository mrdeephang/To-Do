import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/providers/theme_provider.dart';
import 'package:to_do/providers/todo_provider.dart';
import 'package:to_do/screen/homescreen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => TodoProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: Provider.of<ThemeProvider>(context).isDarkMode
          ? ThemeMode.dark
          : ThemeMode.light,
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
    );
  }
}
