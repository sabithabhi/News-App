import 'package:flutter/material.dart';
import 'package:mynews/data/db_service.dart';
import 'package:mynews/views/bookmark.dart';
import 'package:mynews/views/btm_nav.dart';
import 'package:mynews/views/category.dart';
import 'package:mynews/views/favorite.dart';
import 'package:mynews/views/home.dart';
import 'package:mynews/views/news.dart';
import 'package:mynews/views/search.dart';
import 'package:sqflite/sqflite.dart';

void main() async {
  // DbService dbService = DbService();
  // await dbService.db;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'News App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: BtmNav(),
    );
  }
}
