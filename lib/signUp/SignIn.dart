import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:doctor_app/services/provider.dart';

final primaryColor = const Color(0xFF75A2EA);

class SignInView extends StatefulWidget {
  SignInView({Key key}) : super(key: key);

  @override
  _SignInViewState createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  final formKey = GlobalKey<FormState>();
  String _email, _password;
  String _error;

  void submit() async {
    final form = formKey.currentState;
    form.save();
    try {
      final auth = Provider.of(context);

      String uid = await auth.signInWithEmailAndPassword(_email, _password);
      print("Signed up with New ID $uid");
      Navigator.of(context).pushReplacementNamed('/profilepage');
    } catch (e) {
      setState(() {
        _error = e.message;
      });
      print(e);
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      final auth = Provider.of(context);
      var user = await auth.signInWithGoogle();
      print(user);
      Navigator.of(context).pushReplacementNamed('/profilepage');
    } catch (e) {
      setState(() {
        _error = e.message;
      });
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        color: Colors.deepPurple,
        height: _height,
        width: _width,
        child: SafeArea(
          child: ListView(
            children: <Widget>[
              showAlert(),
              SizedBox(height: _height * 0.05),
              buildHeaderText(),
              SizedBox(height: _height * 0.05),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: buildInputs() + buildButtons(),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  AutoSizeText buildHeaderText() {
    String _headerText;

    _headerText = "Sign In";

    return AutoSizeText(
      _headerText,
      maxLines: 1,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 35,
        color: Colors.white,
      ),
    );
  }

  List<Widget> buildInputs() {
    List<Widget> textFields = [];

    textFields.add(
      TextFormField(
        style: TextStyle(fontSize: 22.0),
        decoration: buildSignUpInputDecoration("Email"),
        onSaved: (value) => _email = value,
      ),
    );
    textFields.add(SizedBox(height: 20));
    textFields.add(
      TextFormField(
        style: TextStyle(fontSize: 22.0),
        decoration: buildSignUpInputDecoration("Password"),
        obscureText: true,
        onSaved: (value) => _password = value,
      ),
    );
    textFields.add(SizedBox(height: 20));

    return textFields;
  }

  InputDecoration buildSignUpInputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: Colors.white,
      focusColor: Colors.white,
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white, width: 0.0)),
      contentPadding:
          const EdgeInsets.only(left: 14.0, bottom: 10.0, top: 10.0),
    );
  }

  List<Widget> buildButtons() {
    return [
      Container(
        width: MediaQuery.of(context).size.width * 0.7,
        child: RaisedButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
          color: Colors.white,
          textColor: primaryColor,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'LOGIN',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w300),
            ),
          ),
          onPressed: submit,
        ),
      ),
      FlatButton(
        child: Text(
          'Dont Have an account? SignUp',
          style: TextStyle(color: Colors.white),
        ),
        onPressed: () {
          Navigator.of(context).pushReplacementNamed('/signuppage');
        },
      ),
      RaisedButton(
        color: Colors.white,
        textColor: Colors.blueGrey,
        child: Row(
          children: <Widget>[
            Padding(
              padding:
                  const EdgeInsets.only(left: 40.0, top: 10.0, bottom: 10.0),
              child: Image.asset(
                "assets/google.jpg",
                fit: BoxFit.cover,
                height: 20.0,
                width: 20.0,
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 14.0, top: 10.0, bottom: 10.0),
              child:
                  Text("Sign in with Google", style: TextStyle(fontSize: 18)),
            )
          ],
        ),
        onPressed: () {
          signInWithGoogle();
        },
      ),
      SizedBox(height: 15.0),
      RaisedButton(
        color: Colors.white,
        textColor: Colors.blueGrey,
        child: Row(
          children: <Widget>[
            Padding(
              padding:
                  const EdgeInsets.only(left: 40.0, top: 10.0, bottom: 10.0),
              child: Icon(
                Icons.phone,
                color: Colors.green[700],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 14.0, top: 10.0, bottom: 10.0),
              child: Text("Sign in with Phone", style: TextStyle(fontSize: 18)),
            )
          ],
        ),
        onPressed: () {
          Navigator.of(context).pushReplacementNamed('/phone');
        },
      ),
    ];
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
