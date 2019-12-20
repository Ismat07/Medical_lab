import 'package:fluttertoast/fluttertoast.dart';
import 'package:medical_lab/database/DB_DATA.dart';
import 'package:flutter/material.dart';
import 'package:medical_lab/test_type.dart';
import 'package:flutter/services.dart';
import 'package:medical_lab/database/model/Log.dart';
import 'dart:async';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/',
    routes: {
      '/': (context) => MyApp(),
      '/second': (context) => test_type(),
    },
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  var _logController = new TextEditingController();
  var _registController = new TextEditingController();
  String mobile,mob;
  GlobalKey<FormState> _key = new GlobalKey();
  GlobalKey<FormState> _key2 = new GlobalKey();
  Future<List<Log>> data;
  int userId;
  DB_DATA dbdata;

  bool _validate = false,isLogin = true,isUpdating;
  Animation<double> loginSize;
  AnimationController loginController;
  AnimatedOpacity opacityAnimation;
  Duration animationDuration = Duration(milliseconds: 270);

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([]);
    loginController = AnimationController(vsync: this, duration: animationDuration);
    opacityAnimation = AnimatedOpacity(opacity: 0.0, duration: animationDuration);
    dbdata = DB_DATA();
    isUpdating = false;
    refreshList();
  }

  refreshList() {
    setState(() {
      data = dbdata.getPatient();
    });
  }

  @override
  void dispose() {
    loginController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double _defaultLoginSize = MediaQuery.of(context).size.height / 1.6;

    loginSize = Tween<double>(begin: _defaultLoginSize, end: 200).animate(
        CurvedAnimation(parent: loginController, curve: Curves.linear));

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.center,
            child: AnimatedOpacity(
              opacity: isLogin ? 0.0 : 1.0,
              duration: animationDuration,
              child: Container(child: new Form(
                  key: _key2,
                  autovalidate: _validate,
                  child: _buildRegistercomponents()),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.only(bottom: 100),
              color: isLogin && !loginController.isAnimating ? Colors.white : Colors.transparent,
              width: MediaQuery.of(context).size.width,
              height: _defaultLoginSize/2.9,
              child: Visibility(
                visible: isLogin,
                child: GestureDetector(
                  onTap: () {
                    loginController.forward();
                    setState(() {
                      isLogin = !isLogin;
                    });
                  },
                  child: Center(
                    child: Text(
                      'Sign Up'.toUpperCase(),
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.lightBlue,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          AnimatedBuilder(
            animation: loginController,
            builder: (context, child) {
              return _buildLoginWidgets();
            },
          ),
          Align(
              alignment: Alignment.topCenter,
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height/2,
                  child: Center(
                    child:new Form(
                        key: _key,
                        autovalidate: _validate,
                        child: _buildLoginComponents()),
                  )
              )
          )
        ],
      ),
    );
  }

  Widget _buildLoginWidgets() {
    return Container(
      padding: EdgeInsets.only(bottom: 62, top: 16),
      width: MediaQuery.of(context).size.width,
      height: loginSize.value,
      decoration: BoxDecoration(
          color: Colors.lightBlue[300],
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(190),
              bottomRight: Radius.circular(190))),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: AnimatedOpacity(
          opacity: loginController.value,
          duration: animationDuration,
          child: GestureDetector(
            onTap: isLogin ? null : () {
              loginController.reverse();

              setState(() {
                isLogin = !isLogin;
              });
            },
            child: Container(
              child: Text(
                'LOG IN'.toUpperCase(),
                style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoginComponents() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Visibility(
          visible: isLogin,
          child: Padding(
            padding: const EdgeInsets.only(left: 42, right: 42),
            child: Column(
              children: <Widget>[
                TextFormField(
                  controller: _logController,
                  style: TextStyle(
                    //letterSpacing: 1.3,
                    color: Colors.white,
                    height: 0.5,
                    fontSize: 20,
                  ),
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.phone_android),
                    hintText: 'Enter mobile number',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(32)),
                    ),
                    errorStyle: TextStyle(
                      color: Colors.redAccent[700],
                      wordSpacing: 2.0,
                    ),
                  ),
                  keyboardType: TextInputType.phone,
                  maxLength: 10,
                  validator: validateMobile,
                  onSaved: (String val) {
                    mobile = val;
                  },
                ),

                SizedBox(height:20.0),
                RaisedButton(
                  padding: EdgeInsets.symmetric(horizontal: 90.0),
                  child: Text(
                    'Log in',
                    style: new TextStyle(
                      fontSize: 15.5,
                      color: Colors.lightBlue[300],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  color:Colors.white,
                  onPressed: _login,
                )
                /*Container(
                  width: 200,
                  height: 40,
                  margin: EdgeInsets.only(top: 40),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(50))
                  ),
                  child: Center(
                    child: Text(
                      'LOG IN',
                      style: TextStyle(color:Colors.lightBlue,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                )*/
              ],
            ),
          ),
        ),

      ],
    );
  }

  Widget _buildRegistercomponents() {
    return Padding(
      padding: EdgeInsets.only(
          left: 42,
          right: 42,
          top: 120,
          bottom: 10
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 100),
            child: Text(
              'Sign Up'.toUpperCase(),
              style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.lightBlue),
            ),
          ),

          //SizedBox(height:20.0),
          TextFormField(
            controller: _registController,
            style: TextStyle(
              color: Colors.lightBlue[300],
              height: 0.5,
              fontSize: 20,
            ),
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.phone_android),
              hintText: 'Enter mobile number',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(32)),
              ),
              errorStyle: TextStyle(
                color: Colors.redAccent[700],
                wordSpacing: 2.0,
              ),
            ),
            keyboardType: TextInputType.phone,
            maxLength: 10,
            validator: validateMobile,
            onSaved: (String val) {
              mob = val;
            },
          ),

          SizedBox(height:20.0),
          RaisedButton(
            padding: EdgeInsets.symmetric(horizontal: 90.0),
            child: Text(
              'Sign Up',
              style: new TextStyle(
                fontSize: 15.5,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            color:Colors.lightBlue,
            onPressed: _reg,
          )

        ],
      ),
    );
  }

  String validateMobile(String value) {
    String patttern = r'(^[6-9]\d{9}$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return "Mobile number is required";
    } else if(value.length != 10){
      return "Mobile number must be 10 digits";
    }else if (!regExp.hasMatch(value)) {
      return "Mobile number must be digits";
    }
    return null;
  }

  _login() async{
    if (_key.currentState.validate()) {
      _key.currentState.save();
      Log e = Log(null, mobile);
      bool a = await dbdata.login(e);
      refreshList();
      if (a == true) {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => new test_type(mobile: mobile)),
        );
      }else{
        Fluttertoast.showToast(
            msg: "You are not registed!!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIos: 1,
            backgroundColor: Colors.white,
            textColor: Colors.lightBlue,
            fontSize: 15.0
        );
      }
    }
  }

  _reg() async {
    if (_key2.currentState.validate()) {
      _key2.currentState.save();
      if (isUpdating) {
        Log e = Log(userId, mob);
        dbdata.update(e);
        setState(() {
          isUpdating = false;
        });
      }
      else {
        try {
          Log e = Log(null, mob);
          await dbdata.register(e);

          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => new test_type(mobile: mob)),
          );
        }catch(DatabaseException){
          Fluttertoast.showToast(
              msg: "You are already registed!!",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIos: 1,
              backgroundColor: Colors.lightBlue,
              textColor: Colors.white,
              fontSize: 15.0
          );
        }finally{
          refreshList();
        }
      }

    }
  }

}