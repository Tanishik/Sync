import 'package:flutter/material.dart';
import 'package:sync/pages/home_page.dart';
import 'package:sync/pages/profile_page.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({super.key});

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

  int _selectedIndex = 0;

 final List _screens = [
  HomePage(),
  ProfilePage()
 ];

class _NavigationPageState extends State<NavigationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,

      body: _screens[_selectedIndex],


      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
        child: Container(
          margin: EdgeInsets.only(),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
            color: Theme.of(context).colorScheme.secondary
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: GNav(
              gap: 8,
              tabBackgroundColor: Theme.of(context).colorScheme.tertiary,
              padding: EdgeInsets.symmetric(horizontal: 55,vertical: 12),
              tabs: [
            
                GButton(icon: Icons.home,
                text: "Home",),

                GButton(icon: Icons.person,
                text: "Profile",)
            
              ],
            
              selectedIndex: _selectedIndex,
              onTabChange: (value) {
                setState(() {
                  _selectedIndex = value;
                });
              },
              ),
          ),
        ),
      ),
    );
  }
}