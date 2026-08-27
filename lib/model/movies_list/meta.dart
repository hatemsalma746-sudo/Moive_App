/// api_version : 2
/// execution_time : "0.01 ms"

class Meta {
  Meta({this.apiVersion, this.executionTime});

  Meta.fromJson(dynamic json) {
    apiVersion = json['api_version'];
    executionTime = json['execution_time'];
  }

  int? apiVersion;
  String? executionTime;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['api_version'] = apiVersion;
    map['execution_time'] = executionTime;
    return map;
  }
}
