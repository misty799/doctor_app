import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Phone extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return PhoneState();
  }
}

class PhoneState extends State<Phone> {
  String phnNo;
  String sms;
  String veri;
  Future<void> verifyphn() async {
    final PhoneCodeAutoRetrievalTimeout autoRetrieve = (String id) {
      this.veri = id;
    };
    final PhoneCodeSent smsSent = (String id, [int forceCodeResend]) {
      this.veri = id;
    };
    final PhoneVerificationCompleted verifiedSuccess =
        (AuthCredential credential) {
      print('verified');
      smsDialog(context).then((value) {
        print('signed in');
      });
    };
    final PhoneVerificationFailed verifiedFailed = (AuthException exception) {
      print(exception.message);
    };
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: this.phnNo,
        codeAutoRetrievalTimeout: autoRetrieve,
        codeSent: smsSent,
        timeout: const Duration(seconds: 50),
        verificationCompleted: verifiedSuccess,
        verificationFailed: verifiedFailed);
  }

  Future<bool> smsDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new AlertDialog(
            title: Text('Enter sms code'),
            content: TextField(onChanged: (value) {
              this.sms = value;
            }),
            actions: <Widget>[
              FlatButton(
                  child: Text('done'),
                  onPressed: () {
                    FirebaseAuth.instance.currentUser().then((user) {
                      if (user != null) {
                        Navigator.of(context).pushReplacementNamed('/formpage');
                      } else {
                        signIn();
                      }
                    });
                  })
            ],
          );
        });
  }

  void signIn() {
    final AuthCredential credential =
        PhoneAuthProvider.getCredential(smsCode: sms, verificationId: veri);
    FirebaseAuth.instance.signInWithCredential(credential).then((user) {
      Navigator.of(context).pushReplacementNamed('/profilepage');
    }).catchError((e) {
      print(e);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Phone Authentication'),
      ),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: <Widget>[
              SizedBox(height: 30.0,),
              Container(
                padding:EdgeInsets.only(left:20.0,right:20.0),
                child:
              TextField(
                decoration: InputDecoration(
                  hintText: '+91 Enter your number',
                ),
                onChanged: (value) {
                  this.phnNo = value;
                },
              ),),
              SizedBox(
                height: 20.0,
              ),
              RaisedButton(
                onPressed: verifyphn,
                child: Text('verify',style: TextStyle(color: Colors.white,
                fontSize: 16.0),),
                color: Colors.deepPurple,
              )
            ],
          ),
        ),
      ),
    );
  }
}
