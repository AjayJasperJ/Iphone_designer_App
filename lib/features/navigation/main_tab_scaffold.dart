import 'package:dragable_app/app.dart';
import 'package:flutter/cupertino.dart';
import 'explore_screen.dart';
import 'my_hub_screen.dart';
import 'create_iphone_screen.dart';
import 'inspiration_screen.dart';
import 'settings_screen.dart';

class MainTabScaffold extends StatefulWidget {
  const MainTabScaffold({super.key});

  @override
  State<MainTabScaffold> createState() => _MainTabScaffoldState();
}

class _MainTabScaffoldState extends State<MainTabScaffold> {
  int _currentIndex = 0;
  final List<Widget> _screens = [
    ExploreScreen(),
    MyHubScreen(),
    CreateIphoneScreen(),
    InspirationScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.search), label: 'Explore'),
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.cube_box), label: 'My Hub'),
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.add_circled), label: 'Create'),
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.lightbulb), label: 'Inspiration'),
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.settings), label: 'Settings'),
        ],
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        // Add custom height
        height: displaysize.height * .08, // Increase this value for a taller nav bar
      ),
      tabBuilder: (context, index) {
        return CupertinoTabView(builder: (context) => SafeArea(child: _screens[index]));
      },
    );
  }
}
