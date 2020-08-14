import 'package:doctor_app/Home.dart';
import 'package:doctor_app/HomeScreen/Profilepage2.dart';
import 'package:doctor_app/HomeScreen/form.dart';
import 'package:doctor_app/HomeScreen/profilepage.dart';
import 'package:doctor_app/HomeScreen/searchList.dart';
import 'package:doctor_app/models/searchmodel.dart';
import 'package:doctor_app/services/provider.dart';
import 'package:doctor_app/services/authservice.dart';
import 'package:doctor_app/signUp/Phone.dart';
import 'package:doctor_app/signUp/SignIn.dart';
import 'package:doctor_app/signUp/signUp.dart';
import 'package:doctor_app/HomeScreen/HomeView.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'models/formmodel.dart';
void main()
{
  runApp(MyApp(
  ));
}
class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Provider(
      auth:Auth(),

  child:  MaterialApp(
      title: 'Notekeeper Application',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
      primarySwatch:Colors.deepPurple,
      backgroundColor: Colors.amber

    ),
    home:HomeController(),
    routes: <String,WidgetBuilder>
      {
       '/formpage': (BuildContext context) =>FormPage(userProfile: UserProfile(null,null,null,null,null,null,null,null,null,null)),
       '/signuppage': (BuildContext context) =>SignUpPage(),
       '/signIn': (BuildContext context) =>SignInView(),
       '/phone': (BuildContext context) =>Phone(),
       '/homeview': (BuildContext context) =>HomeView(),
        '/homepage': (BuildContext context) =>HomePage(),
         '/profilepage': (BuildContext context) =>ProfilePage(),
          '/profilepage2': (BuildContext context) =>ProfilePage2(),
          '/searchlist': (BuildContext context) =>SearchList(search: Search(null,null,null),dsearch: Dsearch(null,null,null),),
               }
  
    ));  }

}
class HomeController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final  auth=Provider.of(context);

    return StreamBuilder(
      stream: auth.onAuthStateChanged,
      builder:( context , snapshot){
        if(snapshot.connectionState==ConnectionState.active){
          final bool signedIn=snapshot.hasData;
          return signedIn?HomePage():SignInView();
        }
        return CircularProgressIndicator();


      }
    );
  }
}
