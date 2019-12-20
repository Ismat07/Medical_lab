//https://flutterawesome.com/a-flutter-package-for-easily-implementing-material-design-navigation-transitions/

import 'package:flutter/material.dart';
import 'package:medical_lab/database/DB_DATA.dart';
import 'package:medical_lab/database/model/Log.dart';
import 'package:medical_lab/database/model/TestType.dart';
import 'package:medical_lab/test_list.dart';

class test_type extends StatefulWidget {
  final String mobile;

  test_type({Key key, this.mobile}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<test_type> {

  TestType test_select;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/bg.png"),
              fit: BoxFit.fill,
              colorFilter: new ColorFilter.mode(
                Colors.black.withOpacity(0.6), BlendMode.dstATop),
            )
        ),
        child: Scaffold(
            backgroundColor: Colors.transparent,
            body: new Column(
                children: <Widget>[
                  SizedBox(height: 50.0),
                  Text(
                    "Select Test",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 25.0,
                    ),
                  ),

                  Expanded(
                    child: FutureBuilder<List<TestType>>(
                      future: DB_DATA().testtype(),
                      initialData: [],
                      builder: (context, snapshot) {
                        //print('snapshot count: ${snapshot.data.length}');
                        return snapshot.hasData
                            ? new GridView.builder(
                                padding: EdgeInsets.only(
                                    top: 100.0,
                                    bottom: 50.0,
                                    left: 20.0,
                                    right: 20.0
                                ),
                                itemCount: snapshot.data.length,
                                gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        childAspectRatio: 1.5,
                                        crossAxisSpacing: 8.0,
                                        mainAxisSpacing: 20.0
                                ),
                                itemBuilder: (BuildContext context, int index) {
                                  return new GestureDetector(
                                    child: new Card(
                                      elevation: 5.0,
                                      color: Colors.lightBlue[300],
                                      child: new Container(
                                        alignment: Alignment.center,
                                        margin: new EdgeInsets.only(
                                            top: 10.0,
                                            bottom: 10.0,
                                            left: 10.0
                                        ),
                                        child: new Text(
                                          snapshot.data.elementAt(index).testtypename,
                                          style: new TextStyle(
                                            fontSize: 18.0,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                    onTap: () {
                                        setState((){
                                          test_select = snapshot.data.elementAt(index);
                                        });

                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (BuildContext context) => new test_list(mobile: widget.mobile, test_select:test_select)),
                                      );
                                    },
                                  );
                                },
                              )
                            : Center(
                                child: CircularProgressIndicator(),
                              );
                        }
                      )
                  )
                ]
            )
        )
    );
  }
}
