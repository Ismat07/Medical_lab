class Testlist{

  final int listid,testid;
  final String name;

  Testlist(this.listid,this.testid, this.name){}

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'listid': listid,
      'testid': testid,
      'name': name,
    };
    return map;
  }

  Testlist.fromMap(Map<String, dynamic> map)
      :this.listid = map['listid'],
        this.testid = map['testid'],
        this.name = map['name'];


}