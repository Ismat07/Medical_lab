class CitySelecter{
  final String cityname;
  final int cityid;

  CitySelecter(this.cityid, this.cityname);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'cityid': cityid,
      'cityname': cityname,
    };
    return map;
  }

  CitySelecter.fromMap(Map<String, dynamic> map)
      : this.cityname = map['cityname'],
        this.cityid = map['cityid'];

}