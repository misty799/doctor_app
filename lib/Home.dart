import 'package:doctor_app/HomeScreen/HomeView.dart';
import 'package:doctor_app/HomeScreen/Profilepage2.dart';
import 'package:doctor_app/HomeScreen/searchList.dart';
import 'package:doctor_app/models/searchmodel.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    HomeView(),
    SearchList(
      search: Search(null, null, null),
      dsearch: Dsearch(null, null, null),
    ),
    ProfilePage2()
  ];
  void onTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    //  final newTrip=new Trip(null,null,null,null,null,null);
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          onTap: onTapped,
          currentIndex: _currentIndex,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.home), title: Text('Home')),
            BottomNavigationBarItem(
                icon: Icon(Icons.explore), title: Text('Explore')),
            BottomNavigationBarItem(
                icon: Icon(Icons.account_circle), title: Text('Profile'))
          ]),
    );
  }
}
