import 'package:cloud_firestore/cloud_firestore.dart';

class Search{
  String name;
  String speciality;
 String image;
 Search(this.name,this.speciality,this.image);
   Map<String, dynamic> toJson()=>{
   'name':name,
   'image':image,
   'spec':speciality

  };
  Search.fromSnapshot(DocumentSnapshot snapshot):
  name=snapshot['name'],speciality=snapshot['speciality']
 ;
   
} 

class Dsearch{
  String dname;
  String dspeciality;
 String dimage;
 String documentId;
 Dsearch(this.dname,this.dspeciality,this.dimage);
   Map<String, dynamic> toJson()=>{
   'name':dname,
   'image':dimage,
   'speciality':dspeciality

  };
  Dsearch.fromSnapshot(DocumentSnapshot snapshot):
  dname=snapshot['name'],dspeciality=snapshot['speciality'],
  dimage=snapshot['image'],
  documentId=snapshot.documentID;
 

   
} 

