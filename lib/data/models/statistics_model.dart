class Statistics {
  bool error;
  int statusCode;
  String message;
  Data data;

  Statistics({
    this.error,
    this.statusCode,
    this.message,
    this.data,
  });

  Statistics.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    statusCode = json['statusCode'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.error;
    data['statusCode'] = this.statusCode;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  String lastChecked;
  List<Covid19Stats> covid19Stats;

  Data({this.lastChecked, this.covid19Stats});

  Data.fromJson(Map<String, dynamic> json) {
    lastChecked = json['lastChecked'];
    if (json['covid19Stats'] != null) {
      covid19Stats = new List<Covid19Stats>();
      json['covid19Stats'].forEach((v) {
        covid19Stats.add(new Covid19Stats.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lastChecked'] = this.lastChecked;
    if (this.covid19Stats != null) {
      data['covid19Stats'] = this.covid19Stats.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Covid19Stats {
  String province;
  String country;
  String lastUpdate;
  int confirmed;
  int deaths;
  int recovered;

  Covid19Stats({
    this.province,
    this.country,
    this.lastUpdate,
    this.confirmed,
    this.deaths,
    this.recovered,
  });

  Covid19Stats.fromJson(Map<String, dynamic> json) {
    province = json['province'];
    country = json['country'];
    lastUpdate = json['lastUpdate'];
    confirmed = json['confirmed'];
    deaths = json['deaths'];
    recovered = json['recovered'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['province'] = this.province;
    data['country'] = this.country;
    data['lastUpdate'] = this.lastUpdate;
    data['confirmed'] = this.confirmed;
    data['deaths'] = this.deaths;
    data['recovered'] = this.recovered;
    return data;
  }
}
