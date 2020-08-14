import 'package:doctor_app/HomeScreen/HomeView.dart';
import 'package:doctor_app/models/searchmodel.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_app/services/provider.dart';

class DoctorDetails extends StatefulWidget {
  DoctorDetails({this.search, this.dsearch});
  final Dsearch dsearch;
  final Search search;
  @override
  _DoctorDetailsState createState() => _DoctorDetailsState();
}

class _DoctorDetailsState extends State<DoctorDetails> {
  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));

    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
    displayDialog(context);
  }

  Future<void> displayDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Your appointment has been booked'),
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('cancel')),
              FlatButton(
                  onPressed: () async {
                    setState(() {
                      widget.dsearch.dname = widget.search.name;
                      widget.dsearch.dimage = widget.search.image;
                      widget.dsearch.dspeciality = widget.search.speciality;
                    });
                    final uid = await Provider.of(context).getUserId();
                    await Firestore.instance
                        .collection('userData')
                        .document(uid)
                        .collection('appointment')
                        .add(widget.dsearch.toJson());
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomeView()));
                  },
                  child: Text('done'))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.deepPurple, title: Text('About Doctor')),
        body: showDetails(context, widget.search));
  }

  Widget showDetails(BuildContext context, Search search) {
    return ListView(children: <Widget>[
      Container(
        padding: EdgeInsets.only(top: 10.0),
        height: 200.0,
        width: MediaQuery.of(context).size.width,
        child: Image.asset(
          search.image,
          height: 150,
        ),
      ),
      Container(
          child: Column(children: <Widget>[
        Text(
          search.name,
          style: TextStyle(fontSize: 32),
        ),
        Text(
          search.speciality,
          style: TextStyle(fontSize: 19, color: Colors.grey),
        )
      ])),
      Container(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 15.0),
              child: Text(
                "About",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(15.0),
              child: Text(
                "${search.name} ,  ${search.speciality} in Nashville & affiliated with multiple hospitals in the  area.He received his medical degree from Duke University School of Medicine and has been in practice for more than 20 years. ",
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
            ),
          ])),
      Container(
          padding: EdgeInsets.all(15.0),
          width: MediaQuery.of(context).size.width * 0.7,
          child: Card(
              color: Colors.deepPurple,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0)),
              child: InkWell(
                  onTap: () async {
                    _selectDate(context);
                  },
                  splashColor: Colors.green,
                  child: Center(
                      child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                        Spacer(),
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                          child: Icon(
                            Icons.add,
                            size: 50.0,
                            color: Colors.white,
                          ),
                        ),
                        Spacer(),
                        Column(children: <Widget>[
                          Text(
                            'Book an Appointment',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w800,
                                fontSize: 20.0,
                                fontFamily: 'Roboco'),
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          Text(
                            'Monday-Friday available till 7pm',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w800,
                                fontSize: 15.0,
                                fontFamily: 'Roboco'),
                          ),
                        ]),
                        Spacer()
                      ]))))),
      // Text(" Your appointment has been booked on${selectedDate.toString()}"),
    ]);
  }

  /*void showDateTime(BuildContext context){
     DatePicker.showDateTimePicker(context,
                      showTitleActions: true,
                      minTime: DateTime(2020, 5, 5, 20, 50),
                      maxTime: DateTime(2020, 6, 7, 05, 09), onChanged: (date) {
                    print('change $date in time zone ' + date.timeZoneOffset.inHours.toString());
                  }, onConfirm: (date) {
                   showDialog(context: context,
                   builder:(BuildContext context){
                     return AlertDialog(
                       title: Text('Your appointment has been booked'),
                       actions: <Widget>[
                           FlatButton(onPressed: (){
                         Navigator.of(context).pop();
                       }, child: Text('cancel')),
                     
                       FlatButton(onPressed: () async {
                         final uid=await Provider.of(context).getUserId();
            await  Firestore.instance.collection('userData').document(uid).collection('appointment').
            add(widget.dsearch.toJson());
                         Navigator.of(context).pushReplacementNamed('/homepage');
                       }, child: Text('done'))
                     ],);
                   });
                  }, locale: LocaleType.en);
                
  }*/
}
