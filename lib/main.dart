import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/providers/todo_provider.dart';
import 'package:to_do/screen/homescreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TodoProvider(),
      child: MaterialApp(
        title: 'Elegant To-Do',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          fontFamily: 'Poppins',
          appBarTheme: const AppBarTheme(elevation: 0, centerTitle: true),
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
