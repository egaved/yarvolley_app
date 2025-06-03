import 'package:flutter/material.dart';
import 'package:yarvolley_app/presentation/screens/home_page.dart';
import 'package:yarvolley_app/presentation/screens/leagues_page.dart';
import 'package:yarvolley_app/presentation/screens/teams_page.dart';
import 'package:yarvolley_app/presentation/theme/colors.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  MainScreenState createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [HomeScreen(), LeagueScreen(), TeamScreen()];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        sizing: StackFit.expand,
        children: _pages,
      ),
      bottomNavigationBar: Theme(
        data: ThemeData(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: BottomNavigationBar(
          backgroundColor: primaryColor,
          selectedItemColor: Colors.white,
          enableFeedback: false,
          unselectedItemColor: const Color.fromARGB(255, 141, 141, 141),
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Домой'),
            BottomNavigationBarItem(
              icon: Icon(Icons.sports_volleyball),
              label: 'Лиги',
            ),
            BottomNavigationBarItem(icon: Icon(Icons.group), label: 'Команды'),
          ],
          currentIndex: _selectedIndex,

          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
