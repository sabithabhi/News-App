import 'package:flutter/material.dart';
import 'package:mynews/views/bookmark.dart';
import 'package:mynews/views/category.dart';
import 'package:mynews/views/favorite.dart';
import 'package:mynews/views/home.dart';
import 'package:mynews/views/search.dart';

class BtmNav extends StatefulWidget {
  @override
  _BtmNavState createState() => _BtmNavState();
}

class _BtmNavState extends State<BtmNav> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final tabs = [
      const Home(),
      Search(),
      Category(),
      // const Favorites(),
      const Favorites(),
    ];
    return Scaffold(
      body: tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorite',
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
