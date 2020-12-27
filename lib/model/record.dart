import 'dart:convert';

class Record {
  int id;
  int fasting;
  int pp;
  int date;

  Record({this.id, this.fasting, this.pp, this.date});

  factory Record.fromMap(Map<String, dynamic> json) => new Record(
        id: json["id"],
        fasting: json["fasting"],
        pp: json["pp"],
        date: json["date"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "fasting": fasting,
        "pp": pp,
        "date": date,
      };

//
  @override
  String toString() {
    return 'Record{id: $id, fasting: $fasting, pp: $pp, date: $date}';
  }
}

Record recordFromJson(String str) {
  final jsonData = json.decode(str);
  return Record.fromMap(jsonData);
}

String recordToJson(Record data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}
