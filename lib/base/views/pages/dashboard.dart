import 'package:flutter/material.dart';

import '../../data/controllers/app.controller.dart';
import '../../data/helper/constants.dart';
import 'tabs/chats.dart';
import 'tabs/home.dart';
import 'tabs/profile.dart';
import 'tabs/shipments.dart';
import 'tabs/trips.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key, this.active});
  final int? active;

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _currentIndex = 0;
  @override
  void initState() {
    super.initState();
    setState(() => _currentIndex = widget.active ?? 0);
  }

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
        body: _buildBody(),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          type: BottomNavigationBarType.fixed,
          onTap: _changePage,
          backgroundColor: Colors.white,
          elevation: 5,
          selectedItemColor: greenColor,
          unselectedItemColor: navItems,
          selectedLabelStyle: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14 / MediaQuery.of(context).textScaleFactor),
          unselectedLabelStyle: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14 / MediaQuery.of(context).textScaleFactor),
          items: [
            BottomNavigationBarItem(
              activeIcon: Image.asset("assets/icons/home.png",
                  height: 27, color: greenColor),
              icon: Image.asset("assets/icons/home.png",
                  height: 27, color: navItems),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              activeIcon: Image.asset("assets/icons/trips.png",
                  height: 27, color: greenColor),
              icon: Image.asset("assets/icons/trips.png",
                  height: 27, color: navItems),
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
