//https://flutterawesome.com/simple-folding-cell-widget-implemented-in-flutter/

import 'package:medical_lab/database/DB_DATA.dart';
import 'package:medical_lab/database/model/Centerlist.dart';
import 'package:medical_lab/database/model/CitySelecter.dart';
import 'package:medical_lab/database/model/Log.dart';
import 'package:medical_lab/database/model/TestType.dart';
import 'package:medical_lab/database/model/Testlist.dart';
import 'package:medical_lab/fill_detail.dart';
import 'package:flutter/material.dart';
import 'package:folding_cell/folding_cell.dart';
import 'package:medical_lab/test_list.dart';

class centers extends StatefulWidget {
  final String mobile;
  final Testlist testlist_select;
  final TestType test_select;
  final CitySelecter selectedcity;

  centers({Key key,this.mobile, this.selectedcity, this.testlist_select, this.test_select}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ListItemWidget();
  }
}

class ListItemWidget extends State<centers> {
  List<Center> cent_list = [];
  Centerlist center_detail,detail_id;
  List<Center> cent_name = [];
  DB_DATA dbdata;

  @override
  Widget build(BuildContext context) {
      return Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/bg.png"),
              fit: BoxFit.fill,
              colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.6), BlendMode.dstATop),
            )
          ),

          child: Scaffold(
            backgroundColor: Colors.transparent,
            body:new Column(
              children:<Widget>[
                new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        flex: 2,
                        child: new Padding(
                          padding: EdgeInsets.only(top: 50.0),
                          child:new IconButton(
                              icon: const Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                              ),
                              onPressed:() {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => test_list(mobile:widget.mobile,test_select:widget.test_select)),
                                );
                              }
                          ),
                        ),
                      ),

                      Expanded(
                          flex: 4,
                          child: new Padding(
                            padding: EdgeInsets.only(top: 50.0),
                            child: new Text(
                              "Centers List",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 25.0,
                              ),
                            ),
                          )
                      )
                    ]
                ),

                Expanded(
                    child: FutureBuilder<List<Centerlist>>(
                    future:DB_DATA().detaillist(widget.selectedcity,widget.testlist_select),
                      initialData: [],
                        builder: (context, snapshot) {
                        return snapshot.hasData
                      ? new ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            center_detail = snapshot.data.elementAt(index);
                            return SimpleFoldingCell(
                                frontWidget: _buildFrontWidget(),
                                innerTopWidget: _buildInnerTopWidget(),
                                innerBottomWidget: _buildInnerBottomWidget(center_detail),
                                cellSize: Size(MediaQuery.of(context).size.width, 125),
                                padding: EdgeInsets.all(15),
                                animationDuration: Duration(milliseconds: 300),
                                borderRadius: 20,
                                onOpen: () {
                                  detail_state(snapshot, index);
                                },
                                onClose: (){},
                            );
                          }
                          )
                          : Center(
                              child: CircularProgressIndicator(),
                            );
                      },
                    ),
                )
              ]
            )
          )
      );
  }

  Widget _buildFrontWidget() {
    return Builder(
      builder: (BuildContext context) {
        return Container(
            color:Colors.lightBlue[300],
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
              Text("${center_detail.centname}",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 23.0,
                  )
              ),

                SizedBox(height:20.0),
                RaisedButton(
                  child: Text(
                    "Details",
                    style: new TextStyle(
                      fontSize: 14.0,
                      color: Colors.lightBlue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  color:Colors.white,
                  onPressed: () {
                    SimpleFoldingCellState foldingCellState = context.ancestorStateOfType(TypeMatcher<SimpleFoldingCellState>());
                    foldingCellState?.toggleFold();
                  },
                 // splashColor: Colors.white.withOpacity(0.5),
                )
              ],
            )
        );
      },
    );
  }

  Widget _buildInnerTopWidget() {
    return Container(
        color: Colors.white,
        padding: EdgeInsets.only(top:20.0,left:0.0),
        child: Column(
            children: <Widget>[
              Text(
                  "Address: ${center_detail.centaddr}",
                  style: TextStyle(
                    color:Colors.blue,
                    fontSize: 20.0,
                  )
              ),

              Text(
                  "Price: ${center_detail.prc}",
                  style: TextStyle(
                    color:Colors.blue,
                    fontSize: 20.0,
                  )
              ),

              Text(
                  "City: ${widget.selectedcity.cityname} ",
                  style: TextStyle(
                    color:Colors.blue,
                    fontSize: 20.0,
                  )
              )
          ]
        )
    );
  }

  detail_state(AsyncSnapshot snapshot,int index) {
    setState(() {
      center_detail = snapshot.data.elementAt(index);
      //center_detail = snapshot.data.elementAt(index).prc;
    });

  }

  Widget _buildInnerBottomWidget(Centerlist deta_id) {
    return Builder(builder: (context) {
      return Container(
        color:Colors.lightBlue[300],
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 50.0),
          child:ButtonBar(
            children: <Widget>[
              RaisedButton(
                child: Text(
                  "Close",
                  style: new TextStyle(
                    fontSize: 14.0,
                    color: Colors.lightBlue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                color:Colors.white,
                onPressed: () {
                  SimpleFoldingCellState foldingCellState = context.ancestorStateOfType(TypeMatcher<SimpleFoldingCellState>());
                  foldingCellState?.toggleFold();
                },
              ),

              RaisedButton(
                child: Text(
                  "Continue",
                  style: new TextStyle(
                    fontSize: 14.0,
                    color: Colors.lightBlue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                color:Colors.white,
                onPressed: () {
                    setState(() {
                      detail_id = deta_id;
                    },
                    );
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => fill_detail(
                        selectedcity:widget.selectedcity,
                        testlist_select:widget.testlist_select,
                        mobile:widget.mobile,
                        test_select:widget.test_select,
                        center_detail:center_detail,
                        detail_id:detail_id,
                    )
                    ),
                  );
                },
              ),
            ]
          ),
        )
      );
    }
    );
  }
}