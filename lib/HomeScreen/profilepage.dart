import 'package:doctor_app/HomeScreen/form.dart';
import 'package:doctor_app/models/formmodel.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Profile'),
          ),
          body: FormPage(
            userProfile: UserProfile(
                null, null, null, null, null, null, null, null, null, null),
          ),
        ));
  }
}
