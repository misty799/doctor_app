
import 'package:doctor_app/HomeScreen/doctordetails.dart';
import 'package:flutter/material.dart';
import 'package:doctor_app/models/searchmodel.dart';

class SearchList extends StatefulWidget {
  SearchList({this.search,this.dsearch});
  final Search search;
  final Dsearch dsearch;

  @override
  _SearchListState createState() => _SearchListState();
}

class _SearchListState extends State<SearchList> {

  final TextEditingController _controller = new TextEditingController();
  List<Search> _list=[ Search("Dr Stefan Albert",'Heart Specialist','assets/dentist.jpg'),
      Search("Dr Stefani Albert",'Dentist','assets/card.jpg'),
        Search("Dr Steefan Albert",'Dermotologist','assets/skin.jpg'),
          Search("Dr Stefan Albeet",'Cardiologist','assets/dentist.jpg'),
            Search("Dr Stefan Albet",'Hair Specialist','assets/dentist.jpg')
  ];
      
  bool _isSearching;
  List searchresult = new List();

 

  @override
  void initState() {
    super.initState();
    _isSearching = false;
  
  }
   void _handleSearchStart() {
    setState(() {
      _isSearching = true;
    });
  }

  

  void searchOperation(String searchText) {
    searchresult.clear();
    if (_isSearching != null) {
      for (int i = 0; i < _list.length; i++) {
        String data = _list[i].name;
        if (data.toLowerCase().contains(searchText.toLowerCase())) {
          searchresult.add(data);
        }
      }
    }
  }

  

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title:Text('Search Doctors')
        ),
        body: new Container(
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                height: 80.0,
               padding: EdgeInsets.all(10.0),
            child: TextField(
         controller: _controller,
         onChanged: (value)
           {
            if(value.isNotEmpty){
              searchOperation(value);
             _handleSearchStart();}},
         decoration: InputDecoration(
           prefix: IconButton(icon: Icon(Icons.search), onPressed: null),
           
           hintText: 'Search by name',
           border: OutlineInputBorder(
             borderRadius:BorderRadius.circular(15.0)
           )
         ),
       ),),
              new Flexible(
                  child: searchresult.length != 0 || _controller.text.isNotEmpty
                      ? new ListView.builder(
                          shrinkWrap: true,
                          itemCount: searchresult.length,
                          itemBuilder: (BuildContext context, int index) {
                            return buildCard(context, index);
                     
                          },
                        )
                      : new ListView.builder(
                          shrinkWrap: true,
                          itemCount: _list.length,
                          itemBuilder: (BuildContext context, int index) {
                        
                            return buildCard(context, index);
                          
                          },
                        ))
            ],
          ),
        ));
  }

 
 

Widget buildCard(BuildContext context,int index)
{return
 Hero(
                      tag:_list[index].name.toString(),
                    transitionOnUserGestures: true,
                    child: Container(
                        child: Padding(
            padding: const EdgeInsets.only(
              left: 8.0,
              right: 8.0,
            ),
            child: Card(
              color: Colors.blue[100],
              child: InkWell(
                child:
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: <Widget>[
                             Row(
          children: <Widget>[
            Image.asset(_list[index].image, height: 50,),
            Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(_list[index].name, style: TextStyle(
                  color: Color(0xffFC9535),
                  fontSize: 19
                ),),
                SizedBox(height: 2,),
                Text(_list[index].speciality, style: TextStyle(
                  fontSize: 15
                ),)
              ],
            ),
            
            Spacer(),
             Spacer(),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15,
              vertical: 9),
              decoration: BoxDecoration(
                color: Color(0xffFBB97C),
                borderRadius: BorderRadius.circular(13)
              ),
              child: Text("Book", style: TextStyle(
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.w500
              ),),
            )
          
            ])]))),
              onTap: () {
               
               setState(() {
                  widget.search.name = _list[index].name;
                 widget.search.image=_list[index].image;
                 widget.search.speciality=_list[index].speciality;
                 

               });
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DoctorDetails(search: widget.search,dsearch:widget.dsearch) 
              
                  ));})
            
            ))));
        
  }
}