import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_app/models/searchmodel.dart';
import 'package:doctor_app/services/provider.dart';
import 'package:flutter/material.dart';
class Appointment extends StatefulWidget {
  Appointment({this.dsearch});
  final Dsearch dsearch;
  @override
  _AppointmentState createState() => _AppointmentState();
}

class _AppointmentState extends State<Appointment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title:Text('My Appointments')),
    body: StreamBuilder(
      stream: getData(context),
      builder:(context,snapshot){ 
        if(!snapshot.hasData)
        return Text('Loading');
    return ListView.builder(
      itemCount:snapshot.data.documents.length,
      itemBuilder:(BuildContext context,int index){
        return buildCardDetails(context, snapshot.data.documents[index]);
       
      }
    );
      }
     ) );
  }
  Stream<QuerySnapshot> getData(BuildContext context)async*{
    final uid=await Provider.of(context).getUserId();
    yield* Firestore.instance.collection('userData').document(uid).collection('appointment').snapshots();

  

  
  }
   Widget buildCardDetails(BuildContext context , DocumentSnapshot document){
     
  final  dsearch=Dsearch.fromSnapshot(document);
     return  Container(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            
            child: SingleChildScrollView(child:
             Card(
              color: Colors.blue[100],
          
                child:
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: Column(
                          children: <Widget>[
                             Row(
          children: <Widget>[
            Image.asset(dsearch.dimage==null?'':dsearch.dimage, height: 80,),
            Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(dsearch.dname==null?'':dseacrh.dname, style: TextStyle(
                  color: Color(0xffFC9535),
                  fontSize: 23
                ),),
                SizedBox(height: 2,),
                Text(dseacrh.dspeciality==null?'':dsearch.dspeciality, style: TextStyle(
                  fontSize: 19,
                  color: Colors.grey[700]
                ),),
                 Container(
         child:
              
                   RaisedButton(child: Text('cancel appointment',style: TextStyle(fontSize: 15.0),),
                   color: Colors.orangeAccent,
                   textColor: Colors.white,
                  
           
              onPressed: () async {
                 var uid=await Provider.of(context).getUserId();
    final doc=Firestore.instance.collection('userData').document(uid).collection('appointment').
    document(trip.documentId);
    return await doc.delete();


              },
            ))
              ],
            ),
            Spacer()
            
        
           
          
                        ])]))),
              
            
            ))));
        
  }
}
        


                           


             
