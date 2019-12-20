class Centerlist{

  final int detailid,listid,cityid,prc;
  final String centaddr,centname;

  Centerlist(this.detailid, this.listid, this.cityid, this.centname, this.centaddr, this.prc){}

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'detailid': detailid,
      'listid': listid,
      'cityid': cityid,
      'centname': centname,
      'centaddr': centaddr,
      'prc': prc,
    };
    return map;
  }

  Centerlist.fromMap(Map<String, dynamic> map)
      : this.detailid = map['detailid'],
        this.listid = map['listid'],
        this.cityid = map['cityid'],
        this.centname = map['centname'],
        this.centaddr = map['centaddr'],
        this.prc = map['prc'];

}