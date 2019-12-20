import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:medical_lab/centers.dart';
import 'package:medical_lab/database/DB_DATA.dart';
import 'package:medical_lab/database/model/Centerlist.dart';
import 'package:medical_lab/database/model/CitySelecter.dart';
import 'package:medical_lab/database/model/TestType.dart';
import 'package:medical_lab/database/model/Testlist.dart';

class fill_detail extends StatefulWidget {
  final String mobile;
  final Testlist testlist_select;
  final TestType test_select;
  final CitySelecter selectedcity;
  final Centerlist center_detail;
  final Centerlist detail_id;

  fill_detail({Key key, this.mobile, this.selectedcity, this.testlist_select, this.test_select, this.center_detail, this.detail_id}) : super(key: key);


  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<fill_detail> {

  String age,name;
  GlobalKey<FormState> _key = new GlobalKey();
  bool _validate = false;
  int selectedRadio;

  DateTime date1,time1;

  List<Centerlist> detail = [];
  DB_DATA dbdata;
  List<Centerlist> detail_contain;
  String c_name,c_add;
  int price;

  @override
  void initState() {
    fetchdata();
    super.initState();

    // listview ; (context, index) => widget
    // futurebuilder; (context, snapshot) => widget
    // stream

  }

  void fetchdata() async {
    DB_DATA().fill_detail_id(widget.detail_id).then((list) {
      setState(() {
        detail = list;
        detail.forEach((city) {
          price = city.prc;
          c_name = city.centname;
          c_add = city.centaddr;
        });
      });
    });
    //print("detail index: ${detail[5]}");
    //detail_contain = detail.asMap() as List<Centerlist>;
  }

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
            body: new SingleChildScrollView(
              padding: new EdgeInsets.only(bottom: 130.0),
              child: new Container(
                padding: EdgeInsets.symmetric(horizontal: 65.0),
                child: new Form(
                  key: _key,
                  autovalidate: _validate,
                  child: getFormUI(),
                ),
              ),
            ),
          )
      );
  }

  Widget getFormUI() {
    return new Column(
      children: <Widget>[
        new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: new Padding(
                  padding: EdgeInsets.only(top: 50.0,right:15.0),
                  child:new IconButton(
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                      onPressed:() {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => centers(
                              //city:widget.city,
                              mobile:widget.mobile,
                              selectedcity:widget.selectedcity,
                              testlist_select:widget.testlist_select,
                              test_select:widget.test_select,
                          )),
                        );
                      }
                  ),
                ),
              ),

              Expanded(
                  flex: 3,
                  child: new Padding(
                    padding: EdgeInsets.only(top: 50.0,left:10.0),
                    child: new Text(
                      "Fill Details",
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

        SizedBox(height:50.0),
        TextFormField(
          decoration: InputDecoration(
            labelText: 'Enter your name',
            contentPadding: const EdgeInsets.all(5.0),
            labelStyle: new TextStyle(color: const Color(0xffffffff)),
            errorStyle: TextStyle(
              color: Colors.redAccent[700],
              wordSpacing: 2.0,
            ),
          ),
          style: new TextStyle(
            color: Colors.white,
            fontSize: 16.0,
          ),
          keyboardType: TextInputType.text,
          validator: validateName,
          onSaved: (String val) {
            name = val;
          },
        ),


        SizedBox(height:10.0),
        TextFormField(
          decoration: InputDecoration(
            labelText: 'Enter your age',
            contentPadding: const EdgeInsets.all(5.0),
            labelStyle: new TextStyle(color: const Color(0xffffffff)),
            errorStyle: TextStyle(
              color: Colors.redAccent[700],
              wordSpacing: 2.0,
            ),
          ),
          style: new TextStyle(
            color: Colors.white,
            fontSize: 16.0,
          ),
          keyboardType: TextInputType.number,
          onSaved: (String val) {
            age = val;
          },
          validator: (val) {
            if (val.isEmpty) {
              return 'Age is required';
            }
          },
        ),

        SizedBox(height: 20.0),
        new Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Radio(
              value: 1,
              groupValue: selectedRadio,
              onChanged: (val) {
                setState(() {
                  selectedRadio = val;
                });
              },
            ),

            new Text(
              "Male",
              style: new TextStyle(
                color: Colors.white,
                fontSize: 16.0,
              ),
            ),

            SizedBox(width: 40.0),
            Radio(
              value: 2,
              groupValue: selectedRadio,
              onChanged: (val) {
                setState(() {
                  selectedRadio = val;
                });
              },
            ),

            new Text(
              "Female",
              style: new TextStyle(
                color: Colors.white,
                fontSize: 16.0,
              ),
            ),
          ]
        ),

        DateTimePickerFormField(
          inputType: InputType.date,
          format: DateFormat("dd-MM-yyyy"),
          initialDate: DateTime.now(),
          lastDate: new DateTime(2100),
          editable: false,
          validator: (val) {
            if (val != null) {
              return null;
            } else {
              return 'Date is required';
            }
          },
          decoration: InputDecoration(
              hintText: 'Select Date',
              hintStyle: TextStyle(color: Colors.white),
              //hasFloatingPlaceholder: true,
          ),
          style: new TextStyle(
            color: Colors.white,
            fontSize: 16.0,
          ),
          onChanged: (dt) {
            setState(() => date1 = dt);
          },
        ),

        SizedBox(height: 10.0),
        DateTimePickerFormField(
          inputType: InputType.time,
          format: DateFormat("hh:mm a"),
          //initialTime: TimeOfDay(hour: 8, minute: 0),
          editable: false,
          validator: (val) {
            if (val != null) {
              return null;
            }
            /*else if(val < 9 && val > 20){
              return 'Select time from 9 am to 8pm';
            }*/
            else {
              return 'Time is required';
            }
          },
          decoration: InputDecoration(
              hintText: 'Select Time',
              hintStyle: TextStyle(color: Colors.white),
              hasFloatingPlaceholder: true
          ),
          style: new TextStyle(
            color: Colors.white,
            fontSize: 16.0,
          ),
          onChanged: (dt) {
            setState(() => time1 = dt);
          },
        ),

        SizedBox(height: 10.0),
        TextFormField(
          decoration: InputDecoration(
            labelText: 'Enter your address',
            contentPadding: const EdgeInsets.all(5.0),
            labelStyle: new TextStyle(color: const Color(0xffffffff)),
            errorStyle: TextStyle(
              color: Colors.redAccent[700],
              wordSpacing: 2.0,
            ),
          ),
          style: new TextStyle(
            color: Colors.white,
            fontSize: 16.0,
          ),
          onSaved: (String val) {
            name = val;
          },
          keyboardType: TextInputType.text,
          validator: (val) {
            if (val.isEmpty) {
              return 'Address is required';
            }
          },
        ),

        SizedBox(height:20.0),
        TextFormField(
          decoration: InputDecoration(
            labelText: 'Enter your email id',
            contentPadding: const EdgeInsets.all(5.0),
            labelStyle: new TextStyle(color: const Color(0xffffffff)),
            errorStyle: TextStyle(
              color: Colors.redAccent[700],
              wordSpacing: 2.0,
            ),
          ),
          style: new TextStyle(
            color: Colors.white,
            fontSize: 16.0,
          ),
          keyboardType: TextInputType.emailAddress,
          onSaved: (String val) {
            age = val;
          },
          validator: validateEmail,
        ),

        SizedBox(height: 30.0),
        new Align(
          alignment: Alignment.centerLeft,
          child:new Text(
            "Mobile no.: ${widget.mobile}",
            style: new TextStyle(
              color: Colors.white,
              fontSize: 16.0,
            ),
          ),
        ),

        SizedBox(height: 30.0),
        new Align(
          alignment: Alignment.centerLeft,
          child:new Text(
            "Test Name: ${widget.testlist_select.name}",
            style: new TextStyle(
              color: Colors.white,
              fontSize: 16.0,
            ),
          ),
        ),

            SizedBox(height: 30.0),
            new Align(
              alignment: Alignment.centerLeft,
              child:new Text(
                "Center Name:${c_name} ",
                style: new TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                ),
              ),
            ),

            SizedBox(height: 30.0),
            new Align(
              alignment: Alignment.centerLeft,
              child:new Text(
                "Center Address: ${c_add}",
                style: new TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                ),
              ),
            ),

            SizedBox(height: 30.0),
              new Align(
                alignment: Alignment.centerLeft,
                child: new Text(
                  "City: ${widget.selectedcity.cityname}",
                  style: new TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                ),
              ),

            SizedBox(height: 30.0),
            new Align(
              alignment: Alignment.centerLeft,
              child:new Text(
                "Price: ${price}",
                style: new TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                ),
              ),
            ),

        SizedBox(height: 20.0),
        RaisedButton(
          padding: EdgeInsets.symmetric(horizontal: 90.0),
          child: Text(
            'Submit',
            style: new TextStyle(
              fontSize: 15.5,
              color: Colors.lightBlue,
              fontWeight: FontWeight.bold,
            ),
          ),
          color:Colors.white,
          onPressed: _submit,
        ),
      ],
    );
  }

  String validateName(String value) {
    String patttern = r'(^[a-zA-Z ]*$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return "Name is required";
    } else if (!regExp.hasMatch(value)) {
      return "Name must be a-z and A-Z";
    }
    return null;
  }

  String validateEmail(String value) {
    String patttern = r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return "Email id is required";
    } else if (!regExp.hasMatch(value)) {
      return "Please enter a valid email id";
    }
    return null;
  }

  _submit() {
    if (_key.currentState.validate()) {
      Fluttertoast.showToast(
          msg: "Successfully Submit",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 1,
          backgroundColor: Colors.lightBlue,
          textColor: Colors.white,
          fontSize: 15.0
      );
      _key.currentState.save();
    }
  }
}