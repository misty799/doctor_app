import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_app/models/formmodel.dart';
import 'package:doctor_app/services/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:numberpicker/numberpicker.dart';


class FormPage extends StatefulWidget {
  FormPage({this.userProfile});
  final UserProfile userProfile;
  @override
  State<StatefulWidget> createState() {
    return FormPageState();
  }
}

class FormPageState extends State<FormPage> {
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _numberController = new TextEditingController();
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _dobController = new TextEditingController();
  TextEditingController _allergyController = new TextEditingController();
  TextEditingController _heightController = new TextEditingController();
  DateTime date=DateTime.now();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String _number, _email, _allergy, _name;

  int _currentPrice = 100;
  final _padding = 5.0;

  var _gender = ['Female', 'Male', 'Others'];
  var _currentGenderSelected;

  var _marry = ['Married', 'Unmarried'];
  var _currentStatusSelected;

  var _bloodGroup = ['A', 'B', 'O', 'AB'];
  var _currentGroupSelected;
  var _weight = ['30', '40'];
  var _currentWeightSelected;
  var height = [5, 6, 7];

  bool validateAndSave() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }

  Future<void> validateAndSubmit() async {
    if (validateAndSave()) {
      try {
        widget.userProfile.name = _nameController.text;
        widget.userProfile.email = _emailController.text;
        widget.userProfile.number = int.parse(_numberController.text);
        widget.userProfile.gender = _currentGenderSelected;
        widget.userProfile.weight = _currentWeightSelected;
        widget.userProfile.status = _currentStatusSelected;
        widget.userProfile.dob = date;
       widget.userProfile.height = _currentPrice;
        widget.userProfile.allergy = _allergyController.text;
        widget.userProfile.bloodGroup = _currentGroupSelected;

        final uid = await Provider.of(context).getUserId();
        await Firestore.instance
            .collection('userData')
            .document(uid)
            .collection('profile')
            .add(widget.userProfile.toJson());
        Navigator.of(context).pushReplacementNamed('/homepage');
      } catch (e) {
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var _widht = MediaQuery.of(context).size.width;
    var _height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Form(
        key: formKey,
        child: ListView(
          padding: EdgeInsets.only(left: 10.0),
          scrollDirection: Axis.vertical,
          children: <Widget>[
            Container(
              width: _widht * 0.8,
              height: _height * 0.07,
              padding: EdgeInsets.only(top: _padding * 2),
              child: Text(
                'Please fillups the details to use this App',
                textAlign: TextAlign.center,
                style:
                    TextStyle(fontSize: 16.0, backgroundColor: Colors.yellow),
              ),
            ),
            buildInputs('FullName', _name, _nameController),
            buildInputs('Phone Number', _number, _numberController),
            buildInputs('Email', _email, _emailController),
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * 0.09,
              child: TextFormField(
                controller: _dobController,
                decoration: InputDecoration(
                  labelText: "Date of birth",
                  border: InputBorder.none
                ),
                        
        validator: (value) => value.isEmpty ? 'the field is required' : null,
                onTap: () async {
              date=await showDatePicker(
              context: context, 
              initialDate:DateTime.now(),
              firstDate:DateTime(1900),
              lastDate: DateTime(2100));

              _dobController.text = DateFormat.yMMMd().format(date).toString();},)
                
              
            ),


            Container(
              width: _widht * 0.8,
              height: _height * 0.09,
              child: Row(children: <Widget>[
                Flexible(
                  child: DropdownButtonFormField<String>(
                    iconSize: 0.0,
                    decoration: InputDecoration.collapsed(hintText: ''),
                    hint: Text('Gender'),
                    items: _gender.map((value) {
                      return DropdownMenuItem<String>(
                          child: Text(value), value: value);
                    }).toList(),
                    value: _currentGenderSelected,
                    onChanged: (newValue) {
                      setState(() {
                        _currentGenderSelected = newValue;
                      });
                    },
                  ),
                ),
                Flexible(
                    child: DropdownButtonFormField<String>(
                        validator: (value) =>
                            value.isEmpty ? 'the field is required' : null,
                        iconSize: 0.0,
                        decoration: InputDecoration.collapsed(hintText: ''),
                        hint: Text('MaritalStatus'),
                        items: _marry.map((value) {
                          return DropdownMenuItem<String>(
                              child: Text(value), value: value);
                        }).toList(),
                        value: _currentStatusSelected,
                        onChanged: (newValue) {
                          setState(() {
                            _currentStatusSelected = newValue;
                          });
                        }))
              ]),
            ),
            Container(
              width: _widht * 0.8,
              height: _height * 0.09,
              child: Row(
                children: <Widget>[
                  Flexible(
                      child: TextFormField(
                          controller: _heightController,
                          decoration: InputDecoration(
                            hintText: 'Height',
                            border: InputBorder.none,
                          ),
                          onChanged: (value) {
                            setState(() {
                              _currentPrice = int.parse(value);
                            });
                          },
                          onTap: () {
                            _showDialog(context);
                          })),
                  Flexible(
                    child: DropdownButtonFormField<String>(
                        iconSize: 0.0,
                        validator: (value) =>
                            value.isEmpty ? 'the field is required' : null,
                        decoration: InputDecoration.collapsed(hintText: ''),
                        hint: Text('Weight'),
                        items: _weight.map((value) {
                          return DropdownMenuItem<String>(
                              child: Text(value), value: value);
                        }).toList(),
                        value: _currentWeightSelected,
                        onChanged: (newValue) {
                          setState(() {
                            _currentWeightSelected = newValue;
                          });
                        }),
                  )
                ],
              ),
            ),
            Container(
              width: _widht * 0.8,
              height: _height * 0.09,
              child: Row(
                children: <Widget>[
                  Flexible(
                    child: DropdownButtonFormField<String>(
                        validator: (value) =>
                            value.isEmpty ? 'the field is required' : null,
                        decoration: InputDecoration.collapsed(hintText: ''),
                        iconSize: 0.0,
                        hint: Text('Blood Group'),
                        items: _bloodGroup.map((value) {
                          return DropdownMenuItem<String>(
                              child: Text(value), value: value);
                        }).toList(),
                        value: _currentGroupSelected,
                        onChanged: (newValue) {
                          setState(() {
                            _currentGroupSelected = newValue;
                          });
                        }),
                  )
                ],
              ),
            ),
            buildInputs('Add Allergies with comma Separator', _allergy,
                _allergyController),
            Container(
              width: _widht * 0.4,
              height: _height * 0.08,
              child: Padding(
                  padding: EdgeInsets.only(left: 70.0, right: 70.0),
                  child: RaisedButton(
                    color: Colors.green,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        side: BorderSide(color: Colors.white)),
                    onPressed: validateAndSubmit,
                    child: Text(
                      'Submit',
                      style: TextStyle(
                          fontSize: 20.0,
                          fontFamily: 'Roboco',
                          color: Colors.white),
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildInputs(text, input, controller) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      height: MediaQuery.of(context).size.height * 0.09,
      child: TextFormField(
        controller: controller,
        keyboardType: TextInputType.text,
        autofocus: true,
        decoration: InputDecoration(
          hintText: text,
          border: InputBorder.none,
        ),
        validator: (value) => value.isEmpty ? 'the field is required' : null,
        onChanged: (value) {
          input = value;
        },
      ),
    );
  }

  void _showDialog(context) {
    showDialog<int>(
        context: context,
        builder: (BuildContext context) {
          return new NumberPickerDialog.integer(
            minValue: 90,
            maxValue: 200,
            title: new Text(
              "Height in cm",
              textAlign: TextAlign.center,
            ),
            initialIntegerValue: _currentPrice,
          );
        });
  }
}
