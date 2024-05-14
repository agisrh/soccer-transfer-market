class TableModel {
  final String name;
  final String shortName;
  final int id;
  final int played;
  final int wins;
  final int draws;
  final int losses;
  final String scoresStr;
  final int goalConDiff;
  final int pts;
  final int idx;
  String? qualColor;

  TableModel({
    required this.name,
    required this.shortName,
    required this.id,
    required this.played,
    required this.wins,
    required this.draws,
    required this.losses,
    required this.scoresStr,
    required this.goalConDiff,
    required this.pts,
    required this.idx,
    this.qualColor,
  });

  static TableModel fromJson(Map<String, dynamic> json) {
    return TableModel(
      name: json["name"],
      shortName: json["shortName"],
      id: json["id"],
      played: json["played"],
      wins: json["wins"],
      draws: json["draws"],
      losses: json["losses"],
      scoresStr: json["scoresStr"],
      goalConDiff: json["goalConDiff"],
      pts: json["pts"],
      idx: json["idx"],
      qualColor: json["qualColor"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "shortName": shortName,
      "id": id,
      "played": played,
      "wins": wins,
      "draws": draws,
      "losses": losses,
      "scoresStr": scoresStr,
      "goalConDiff": goalConDiff,
      "pts": pts,
      "idx": idx,
      "qualColor": qualColor,
    };
  }

  static List<TableModel> fromJsonList(List list) {
    return list.map((item) => TableModel.fromJson(item)).toList();
  }
}
