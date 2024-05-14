class MatchModel {
  MatchModel({
    required this.round,
    required this.roundName,
    required this.pageUrl,
    required this.id,
    required this.home,
    required this.away,
    required this.status,
  });
  late final String round;
  late final int roundName;
  late final String pageUrl;
  late final String id;
  late final Home home;
  late final Away away;
  late final Status status;

  MatchModel.fromJson(Map<String, dynamic> json) {
    round = json['round'];
    roundName = json['roundName'];
    pageUrl = json['pageUrl'];
    id = json['id'];
    home = Home.fromJson(json['home']);
    away = Away.fromJson(json['away']);
    status = Status.fromJson(json['status']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['round'] = round;
    _data['roundName'] = roundName;
    _data['pageUrl'] = pageUrl;
    _data['id'] = id;
    _data['home'] = home.toJson();
    _data['away'] = away.toJson();
    _data['status'] = status.toJson();
    return _data;
  }

  static List<MatchModel> fromJsonList(List list) {
    return list.map((item) => MatchModel.fromJson(item)).toList();
  }
}

class Home {
  Home({
    required this.name,
    required this.shortName,
    required this.id,
  });
  late final String name;
  late final String shortName;
  late final String id;

  Home.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    shortName = json['shortName'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['name'] = name;
    _data['shortName'] = shortName;
    _data['id'] = id;
    return _data;
  }
}

class Away {
  Away({
    required this.name,
    required this.shortName,
    required this.id,
  });
  late final String name;
  late final String shortName;
  late final String id;

  Away.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    shortName = json['shortName'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['name'] = name;
    _data['shortName'] = shortName;
    _data['id'] = id;
    return _data;
  }
}

class Status {
  Status({
    required this.utcTime,
    required this.finished,
    required this.started,
    required this.cancelled,
    required this.scoreStr,
    //required this.reason,
  });
  late final String utcTime;
  late final bool finished;
  late final bool started;
  late final bool cancelled;
  String? scoreStr;
  Reason? reason;

  Status.fromJson(Map<String, dynamic> json) {
    utcTime = json['utcTime'];
    finished = json['finished'];
    started = json['started'];
    cancelled = json['cancelled'];
    scoreStr = json['scoreStr'];
    reason = json['reason'] != null ? Reason.fromJson(json['reason']) : null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['utcTime'] = utcTime;
    _data['finished'] = finished;
    _data['started'] = started;
    _data['cancelled'] = cancelled;
    _data['scoreStr'] = scoreStr;
    _data['reason'] = reason?.toJson();
    return _data;
  }
}

class Reason {
  Reason({
    required this.short,
    required this.shortKey,
    required this.long,
    required this.longKey,
  });
  late final String short;
  late final String shortKey;
  late final String long;
  late final String longKey;

  Reason.fromJson(Map<String, dynamic> json) {
    short = json['short'];
    shortKey = json['shortKey'];
    long = json['long'];
    longKey = json['longKey'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['short'] = short;
    _data['shortKey'] = shortKey;
    _data['long'] = long;
    _data['longKey'] = longKey;
    return _data;
  }
}
