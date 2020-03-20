class BrazilStatistics {
  List<Data> data;

  BrazilStatistics({this.data});

  BrazilStatistics.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int uid;
  String uf;
  String state;
  int cases;
  int deaths;
  int suspects;
  int refuses;
  bool broadcast;
  String comments;
  String datetime;

  Data({
    this.uid,
    this.uf,
    this.state,
    this.cases,
    this.deaths,
    this.suspects,
    this.refuses,
    this.broadcast,
    this.comments,
    this.datetime,
  });

  Data.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    uf = json['uf'];
    state = json['state'];
    cases = json['cases'];
    deaths = json['deaths'];
    suspects = json['suspects'];
    refuses = json['refuses'];
    broadcast = json['broadcast'];
    comments = json['comments'];
    datetime = json['datetime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = this.uid;
    data['uf'] = this.uf;
    data['state'] = this.state;
    data['cases'] = this.cases;
    data['deaths'] = this.deaths;
    data['suspects'] = this.suspects;
    data['refuses'] = this.refuses;
    data['broadcast'] = this.broadcast;
    data['comments'] = this.comments;
    data['datetime'] = this.datetime;
    return data;
  }
}
