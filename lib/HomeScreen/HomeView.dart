import 'package:doctor_app/HomeScreen/appoint.dart';
import 'package:doctor_app/HomeScreen/picture.dart';
import 'package:doctor_app/models/searchmodel.dart';
import 'package:doctor_app/services/provider.dart';
import 'package:flutter/material.dart';
import 'package:doctor_app/HomeScreen/categories.dart';
import 'package:doctor_app/HomeScreen/doctorlist.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  void logOut() {
    try {
      Provider.of(context).signOut();
      Navigator.of(context).pushReplacementNamed('/signIn');
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
                backgroundColor: Colors.deepPurple,
                title: Text(
                  'Home',
                  textAlign: TextAlign.center,
                )),
            drawer: Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(left: 10.0, top: 10.0),
                    color: Colors.deepPurple,
                    height: 110.0,
                    child: UserPicture(),
                  ),
                  SizedBox(
                    height: 80.0,
                    width: MediaQuery.of(context).size.width,
                    child: UserAccountsDrawerHeader(
                      accountName: userNameInfo(),
                      accountEmail: userEmailInfo(),
                    ),
                  ),
                  ListTile(
                    leading: Icon(
                      FontAwesomeIcons.home,
                      color: Colors.deepPurple,
                    ),
                    title: Text("Home"),
                    onTap: () {
                      Navigator.of(context).pushReplacementNamed('/homepage');
                    },
                  ),
                  ListTile(
                    leading: Icon(
                      FontAwesomeIcons.search,
                      color: Colors.deepPurple,
                    ),
                    title: Text("Find Doctors"),
                    onTap: () {
                      Navigator.of(context).pushReplacementNamed('/searchlist');
                    },
                  ),
                  ListTile(
                    leading: Icon(
                      FontAwesomeIcons.bookMedical,
                      color: Colors.deepPurple,
                    ),
                    title: Text("Your Appointments"),
                    onTap: () async {
                      await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Appointment(
                                    dsearch: Dsearch(null, null, null),
                                  )));
                    },
                  ),
                  ListTile(
                      leading: Icon(
                        Icons.settings,
                        color: Colors.deepPurple,
                      ),
                      title: Text("Logout"),
                      onTap: logOut),
                ],
              ),
            ),
            body: Container(
                child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SizedBox(height: 14.0),
                  Container(
                      padding: EdgeInsets.only(left: 10.0),
                      color: Colors.white,
                      width: MediaQuery.of(context).size.width,
                      height: 60.0,
                      child: userInfo()),
                  Padding(
                      padding: const EdgeInsets.only(
                          left: 15.0, right: 15.0, top: 10.0),
                      child: TextField(
                        onTap: () {
                          Navigator.of(context)
                              .pushReplacementNamed('/searchlist');
                        },
                        decoration: InputDecoration(
                          hintText: 'Search Doctors',
                          prefixIcon: Icon(Icons.search),
                        ),
                      )),
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 15.0, right: 15.0),
                    child: Row(
                      children: <Widget>[
                        Text(
                          "Specialists",
                          style: TextStyle(
                              color: Colors.deepPurple,
                              fontSize: 25,
                              fontWeight: FontWeight.w600),
                        ),
                        Spacer(),
                        Text(
                          "view all",
                          style: TextStyle(
                            color: Colors.grey[800],
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 10.0),
                    width: double.infinity,
                    height: 150.0,
                    child: CategoriesList(),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 15.0, right: 15.0),
                    child: Row(
                      children: <Widget>[
                        Text(
                          "Doctors",
                          style: TextStyle(
                              color: Colors.deepPurple,
                              fontSize: 25,
                              fontWeight: FontWeight.w600),
                        ),
                        Spacer(),
                        Text(
                          "view more",
                          style: TextStyle(
                            color: Colors.grey[800],
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Padding(
                      padding: EdgeInsets.only(left: 5.0, right: 5.0),
                      child: DoctorsTile()),
                ],
              ),
            ))));
  }

  Widget userNameInfo() {
    return FutureBuilder(
        future: Provider.of(context).getCurrentUser(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Text(
              snapshot.data.displayName,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w600),
            );
          } else {
            return CircularProgressIndicator();
          }
        });
  }

  Widget userEmailInfo() {
    return FutureBuilder(
        future: Provider.of(context).getCurrentUser(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Text(
              snapshot.data.email,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w600),
            );
          } else {
            return CircularProgressIndicator();
          }
        });
  }

  Widget userInfo() {
    return FutureBuilder(
        future: Provider.of(context).getCurrentUser(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Text(
              " Hello ! ${snapshot.data.displayName}\n What are you looking for?",
              style: TextStyle(
                  color: Colors.grey[800],
                  fontSize: 25,
                  fontWeight: FontWeight.w600),
            );
          } else {
            return CircularProgressIndicator();
          }
        });
  }
}
