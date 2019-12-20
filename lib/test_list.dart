//https://stackoverflow.com/questions/47085070/how-to-get-the-index-key-of-the-selected-item-in-the-list-flutter
//https://github.com/vignesh7501/Flutter-ListView-and-GridView/blob/master/lib/main.dart

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:medical_lab/centers.dart';
import 'package:medical_lab/database/DB_DATA.dart';
import 'package:medical_lab/database/model/TestType.dart';
import 'package:medical_lab/database/model/Testlist.dart';
import 'package:medical_lab/database/model/CitySelecter.dart';
import 'package:medical_lab/test_type.dart';

class test_list extends StatefulWidget {
  final String mobile;
  final TestType test_select;

  test_list({Key key, this.mobile, this.test_select}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<test_list> {
  Testlist testlist_select;
  CitySelecter selectedcity;

  List<CitySelecter> citylist = [];

  @override
  void initState() {
    fetchdata();
    super.initState();

    // listview ; (context, index) => widget
    // futurebuilder; (context, snapshot) => widget
    // stream

  }

  void fetchdata() async {
    DB_DATA().citylist().then((list) {
      setState(() {
        citylist = list;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("images/bg.png"),
          fit: BoxFit.fill,
          colorFilter: new ColorFilter.mode(
              Colors.black.withOpacity(0.6), BlendMode.dstATop),
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: new Column(
          children: <Widget>[
            new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: new Padding(
                      padding: EdgeInsets.only(top: 50.0),
                      child: new IconButton(
                          icon: const Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => test_type(mobile: widget.mobile)),
                            );
                          }),
                    ),
                  ),
                  Expanded(
                      flex: 3,
                      child: new Padding(
                        padding: EdgeInsets.only(top: 50.0),
                        child: new Text(
                          "Test List",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 25.0,
                          ),
                        ),
                      ))
                ]),
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  flex: 3,
                  child: new Padding(
                    padding: EdgeInsets.only(top: 50.0),
                    child: new Text(
                      "Please select city: ${selectedcity?.cityname}",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                      textDirection: TextDirection.rtl,
                    ),
                  ),
                ),

                Expanded(
                  child: new PopupMenuButton<CitySelecter>(
                    onSelected: (value) {
                      setState(() {
                        selectedcity = value;
                      });
                    },
                    itemBuilder: (BuildContext context) {
                      List<PopupMenuEntry<CitySelecter>> select_city = [];
                      citylist.forEach((city) {
                        PopupMenuItem<CitySelecter> city_entry = PopupMenuItem(
                          child: Text(" ${city.cityname}"),
                          value: city,
                        );
                        select_city.add(city_entry);
                      });
                      return select_city;
                    },
                    padding: EdgeInsets.only(top:50.0,right:50.0),
                    icon: Icon(
                      Icons.expand_more,
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),

            Expanded(
              child: FutureBuilder<List<Testlist>>(
                future: DB_DATA().testlist(widget.test_select),
                initialData: [],
                builder: (context, snapshot) {
                  //print("select: ${widget.selected}");
                  //print('snapshot count: ${snapshot.data.length}');
                  return snapshot.hasData
                      ? new ListView.builder(
                          itemCount: snapshot.data.length,
                          padding: EdgeInsets.only(top: 40.0, bottom: 50.0, left: 20.0, right: 20.0),
                          itemBuilder: (BuildContext context, int index) {
                            return new ListTile(
                              title: new Card(
                                elevation: 5.0,
                                color: Colors.lightBlue[300],
                                child: new Container(
                                  alignment: Alignment.center,
                                  margin: new EdgeInsets.only(
                                      top: 10.0, bottom: 10.0),
                                  child: new Text(
                                    snapshot.data.elementAt(index).name,
                                    style: new TextStyle(
                                      fontSize: 18.0,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              onTap: () {
                                setState(() {
                                    testlist_select = snapshot.data.elementAt(index);
                                  },
                                );
                                cityform();
                              },
                            );
                          },
                        )
                      : Center(
                          child: CircularProgressIndicator(),
                        );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void cityform() {
    if(selectedcity?.cityname == null){
      Fluttertoast.showToast(
          msg: "Please select city!!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 1,
          backgroundColor: Colors.lightBlue,
          textColor: Colors.white,
          fontSize: 15.0
      );
    }else{
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) =>
          new centers(
              mobile: widget.mobile,
              selectedcity: selectedcity,
              testlist_select: testlist_select,
              test_select:widget.test_select,
          ),
        ),
      );
    }
  }


}
