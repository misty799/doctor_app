import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_app/HomeScreen/picture.dart';
import 'package:doctor_app/models/formmodel.dart';
import 'package:doctor_app/services/provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProfilePage2 extends StatefulWidget {
  @override
  _ProfilePage2State createState() => _ProfilePage2State();
}

class _ProfilePage2State extends State<ProfilePage2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Profile')),
        body: StreamBuilder(
            stream: getUserInfo(context),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return Text('Loading');
              return ListView.builder(
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (BuildContext context, int index) {
                    return buildCard(context, snapshot.data.documents[index]);
                  });
            }));
  }

  Stream<QuerySnapshot> getUserInfo(BuildContext context) async* {
    final uid = await Provider.of(context).getUserId();
    yield* Firestore.instance
        .collection('userData')
        .document(uid)
        .collection('profile')
        .snapshots();
  }

  Widget buildCard(BuildContext context, DocumentSnapshot document) {
    final userProfile = UserProfile.fromSnapshot(document);
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
        Widget>[
      Container(
          child: Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 10.0),
              child: Card(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 15.0),
                      child: Column(children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(left: 1.0),
                          child: Text(
                            userProfile.name,
                            style: TextStyle(
                                color: Colors.grey[700],
                                fontSize: 23,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Row(children: <Widget>[
                          SizedBox(width: 10.0),
                          Icon(
                            Icons.phone,
                            size: 16.0,
                            color: Colors.deepPurple,
                          ),
                          SizedBox(width: 10.0),
                          Text(
                            userProfile.number.toString(),
                            style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[700]),
                          ),
                        ]),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(width: 30.0),
                            Icon(
                              Icons.email,
                              color: Colors.deepPurple,
                              size: 16.0,
                            ),
                            SizedBox(width: 10.0),
                            Text(
                              userProfile.email,
                              style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[700]),
                            ),
                          ],
                        ),
                      ]),
                    ),
                    Spacer(),
                    UserPicture()
                  ],
                ),
              ))),
               Container(
          padding: EdgeInsets.all(25.0),
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text(
                'Date Of Birth',
                style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[700]),
              ),
              Spacer(),
              Text(
               DateFormat.yMMMd().format(userProfile.dob).toString(),
                style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[700]),
              )
            ],
          )),
      Container(
          padding: EdgeInsets.all(25.0),
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text(
                'Gender',
                style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[700]),
              ),
              Spacer(),
              Text(
                userProfile.gender,
                style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[700]),
              )
            ],
          )),
      Container(
          padding: EdgeInsets.all(25.0),
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text(
                'Marital Status',
                style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[700]),
              ),
              Spacer(),
              Text(
                userProfile.status,
                style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[700]),
              )
            ],
          )),
      Container(
          padding: EdgeInsets.all(25.0),
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text(
                'Height',
                style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[700]),
              ),
              Spacer(),
              Text(
                userProfile.height.toString(),
                style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[700]),
              )
            ],
          )),
      Container(
          padding: EdgeInsets.all(25.0),
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text(
                'Weight',
                style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[700]),
              ),
              Spacer(),
              Text(
                userProfile.weight,
                style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[700]),
              )
            ],
          )),
      Container(
          padding: EdgeInsets.all(25.0),
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text(
                'Blood Group',
                style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[700]),
              ),
              Spacer(),
              Text(
                userProfile.bloodGroup,
                style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[700]),
              )
            ],
          )),
      Container(
          padding: EdgeInsets.all(25.0),
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text(
                'Allergies',
                style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[700]),
              ),
              Spacer(),
              Text(
                userProfile.allergy,
                style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[700]),
              )
            ],
          ))
    ]);
  }
}
