import 'package:auto_size_text/auto_size_text.dart';
import 'package:doctor_app/services/provider.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  String _name;
  String _email;
  String _password;
  final _padding = 5.0;
  var _error;

  Future<void> signUp() async {
    final auth = Provider.of(context);
    try {
      await auth.createUserWithEmailAndPassword(_name, _email, _password);
      Navigator.of(context).pushReplacementNamed('/profilepage');
    } catch (e) {
      setState(() {
        _error = e.message;
      });
      print(e);
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(''),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed('/signIn');
                })
          ],
        ),
        body: Container(
            margin: EdgeInsets.all(_padding * 5),
            child: ListView(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: _padding, bottom: _padding),
                  child: ListTile(
                    leading: new Image.asset(
                      "assets/doctor.jpg",
                      fit: BoxFit.cover,
                      height: 60.0,
                      width: 60.0,
                    ),
                    title: Text(
                      'eHealth',
                      style: TextStyle(
                        color: Colors.lightGreen,
                        fontSize: 30.0,
                        fontWeight: FontWeight.w800,
                        fontFamily: "Roboco",
                      ),
                    ),
                    subtitle: Text(
                      'patient App',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: _padding, bottom: _padding),
                  child: Text("REGISTER",
                      style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.w800,
                          fontFamily: "Roboco",
                          color: Colors.black)),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(top: _padding * 2, bottom: _padding * 2),
                  child: Text(
                      "Experience with Referral network to health care for your patient",
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w800,
                        fontFamily: "Roboco",
                        color: Colors.grey,
                        height: 1.5,
                      )),
                ),
                Padding(
                  padding: EdgeInsets.only(top: _padding * 2, bottom: _padding),
                  child: TextField(
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person),
                        hintText: 'User Name',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        )),
                    onChanged: (value) {
                      _name = value;
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: _padding, bottom: _padding),
                  child: TextField(
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.email),
                        hintText: 'Email',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        )),
                    onChanged: (value) {
                      _email = value;
                    },
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(top: _padding, bottom: _padding),
                    child: TextField(
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.lock),
                          hintText: 'Password',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          )),
                      onChanged: (value) {
                        _password = value;
                      },
                    )),
                Padding(
                  padding: EdgeInsets.only(top: _padding, bottom: _padding),
                  child: ButtonTheme(
                    minWidth: 200.0,
                    height: 50.0,
                    child: RaisedButton(
                      child: Text(
                        'REGISTER',
                        textScaleFactor: 1.5,
                      ),
                      color: Colors.blue[600],
                      textColor: Colors.white,
                      onPressed: () {
                        signUp();
                      },
                    ),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(
                        top: _padding * 2,
                        bottom: _padding * 2,
                        left: _padding * 5,
                        right: _padding * 5),
                    child: Text(
                        "By Clicking on Register You agree to our terms & conditions",
                        style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w800,
                            fontFamily: "Roboco",
                            color: Colors.grey))),
              ],
            )));
  }

  Widget showAlert() {
    if (_error != null) {
      return Container(
          color: Colors.amberAccent,
          width: double.infinity,
          padding: EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(right: 8.0),
                child: Icon(Icons.error_outline),
              ),
              Expanded(
                child: AutoSizeText(_error, maxLines: 3),
              ),
              Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () {
                        setState(() {
                          _error = null;
                        });
                      }))
            ],
          ));
    }
    return SizedBox(
      height: 0.0,
    );
  }
}
