class Log {

  final int id;
  final String mobil;

  Log(this.id, this.mobil){}

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'mobil': mobil,
    };
    return map;
  }

  Log.fromMap(Map<String, dynamic> map)
      : this.mobil = map['mobil'],
        this.id = map['id'];


}
