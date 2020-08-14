

import 'package:cloud_firestore/cloud_firestore.dart';

class UserProfile{
  String name;
  String email;
  int number;
  DateTime dob;
  String gender;
  int height;
  String weight;
  String bloodGroup;
  String allergy;
  String status;

  
UserProfile(this.name,this.email,this.number,this.dob,this.gender,this.allergy,this.bloodGroup,this.height,this.status,this.weight);

  Map<String, dynamic> toJson()=>{
   'name':name,
   'email':email,
   'number':number,
   'dob':dob,
   'gender':gender,
   'weight':weight,
   'height':height,
   'status':status,
   'bloodGroup':bloodGroup,
   'allergy':allergy

  };
  UserProfile .fromSnapshot(DocumentSnapshot snapshot):
  name=snapshot['name'],
  email=snapshot['email'],
   number=snapshot['number'],
   dob=snapshot['dob'].toDate(),
   gender=snapshot['gender'],
    weight=snapshot['weight'],
    height=snapshot['height'],
    status=snapshot['status'],
    bloodGroup=snapshot['bloodGroup'],
    allergy=snapshot['allergy']
 ;
   
} 
class Categories
{
  final String name;
  final String image;

  Categories(
  {this.name,this.image}
  );

}
List<Categories> dummy=[
  Categories(
    name:"Dentist",
    image: 'assets/dentist.jpg',



  ),
  Categories(
      name:"Cardiologist",
      image: 'assets/card.jpg'



  ),
  Categories(
      name:"Dermotologist",
      image: 'assets/skin.jpg'



  ),
  



  





];
  



