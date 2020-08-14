import 'package:doctor_app/models/formmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoriesList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {

    return CategoriesListState();
  }
}

class CategoriesListState extends State<CategoriesList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: dummy.length,
          scrollDirection: Axis.horizontal,
          physics: BouncingScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            final category = dummy[index];
            return (GestureDetector(
                onTap: () {
                  Navigator.of(context).pushReplacementNamed('/searchpage');
                },
                child: Container(
                  width: 200.0,
                  margin: EdgeInsets.only(right: 15.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      image: DecorationImage(
                        image: AssetImage(
                          category.image,
                        ),
                        fit: BoxFit.cover,
                      )),
                  alignment: Alignment.bottomLeft,
                  padding: EdgeInsets.only(left: 10.0),
                  child: Text(
                    category.name,
                    style: GoogleFonts.roboto(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                      color: Colors.blueGrey,
                    ),
                  ),
                )));
          }),
    );
  }
}
