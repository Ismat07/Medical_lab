class TestType{

  final int testtypeid;
  final String testtypename;

  TestType(this.testtypeid, this.testtypename){}

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'testtypeid': testtypeid,
      'testtypename': testtypename,
    };
    return map;
  }

  TestType.fromMap(Map<String, dynamic> map)
      : this.testtypename = map['testtypename'],
        this.testtypeid = map['testtypeid'];

}