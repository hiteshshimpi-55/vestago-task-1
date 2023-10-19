import 'package:flutter/material.dart';
import 'package:vestago_task/dashboard/views/screens/dashboard_screen.dart';
import 'package:vestago_task/track/views/track_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TrackingScreen(),
      bottomNavigationBar: BottomNavigationBar(
        items: const  [
          BottomNavigationBarItem(
              icon: Icon(Icons.dashboard),
              label: 'Dashboard'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.track_changes),
              label: 'Track'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              label: 'Account'
          ),
        ],
        selectedItemColor: Colors.black,
        currentIndex: _index,
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white,
        showSelectedLabels: true,
        onTap: (int index){
          setState(() {
            _index = index;
          });
        },
      ),
    );
  }
}
