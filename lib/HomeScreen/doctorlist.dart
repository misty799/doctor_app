import 'package:flutter/material.dart';

class DoctorsTile extends StatelessWidget {
  final String _image = 'assets/skin.jpg';
  final String _name = 'Stefan Albert';

  final String _spec = 'Dentist';
  @override
  Widget build(BuildContext context) {
    return lists(_image, _name, _spec);
  }

  Widget lists(text, text1, text2) {
    return GestureDetector(
        onTap: () {},
        child: Container(
            child: Padding(
                padding: const EdgeInsets.only(
                  left: 8.0,
                  right: 8.0,
                ),
                child: Card(
                    color: Colors.blue[100],
                    child: InkWell(
                        child: Expanded(
                            child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(children: <Widget>[
                                  Row(children: <Widget>[
                                    Image.asset(
                                      text,
                                      height: 70,
                                    ),
                                    Spacer(),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          text1,
                                          style: TextStyle(
                                              color: Color(0xffFC9535),
                                              fontSize: 19),
                                        ),
                                        SizedBox(
                                          height: 2,
                                        ),
                                        Text(
                                          text2,
                                          style: TextStyle(fontSize: 15),
                                        )
                                      ],
                                    ),
                                    Spacer(),
                                    Spacer(),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 9),
                                      decoration: BoxDecoration(
                                          color: Color(0xffFBB97C),
                                          borderRadius:
                                              BorderRadius.circular(13)),
                                      child: Text(
                                        "Book",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 13,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    )
                                  ])
                                ]))),
                        onTap: () {})))));
  }
}
