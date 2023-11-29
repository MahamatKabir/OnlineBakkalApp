import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:gracery/provider/dark_theme_provider.dart';
import 'package:gracery/screens/cart/cart_screen.dart';
import 'package:gracery/screens/categories.dart';
import 'package:gracery/screens/home_screen.dart';
import 'package:gracery/screens/user.dart';
import 'package:provider/provider.dart';

class BottomBarScreen extends StatefulWidget {
  const BottomBarScreen({super.key});

  @override
  State<BottomBarScreen> createState() => _BottomBarScreenState();
}

class _BottomBarScreenState extends State<BottomBarScreen> {
  int _selectedIndex = 0;
  final List _pages = [
    const HomeScreen(),
    CategoriesScreen(),
    const CartScreen(),
    const UserScreen(),
  ];

  void _selectedPage(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);
    bool _isDark = themeState.getDarkTheme;
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: _isDark ? Theme.of(context).cardColor : Colors.white,
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          currentIndex: _selectedIndex,
          unselectedItemColor: _isDark ? Colors.white10 : Colors.black12,
          selectedItemColor: _isDark ? Colors.blue.shade100 : Colors.black87,
          onTap: _selectedPage,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(
                    _selectedIndex == 0 ? IconlyBold.home : IconlyLight.home),
                label: "home"),
            BottomNavigationBarItem(
                icon: Icon(_selectedIndex == 1
                    ? IconlyBold.category
                    : IconlyLight.category),
                label: "categories"),
            BottomNavigationBarItem(
                icon: Icon(
                    _selectedIndex == 2 ? IconlyBold.buy : IconlyLight.buy),
                label: "cart"),
            BottomNavigationBarItem(
                icon: Icon(
                    _selectedIndex == 3 ? IconlyBold.user2 : IconlyLight.user2),
                label: "user")
          ]),
    );
  }
}
