class Center{

  final int centid,cityid;
  final String centname;

  Center(this.centid,this.cityid, this.centname){}

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'centid': centid,
      'cityid': cityid,
      'centname': centname,
    };
    return map;
  }

  Center.fromMap(Map<String, dynamic> map)
      :this.centid = map['centid'],
        this.cityid = map['cityid'],
        this.centname = map['centname'];



}