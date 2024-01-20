import 'package:flutter/material.dart';

import '../../data/controllers/app.controller.dart';
import '../../data/helper/constants.dart';
import '../components/home/drawer.widget.dart';
import 'tabs/chats.dart';
import 'tabs/home.dart';
import 'tabs/profile.dart';
import 'tabs/shipments.dart';
import 'tabs/trips.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_currentIndex != 0) {
          setState(() {
            _currentIndex = 0;
          });
          return false;
        }
        return true;
      },
      child: Scaffold(
        drawer: const DrawerWidget(),
        body: _buildBody(),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          type: BottomNavigationBarType.fixed,
          onTap: _changePage,
          backgroundColor: Colors.white,
          elevation: 5,
          selectedItemColor: greenColor,
          unselectedItemColor: navItems,
          selectedLabelStyle:
              const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
          unselectedLabelStyle:
              const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
          items: [
            BottomNavigationBarItem(
              activeIcon: Image.asset("assets/icons/home.png",
                  height: 27, color: greenColor),
              icon: Image.asset("assets/icons/home.png",
                  height: 27, color: navItems),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              activeIcon: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Image.asset("assets/icons/trips.png",
                    height: 22, color: greenColor),
              ),
              icon: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Image.asset("assets/icons/trips.png",
                    height: 22, color: navItems),
              ),
              label: 'Trips',
            ),
            BottomNavigationBarItem(
              activeIcon: Image.asset("assets/icons/shipments.png",
                  height: 27, color: greenColor),
              icon: Image.asset("assets/icons/shipments.png",
                  height: 27, color: navItems),
              label: 'Shipments',
            ),
            BottomNavigationBarItem(
              activeIcon: Image.asset("assets/icons/chats.png",
                  height: 27, color: greenColor),
              icon: Image.asset("assets/icons/chats.png",
                  height: 27, color: navItems),
              label: 'Messages',
            ),
            BottomNavigationBarItem(
              activeIcon: Image.asset("assets/icons/profile.png",
                  height: 27, color: greenColor),
              icon: Image.asset("assets/icons/profile.png",
                  height: 27, color: navItems),
              label: 'Account',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBody() {
    switch (_currentIndex) {
      case 0:
        return const Homepage();
      case 1:
        return const TripsPage();
      case 2:
        return const ShipmentsPage();
      case 3:
        return const ChatsPage();
      case 4:
        return const ProfilePage();
      default:
        return Center(
          child: Text(
            'Welcome Home ${activeUser.value.username}\n${activeUser.value.email}',
            textScaleFactor: 1,
            textAlign: TextAlign.center,
          ),
        );
    }
  }

  void _changePage(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
