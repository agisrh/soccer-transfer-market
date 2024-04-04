class TransferModel {
  TransferModel({
    required this.name,
    required this.playerId,
    this.position,
    required this.transferDate,
    required this.fromClub,
    required this.fromClubId,
    required this.toClub,
    required this.toClubId,
    this.fee,
    required this.transferType,
    required this.contractExtension,
    required this.onLoan,
    required this.fromDate,
    required this.toDate,
    this.marketValue,
  });
  late final String name;
  late final int playerId;
  Position? position;
  late final String transferDate;
  late final String fromClub;
  late final int fromClubId;
  late final String toClub;
  late final int toClubId;
  Fee? fee;
  late final TransferType transferType;
  late final bool contractExtension;
  late final bool onLoan;
  late final String fromDate;
  String? toDate;
  int? marketValue;

  TransferModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    playerId = json['playerId'];
    position =
        json['position'] != null ? Position.fromJson(json['position']) : null;
    transferDate = json['transferDate'];
    fromClub = json['fromClub'];
    fromClubId = json['fromClubId'];
    toClub = json['toClub'];
    toClubId = json['toClubId'];
    fee = json['fee'] != null ? Fee.fromJson(json['fee']) : null;
    transferType = TransferType.fromJson(json['transferType']);
    contractExtension = json['contractExtension'];
    onLoan = json['onLoan'];
    fromDate = json['fromDate'];
    toDate = json['toDate'];
    marketValue = json['marketValue'] ?? 0;
  }

  static List<TransferModel> fromJsonList(List list) {
    return list.map((item) => TransferModel.fromJson(item)).toList();
  }
}

class Position {
  Position({
    required this.label,
    required this.key,
  });
  late final String label;
  late final String key;

  Position.fromJson(Map<String, dynamic> json) {
    label = json['label'];
    key = json['key'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['label'] = label;
    data['key'] = key;
    return data;
  }
}

class Fee {
  Fee({
    required this.feeText,
    required this.localizedFeeText,
    this.value,
  });
  late final String feeText;
  late final String localizedFeeText;
  int? value;

  Fee.fromJson(Map<String, dynamic> json) {
    feeText = json['feeText'];
    localizedFeeText = json['localizedFeeText'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['feeText'] = feeText;
    data['localizedFeeText'] = localizedFeeText;
    return data;
  }
}

class TransferType {
  TransferType({
    required this.text,
    required this.localizationKey,
  });
  late final String text;
  late final String localizationKey;

  TransferType.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    localizationKey = json['localizationKey'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['text'] = text;
    data['localizationKey'] = localizationKey;
    return data;
  }
}
