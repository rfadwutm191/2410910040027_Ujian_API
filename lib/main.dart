import 'package:flutter/material.dart';
import 'package:rifadwiutami_2410910040027_ujian_api/pages/register.dart';
import 'package:rifadwiutami_2410910040027_ujian_api/pages/todolist.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        "/": (context) => RegisterPage(),
        "/todolist": (context) => TodoListPage(),
      },
      initialRoute: "/",
    ); // MaterialApp
  }
}