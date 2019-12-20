import 'dart:async';
import 'dart:io' as io;
import 'package:medical_lab/database/model/Center.dart';
import 'package:medical_lab/database/model/Centerlist.dart';
import 'package:medical_lab/database/model/TestType.dart';
import 'package:medical_lab/database/model/Testlist.dart';
import 'package:medical_lab/database/model/CitySelecter.dart';
import 'package:medical_lab/database/model/Log.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DB_DATA {
  static Database _db;
  static const String DB_NAME = 'medical.db';

  static const String USER_ID = 'user_id';
  static const String USER_MOBILE = 'user_mob';
  static const String USER_TABLE = 'user_id_table';

  static const String TEST_ID = 'test_id';
  static const String TEST_NAME = 'test_name';
  static const String TEST_TABLE = 'test_id_table';

  static const String CITY_ID = 'city_id';
  static const String CITY_NAME = 'city_name';
  static const String CITY_TABLE = 'city_name_table';

  static const String CENTER_ID = 'cent_id';
  //static const String CITY_ID = 'city_id';
  static const String CENTER_NAME = 'cent_name';
  static const String CENTER_TABLE = 'center_id_table';

  static const String LIST_ID = 'list_id';
  //static const String TEST_ID = 'test_id';
  static const String TEST_TYPE_NAME = 'test_type_name';
  static const String TEST_LIST_TABLE = 'test_list_table';

  static const String DETAIL_ID = 'detail_id';
  //static const String LIST_ID = 'list_id';
  //static const String CITY_ID = 'city_id';
  //static const String CENTER_NAME = 'cent_name';
  static const String CENTER_ADDR = 'cent_addr';
  static const String PRICE = 'price';
  static const String CENTER_LIST_TABLE = 'center_list_table';

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, DB_NAME);
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int _) async {
    await db.execute(
        "CREATE TABLE $USER_TABLE ($USER_ID INTEGER PRIMARY KEY AUTOINCREMENT, $USER_MOBILE TEXT NOT NULL UNIQUE)");
    await db.execute(
        "CREATE TABLE $TEST_TABLE ($TEST_ID INTEGER PRIMARY KEY AUTOINCREMENT, $TEST_NAME TEXT NOT NULL)");
    await db.execute(
        "CREATE TABLE $CITY_TABLE ($CITY_ID INTEGER PRIMARY KEY AUTOINCREMENT, $CITY_NAME TEXT NOT NULL)");
    await db.execute(
        "CREATE TABLE $CENTER_TABLE ($CENTER_ID INTEGER PRIMARY KEY AUTOINCREMENT, $CITY_ID INTEGER NOT NULL, $CENTER_NAME TEXT NOT NULL)");
    await db.execute(
        "CREATE TABLE $TEST_LIST_TABLE ($LIST_ID INTEGER PRIMARY KEY AUTOINCREMENT, $TEST_ID INTEGER NOT NULL, $TEST_TYPE_NAME TEXT NOT NULL)");
    await db.execute(
        "CREATE TABLE $CENTER_LIST_TABLE($DETAIL_ID INTEGER PRIMARY KEY AUTOINCREMENT, $LIST_ID INTEGER NOT NULL, $CITY_ID INTEGER NOT NULL,$CENTER_NAME TEXT NOT NULL, $CENTER_ADDR TEXT NOT NULL, $PRICE INTEGER NOT NULL)");

    return await db.transaction((txn) async {
      await txn.rawInsert("insert into $TEST_TABLE ($TEST_NAME) values('MRI')");
      await txn.rawInsert("insert into $TEST_TABLE ($TEST_NAME) values('X-RAY')");
      await txn.rawInsert("insert into $TEST_TABLE ($TEST_NAME) values('Blood Test')");
      await txn.rawInsert("insert into $TEST_TABLE ($TEST_NAME) values('Urine Test')");

      await txn.rawInsert("insert into $CITY_TABLE ($CITY_NAME) values('Jaipur')");
      await txn.rawInsert("insert into $CITY_TABLE ($CITY_NAME) values('Kota')");
      await txn.rawInsert("insert into $CITY_TABLE ($CITY_NAME) values('Udaipur')");
      await txn.rawInsert("insert into $CITY_TABLE ($CITY_NAME) values('Jodhpur')");
      await txn.rawInsert("insert into $CITY_TABLE ($CITY_NAME) values('Bikaner')");

      await txn.rawInsert("insert into $CENTER_TABLE ($CITY_ID,$CENTER_NAME) values('2','KotCent1')");
      await txn.rawInsert("insert into $CENTER_TABLE ($CITY_ID,$CENTER_NAME) values('2','KotCent2')");
      await txn.rawInsert("insert into $CENTER_TABLE ($CITY_ID,$CENTER_NAME) values('2','KotCent3')");
      await txn.rawInsert("insert into $CENTER_TABLE ($CITY_ID,$CENTER_NAME) values('2','KotCent4')");
      await txn.rawInsert("insert into $CENTER_TABLE ($CITY_ID,$CENTER_NAME) values('2','KotCent5')");
      await txn.rawInsert("insert into $CENTER_TABLE ($CITY_ID,$CENTER_NAME) values('2','KotCent6')");
      await txn.rawInsert("insert into $CENTER_TABLE ($CITY_ID,$CENTER_NAME) values('1','JaipCent1')");
      await txn.rawInsert("insert into $CENTER_TABLE ($CITY_ID,$CENTER_NAME) values('1','JaipCent2')");
      await txn.rawInsert("insert into $CENTER_TABLE ($CITY_ID,$CENTER_NAME) values('1','JaipCent3')");
      await txn.rawInsert("insert into $CENTER_TABLE ($CITY_ID,$CENTER_NAME) values('1','JaipCent4')");
      await txn.rawInsert("insert into $CENTER_TABLE ($CITY_ID,$CENTER_NAME) values('1','JaipCent5')");
      await txn.rawInsert("insert into $CENTER_TABLE ($CITY_ID,$CENTER_NAME) values('3','UdaipCent1')");
      await txn.rawInsert("insert into $CENTER_TABLE ($CITY_ID,$CENTER_NAME) values('3','UdaipCent2')");
      await txn.rawInsert("insert into $CENTER_TABLE ($CITY_ID,$CENTER_NAME) values('3','UdaipCent3')");
      await txn.rawInsert("insert into $CENTER_TABLE ($CITY_ID,$CENTER_NAME) values('3','UdaipCent4')");
      await txn.rawInsert("insert into $CENTER_TABLE ($CITY_ID,$CENTER_NAME) values('4','JodhpCent1')");
      await txn.rawInsert("insert into $CENTER_TABLE ($CITY_ID,$CENTER_NAME) values('4','JodhpCent2')");
      await txn.rawInsert("insert into $CENTER_TABLE ($CITY_ID,$CENTER_NAME) values('4','JodhpCent3')");
      await txn.rawInsert("insert into $CENTER_TABLE ($CITY_ID,$CENTER_NAME) values('5','BikCent1')");
      await txn.rawInsert("insert into $CENTER_TABLE ($CITY_ID,$CENTER_NAME) values('5','BikCent2')");

      await txn.rawInsert("insert into $TEST_LIST_TABLE ($TEST_ID,$TEST_TYPE_NAME) values('1','MRI Type1')");
      await txn.rawInsert("insert into $TEST_LIST_TABLE ($TEST_ID,$TEST_TYPE_NAME) values('1','MRI Type2')");
      await txn.rawInsert("insert into $TEST_LIST_TABLE ($TEST_ID,$TEST_TYPE_NAME) values('1','MRI Type3')");
      await txn.rawInsert("insert into $TEST_LIST_TABLE ($TEST_ID,$TEST_TYPE_NAME) values('1','MRI Type4')");
      await txn.rawInsert("insert into $TEST_LIST_TABLE ($TEST_ID,$TEST_TYPE_NAME) values('2','X-Ray Type1')");
      await txn.rawInsert("insert into $TEST_LIST_TABLE ($TEST_ID,$TEST_TYPE_NAME) values('2','X-Ray Type2')");
      await txn.rawInsert("insert into $TEST_LIST_TABLE ($TEST_ID,$TEST_TYPE_NAME) values('2','X-Ray Type3')");
      await txn.rawInsert("insert into $TEST_LIST_TABLE ($TEST_ID,$TEST_TYPE_NAME) values('2','X-Ray Type4')");
      await txn.rawInsert("insert into $TEST_LIST_TABLE ($TEST_ID,$TEST_TYPE_NAME) values('3','Blood Test Type1')");
      await txn.rawInsert("insert into $TEST_LIST_TABLE ($TEST_ID,$TEST_TYPE_NAME) values('3','Blood Test Type2')");
      await txn.rawInsert("insert into $TEST_LIST_TABLE ($TEST_ID,$TEST_TYPE_NAME) values('3','Blood Test Type3')");
      await txn.rawInsert("insert into $TEST_LIST_TABLE ($TEST_ID,$TEST_TYPE_NAME) values('3','Blood Test Type4')");
      await txn.rawInsert("insert into $TEST_LIST_TABLE ($TEST_ID,$TEST_TYPE_NAME) values('3','Blood Test Type5')");
      await txn.rawInsert("insert into $TEST_LIST_TABLE ($TEST_ID,$TEST_TYPE_NAME) values('4','Urine Test Type1')");
      await txn.rawInsert("insert into $TEST_LIST_TABLE ($TEST_ID,$TEST_TYPE_NAME) values('4','Urine Test Type2')");
      await txn.rawInsert("insert into $TEST_LIST_TABLE ($TEST_ID,$TEST_TYPE_NAME) values('4','Urine Test Type3')");

      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('1','2','KotCent1','Vigyan Nagar','200')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('2','2','KotCent1','Vigyan Nagar','300')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('3','2','KotCent1','Vigyan Nagar','500')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('4','2','KotCent1','Vigyan Nagar','200')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('5','2','KotCent1','Vigyan Nagar','300')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('6','2','KotCent1','Vigyan Nagar','200')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('7','2','KotCent1','Vigyan Nagar','600')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('8','2','KotCent1','Vigyan Nagar','500')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('9','2','KotCent1','Vigyan Nagar','300')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('10','2','KotCent1','Vigyan Nagar','200')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('11','2','KotCent1','Vigyan Nagar','600')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('12','2','KotCent1','Vigyan Nagar','300')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('13','2','KotCent1','Vigyan Nagar','200')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('14','2','KotCent1','Vigyan Nagar','450')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('15','2','KotCent1','Vigyan Nagar','300')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('16','2','KotCent1','Vigyan Nagar','200')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('1','2','KotCent2','Mahaveer Nagar','500')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('2','2','KotCent2','Mahaveer Nagar','600')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('3','2','KotCent2','Mahaveer Nagar','300')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('4','2','KotCent2','Mahaveer Nagar','450')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('5','2','KotCent2','Mahaveer Nagar','200')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('6','2','KotCent2','Mahaveer Nagar','600')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('7','2','KotCent2','Mahaveer Nagar','450')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('8','2','KotCent2','Mahaveer Nagar','300')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('9','2','KotCent2','Mahaveer Nagar','500')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('10','2','KotCent2','Mahaveer Nagar','600')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('11','2','KotCent2','Mahaveer Nagar','450')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('12','2','KotCent2','Mahaveer Nagar','300')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('13','2','KotCent2','Mahaveer Nagar','200')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('14','2','KotCent2','Mahaveer Nagar','500')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('15','2','KotCent2','Mahaveer Nagar','450')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('16','2','KotCent2','Mahaveer Nagar','300')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('1','2','KotCent3','Vishali Nagar','600')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('2','2','KotCent3','Vishali Nagar','450')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('3','2','KotCent3','Vishali Nagar','200')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('4','2','KotCent3','Vishali Nagar','500')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('5','2','KotCent3','Vishali Nagar','600')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('6','2','KotCent3','Vishali Nagar','300')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('7','2','KotCent3','Vishali Nagar','450')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('8','2','KotCent3','Vishali Nagar','450')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('9','2','KotCent3','Vishali Nagar','200')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('10','2','KotCent3','Vishali Nagar','600')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('11','2','KotCent3','Vishali Nagar','300')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('12','2','KotCent3','Vishali Nagar','500')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('13','2','KotCent3','Vishali Nagar','450')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('14','2','KotCent3','Vishali Nagar','450')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('15','2','KotCent3','Vishali Nagar','200')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('16','2','KotCent3','Vishali Nagar','600')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('1','2','KotCent4','Nayapura','300')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('2','2','KotCent4','Nayapura','500')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('3','2','KotCent4','Nayapura','600')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('4','2','KotCent4','Nayapura','450')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('5','2','KotCent4','Nayapura','300')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('6','2','KotCent4','Nayapura','200')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('7','2','KotCent4','Nayapura','250')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('8','2','KotCent4','Nayapura','300')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('9','2','KotCent4','Nayapura','200')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('10','2','KotCent4','Nayapura','400')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('11','2','KotCent4','Nayapura','350')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('12','2','KotCent4','Nayapura','500')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('13','2','KotCent4','Nayapura','550')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('14','2','KotCent4','Nayapura','450')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('15','2','KotCent4','Nayapura','450')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('16','2','KotCent4','Nayapura','500')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('1','2','KotCent5','Chawani','200')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('2','2','KotCent5','Chawani','500')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('3','2','KotCent5','Chawani','400')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('4','2','KotCent5','Chawani','450')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('5','2','KotCent5','Chawani','300')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('6','2','KotCent5','Chawani','250')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('7','2','KotCent5','Chawani','350')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('8','2','KotCent5','Chawani','200')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('9','2','KotCent5','Chawani','250')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('10','2','KotCent5','Chawani','550')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('11','2','KotCent5','Chawani','500')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('12','2','KotCent5','Chawani','300')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('13','2','KotCent5','Chawani','350')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('14','2','KotCent5','Chawani','200')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('15','2','KotCent5','Chawani','250')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('16','2','KotCent5','Chawani','500')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('1','2','KotCent6','CAD Circle','400')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('2','2','KotCent6','CAD Circle','300')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('3','2','KotCent6','CAD Circle','200')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('4','2','KotCent6','CAD Circle','250')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('5','2','KotCent6','CAD Circle','350')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('6','2','KotCent6','CAD Circle','450')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('7','2','KotCent6','CAD Circle','550')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('8','2','KotCent6','CAD Circle','200')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('9','2','KotCent6','CAD Circle','300')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('10','2','KotCent6','CAD Circle','400')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('11','2','KotCent6','CAD Circle','500')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('12','2','KotCent6','CAD Circle','600')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('13','2','KotCent6','CAD Circle','250')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('14','2','KotCent6','CAD Circle','350')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('15','2','KotCent6','CAD Circle','450')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('16','2','KotCent6','CAD Circle','550')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('1','1','JaipCent1','Dadabari','650')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('2','1','JaipCent1','Dadabari','200')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('3','1','JaipCent1','Dadabari','300')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('4','1','JaipCent1','Dadabari','400')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('5','1','JaipCent1','Dadabari','500')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('6','1','JaipCent1','Dadabari','600')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('7','1','JaipCent1','Dadabari','250')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('8','1','JaipCent1','Dadabari','350')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('9','1','JaipCent1','Dadabari','450')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('10','1','JaipCent1','Dadabari','550')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('11','1','JaipCent1','Dadabari','200')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('12','1','JaipCent1','Dadabari','300')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('13','1','JaipCent1','Dadabari','400')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('14','1','JaipCent1','Dadabari','500')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('15','1','JaipCent1','Dadabari','250')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('16','1','JaipCent1','Dadabari','350')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('1','1','JaipCent2','Keshavpura','450')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('2','1','JaipCent2','Keshavpura','550')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('3','1','JaipCent2','Keshavpura','200')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('4','1','JaipCent2','Keshavpura','300')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('5','1','JaipCent2','Keshavpura','400')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('6','1','JaipCent2','Keshavpura','500')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('7','1','JaipCent2','Keshavpura','600')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('8','1','JaipCent2','Keshavpura','250')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('9','1','JaipCent2','Keshavpura','350')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('10','1','JaipCent2','Keshavpura','450')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('11','1','JaipCent2','Keshavpura','550')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('12','1','JaipCent2','Keshavpura','200')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('13','1','JaipCent2','Keshavpura','300')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('14','1','JaipCent2','Keshavpura','400')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('15','1','JaipCent2','Keshavpura','500')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('16','1','JaipCent2','Keshavpura','600')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('1','1','JaipCent3','DCM','250')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('2','1','JaipCent3','DCM','350')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('3','1','JaipCent3','DCM','450')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('4','1','JaipCent3','DCM','550')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('5','1','JaipCent3','DCM','200')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('6','1','JaipCent3','DCM','300')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('7','1','JaipCent3','DCM','400')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('8','1','JaipCent3','DCM','500')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('9','1','JaipCent3','DCM','600')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('10','1','JaipCent3','DCM','250')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('11','1','JaipCent3','DCM','350')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('12','1','JaipCent3','DCM','450')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('13','1','JaipCent3','DCM','550')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('14','1','JaipCent3','DCM','200')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('15','1','JaipCent3','DCM','300')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('16','1','JaipCent3','DCM','400')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('1','1','JaipCent4','Mahaveer Nagar 1','500')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('2','1','JaipCent4','Mahaveer Nagar 1','600')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('3','1','JaipCent4','Mahaveer Nagar 1','250')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('4','1','JaipCent4','Mahaveer Nagar 1','350')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('5','1','JaipCent4','Mahaveer Nagar 1','450')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('6','1','JaipCent4','Mahaveer Nagar 1','550')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('7','1','JaipCent4','Mahaveer Nagar 1','200')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('8','1','JaipCent4','Mahaveer Nagar 1','300')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('9','1','JaipCent4','Mahaveer Nagar 1','400')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('10','1','JaipCent4','Mahaveer Nagar 1','500')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('11','1','JaipCent4','Mahaveer Nagar 1','600')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('12','1','JaipCent4','Mahaveer Nagar 1','250')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('13','1','JaipCent4','Mahaveer Nagar 1','350')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('14','1','JaipCent4','Mahaveer Nagar 1','450')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('15','1','JaipCent4','Mahaveer Nagar 1','550')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('16','1','JaipCent4','Mahaveer Nagar 1','200')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('1','1','JaipCent5','Mahaveer Nagar 2','300')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('2','1','JaipCent5','Mahaveer Nagar 2','400')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('3','1','JaipCent5','Mahaveer Nagar 2','500')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('4','1','JaipCent5','Mahaveer Nagar 2','600')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('5','1','JaipCent5','Mahaveer Nagar 2','250')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('6','1','JaipCent5','Mahaveer Nagar 2','350')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('7','1','JaipCent5','Mahaveer Nagar 2','450')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('8','1','JaipCent5','Mahaveer Nagar 2','500')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('9','1','JaipCent5','Mahaveer Nagar 2','200')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('10','1','JaipCent5','Mahaveer Nagar 2','600')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('11','1','JaipCent5','Mahaveer Nagar 2','300')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('12','1','JaipCent5','Mahaveer Nagar 2','400')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('13','1','JaipCent5','Mahaveer Nagar 2','500')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('14','1','JaipCent5','Mahaveer Nagar 2','600')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('15','1','JaipCent5','Mahaveer Nagar 2','250')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('16','1','JaipCent5','Mahaveer Nagar 2','350')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('1','3','UdaipCent1','Mahaveer Nagar 3','450')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('2','3','UdaipCent1','Mahaveer Nagar 3','550')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('3','3','UdaipCent1','Mahaveer Nagar 3','200')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('4','3','UdaipCent1','Mahaveer Nagar 3','300')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('5','3','UdaipCent1','Mahaveer Nagar 3','400')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('6','3','UdaipCent1','Mahaveer Nagar 3','500')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('7','3','UdaipCent1','Mahaveer Nagar 3','600')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('8','3','UdaipCent1','Mahaveer Nagar 3','250')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('9','3','UdaipCent1','Mahaveer Nagar 3','350')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('10','3','UdaipCent1','Mahaveer Nagar 3','450')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('11','3','UdaipCent1','Mahaveer Nagar 3','550')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('12','3','UdaipCent1','Mahaveer Nagar 3','200')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('13','3','UdaipCent1','Mahaveer Nagar 3','300')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('14','3','UdaipCent1','Mahaveer Nagar 3','400')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('15','3','UdaipCent1','Mahaveer Nagar 3','500')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('16','3','UdaipCent1','Mahaveer Nagar 3','250')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('1','3','UdaipCent2','Mahaveer Nagar Ext','350')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('2','3','UdaipCent2','Mahaveer Nagar Ext','450')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('3','3','UdaipCent2','Mahaveer Nagar Ext','550')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('4','3','UdaipCent2','Mahaveer Nagar Ext','200')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('5','3','UdaipCent2','Mahaveer Nagar Ext','300')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('6','3','UdaipCent2','Mahaveer Nagar Ext','400')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('7','3','UdaipCent2','Mahaveer Nagar Ext','500')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('8','3','UdaipCent2','Mahaveer Nagar Ext','600')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('9','3','UdaipCent2','Mahaveer Nagar Ext','250')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('10','3','UdaipCent2','Mahaveer Nagar Ext','350')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('11','3','UdaipCent2','Mahaveer Nagar Ext','450')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('12','3','UdaipCent2','Mahaveer Nagar Ext','550')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('13','3','UdaipCent2','Mahaveer Nagar Ext','200')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('14','3','UdaipCent2','Mahaveer Nagar Ext','300')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('15','3','UdaipCent2','Mahaveer Nagar Ext','400')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('16','3','UdaipCent2','Mahaveer Nagar Ext','500')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('1','3','UdaipCent3','Gumanpura','600')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('2','3','UdaipCent3','Gumanpura','250')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('3','3','UdaipCent3','Gumanpura','350')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('4','3','UdaipCent3','Gumanpura','450')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('5','3','UdaipCent3','Gumanpura','550')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('6','3','UdaipCent3','Gumanpura','200')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('7','3','UdaipCent3','Gumanpura','300')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('8','3','UdaipCent3','Gumanpura','400')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('9','3','UdaipCent3','Gumanpura','500')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('10','3','UdaipCent3','Gumanpura','600')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('11','3','UdaipCent3','Gumanpura','250')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('12','3','UdaipCent3','Gumanpura','350')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('13','3','UdaipCent3','Gumanpura','450')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('14','3','UdaipCent3','Gumanpura','550')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('15','3','UdaipCent3','Gumanpura','200')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('16','3','UdaipCent3','Gumanpura','300')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('1','3','UdaipCent4','Civil Line','400')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('2','3','UdaipCent4','Civil Line','500')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('3','3','UdaipCent4','Civil Line','250')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('4','3','UdaipCent4','Civil Line','350')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('5','3','UdaipCent4','Civil Line','450')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('6','3','UdaipCent4','Civil Line','550')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('7','3','UdaipCent4','Civil Line','200')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('8','3','UdaipCent4','Civil Line','300')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('9','3','UdaipCent4','Civil Line','400')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('10','3','UdaipCent4','Civil Line','500')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('11','3','UdaipCent4','Civil Line','600')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('12','3','UdaipCent4','Civil Line','250')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('13','3','UdaipCent4','Civil Line','350')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('14','3','UdaipCent4','Civil Line','450')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('15','3','UdaipCent4','Civil Line','550')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('16','3','UdaipCent4','Civil Line','200')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('1','4','JodhpCent1','Mansarovar','300')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('2','4','JodhpCent1','Mansarovar','400')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('3','4','JodhpCent1','Mansarovar','500')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('4','4','JodhpCent1','Mansarovar','600')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('5','4','JodhpCent1','Mansarovar','250')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('6','4','JodhpCent1','Mansarovar','350')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('7','4','JodhpCent1','Mansarovar','450')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('8','4','JodhpCent1','Mansarovar','550')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('9','4','JodhpCent1','Mansarovar','200')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('10','4','JodhpCent1','Mansarovar','300')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('11','4','JodhpCent1','Mansarovar','400')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('12','4','JodhpCent1','Mansarovar','500')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('13','4','JodhpCent1','Mansarovar','600')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('14','4','JodhpCent1','Mansarovar','250')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('15','4','JodhpCent1','Mansarovar','350')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('16','4','JodhpCent1','Mansarovar','450')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('1','4','JodhpCent2','Barkat Nagar','550')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('2','4','JodhpCent2','Barkat Nagar','200')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('3','4','JodhpCent2','Barkat Nagar','300')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('4','4','JodhpCent2','Barkat Nagar','400')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('5','4','JodhpCent2','Barkat Nagar','500')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('6','4','JodhpCent2','Barkat Nagar','600')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('7','4','JodhpCent2','Barkat Nagar','250')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('8','4','JodhpCent2','Barkat Nagar','350')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('9','4','JodhpCent2','Barkat Nagar','450')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('10','4','JodhpCent2','Barkat Nagar','550')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('11','4','JodhpCent2','Barkat Nagar','200')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('12','4','JodhpCent2','Barkat Nagar','300')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('13','4','JodhpCent2','Barkat Nagar','400')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('14','4','JodhpCent2','Barkat Nagar','500')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('15','4','JodhpCent2','Barkat Nagar','250')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('16','4','JodhpCent2','Barkat Nagar','350')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('1','4','JodhpCent3','Durgapura','450')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('2','4','JodhpCent3','Durgapura','550')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('3','4','JodhpCent3','Durgapura','200')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('4','4','JodhpCent3','Durgapura','300')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('5','4','JodhpCent3','Durgapura','400')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('6','4','JodhpCent3','Durgapura','500')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('7','4','JodhpCent3','Durgapura','600')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('8','4','JodhpCent3','Durgapura','250')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('9','4','JodhpCent3','Durgapura','350')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('10','4','JodhpCent3','Durgapura','450')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('11','4','JodhpCent3','Durgapura','550')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('12','4','JodhpCent3','Durgapura','200')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('13','4','JodhpCent3','Durgapura','300')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('14','4','JodhpCent3','Durgapura','400')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('15','4','JodhpCent3','Durgapura','500')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('16','4','JodhpCent3','Durgapura','600')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('1','5','BikCent1','Tilak Nagar','250')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('2','5','BikCent1','Tilak Nagar','350')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('3','5','BikCent1','Tilak Nagar','450')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('4','5','BikCent1','Tilak Nagar','550')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('5','5','BikCent1','Tilak Nagar','200')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('6','5','BikCent1','Tilak Nagar','500')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('7','5','BikCent1','Tilak Nagar','300')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('8','5','BikCent1','Tilak Nagar','400')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('9','5','BikCent1','Tilak Nagar','600')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('10','5','BikCent1','Tilak Nagar','250')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('11','5','BikCent1','Tilak Nagar','350')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('12','5','BikCent1','Tilak Nagar','450')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('13','5','BikCent1','Tilak Nagar','550')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('14','5','BikCent1','Tilak Nagar','200')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('15','5','BikCent1','Tilak Nagar','300')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('16','5','BikCent1','Tilak Nagar','400')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('1','5','BikCent2','Shyam Nagar','500')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('2','5','BikCent2','Shyam Nagar','600')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('3','5','BikCent2','Shyam Nagar','250')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('4','5','BikCent2','Shyam Nagar','350')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('5','5','BikCent2','Shyam Nagar','450')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('6','5','BikCent2','Shyam Nagar','550')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('7','5','BikCent2','Shyam Nagar','200')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('8','5','BikCent2','Shyam Nagar','300')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('9','5','BikCent2','Shyam Nagar','400')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('10','5','BikCent2','Shyam Nagar','500')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('11','5','BikCent2','Shyam Nagar','600')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('12','5','BikCent2','Shyam Nagar','250')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('13','5','BikCent2','Shyam Nagar','350')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('14','5','BikCent2','Shyam Nagar','450')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('15','5','BikCent2','Shyam Nagar','550')");
      await txn.rawInsert("insert into $CENTER_LIST_TABLE ($LIST_ID,$CITY_ID,$CENTER_NAME,$CENTER_ADDR,$PRICE) values('16','5','BikCent2','Shyam Nagar','500')");
    });
  }

  Future<List<Log>> getPatient() async {
    Database dbClient = await db;
    List<Map> maps =
        await dbClient.query(USER_TABLE, columns: [USER_ID, USER_MOBILE]);
    //List<Map> maps = await dbClient.rawQuery("SELECT * FROM $TABLE");
    List<Log> data = [];
    if (maps.length > 0) {
      maps.forEach((map) {
        print('map; ${map.toString()}');
      });
    }
    return data;
  }

  Future<Log> register(Log data) async {
    Database dbClient = await db;
    return await dbClient.transaction((txn) async {
      var query = "INSERT INTO $USER_TABLE ($USER_MOBILE) VALUES('${data.mobil}')";
      await txn.rawInsert(query);
    });
  }

  Future<bool> login(Log data) async {
    Database dbClient = await db;
    return await dbClient.transaction((txn) async {
      var query = "select $USER_MOBILE from $USER_TABLE where $USER_MOBILE ='${data.mobil}'";
      List<Map<String, dynamic>> resultlist = await txn.rawQuery(query);
      if (resultlist != null && resultlist.length >= 1) {
        return true;
      } else {
        return false;
      }
    });
  }

  Future<List<TestType>> testtype() async {
    Database dbClient = await db;
    List<Map> resultlist = await dbClient.rawQuery("select * from $TEST_TABLE");
    List<TestType> data = [];
    if (resultlist.length > 0) {
      resultlist.forEach((map) {
        TestType p = TestType(map[TEST_ID], map[TEST_NAME]);
        data.add(p);
      });
    }
    return data;
  }

  Future<List<CitySelecter>> citylist() async {
    Database dbClient = await db;
    List<Map> resultlist = await dbClient.rawQuery("select * from $CITY_TABLE");
    List<CitySelecter> data = [];
    if (resultlist.length > 0) {
      resultlist.forEach((map) {
        CitySelecter p = CitySelecter(map[CITY_ID], map[CITY_NAME]);
        data.add(p);
      });
    }
    return data;
  }

  Future<List<Testlist>> testlist(TestType test) async {
    Database dbClient = await db;
    return await dbClient.transaction((txn) async {
      var query = "select * from $TEST_LIST_TABLE where $TEST_ID ='${test.testtypeid}'";
      List<Map<String, dynamic>> resultlist = await txn.rawQuery(query);
      List<Testlist> data = [];
      if (resultlist.length > 0) {
        resultlist.forEach((map) {
          //print('resultlist; ${map.toString()}');
          Testlist p = Testlist(map[LIST_ID], map[TEST_ID], map[TEST_TYPE_NAME]);
          data.add(p);
        });
        return data;
      }
    });
  }

  Future<List<Center>> centerlist(CitySelecter test) async {
    Database dbClient = await db;
    return await dbClient.transaction((txn) async {
      var query = "select $CENTER_NAME from $CENTER_TABLE where $CITY_ID ='${test.cityid}'";
      List<Map<String, dynamic>> resultlist = await txn.rawQuery(query);
      List<Center> data = [];
      if (resultlist.length > 0) {
        resultlist.forEach((map) {
          print('centerlist: ${map.toString()}');
          Center p = Center(map[CENTER_ID], map[CITY_ID], map[CENTER_NAME]);
          data.add(p);
        });
        return data;
      }
    });
  }

  Future<List<Centerlist>> detaillist(CitySelecter city,Testlist list_id) async {
    Database dbClient = await db;
    return await dbClient.transaction((txn) async {
      var query = "select * from $CENTER_LIST_TABLE where $CITY_ID ='${city.cityid}' and $LIST_ID ='${list_id.listid}'";
      List<Map<String, dynamic>> resultlist = await txn.rawQuery(query);
      List<Centerlist> data = [];
      if (resultlist.length > 0) {
        resultlist.forEach((map) {
          //print('resultlist; ${map.toString()}');
          Centerlist p = Centerlist(map[DETAIL_ID], map[LIST_ID], map[CITY_ID], map[CENTER_NAME], map[CENTER_ADDR], map[PRICE]);
          data.add(p);
        });
        return data;
      }
    });
  }

  Future<List<Centerlist>> fill_detail_id(Centerlist id) async {
    Database dbClient = await db;
    return await dbClient.transaction((txn) async {
      var query = "select * from $CENTER_LIST_TABLE where $DETAIL_ID ='${id.detailid}'";
      List<Map<String, dynamic>> resultlist = await txn.rawQuery(query);
      List<Centerlist> data = [];
      if (resultlist.length > 0) {
        resultlist.forEach((map) {
          print('detail_id; ${map.toString()}');
          Centerlist p = Centerlist(map[DETAIL_ID], map[LIST_ID], map[CITY_ID], map[CENTER_NAME], map[CENTER_ADDR], map[PRICE]);
          data.add(p);
        });
        return data;
      }
    });
  }

  /*Future<int> delete(int id) async {
    var dbClient = await db;
    return await dbClient.delete(TABLE, where: '$ID = ?', whereArgs: [id]);
  }*/

  Future<int> update(Log data) async {
    var dbClient = await db;
    return await dbClient.update(USER_TABLE, data.toMap(),
        where: '$USER_ID = ?', whereArgs: [data.id]);
  }

  Future close() async {
    var dbClient = await db;
    dbClient.close();
  }

}
