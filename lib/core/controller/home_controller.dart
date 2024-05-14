import 'package:flutter_xcore/app_core.dart';
import 'package:transfer_market/core/model/match_model.dart';
import 'package:transfer_market/core/model/table_model.dart';
import 'package:transfer_market/core/model/transfer_model.dart';
import 'package:transfer_market/core/repository/repository.dart';

class HomeController extends BaseController {
  List<TransferModel> transferList = [];
  List<TableModel> statistics = [];
  List<MatchModel> mathces = [];
  int indexTab = 0;
  int indexTabStat = 0;
  int indexTabMatch = 0;
  bool loading = false;
  bool loadingStats = false;

  Future<void> getTransfers({required int leagueId}) async {
    loading = true;
    var result = await Repository.getTransfer(leagueId: leagueId);
    loading = false;
    transferList = TransferModel.fromJsonList(result.data['transfers']);
    // if (result.success == true) {
    //   checklistData = result.checklists;
    // }
    update();
  }

  Future<void> getTable({required int leagueId}) async {
    loadingStats = true;
    var result = await Repository.getTable(leagueId: leagueId);
    loadingStats = false;
    statistics =
        TableModel.fromJsonList(result.data[0]['data']['table']['all']);
    update();
  }

  Future<void> getLeague({required int leagueId}) async {
    loadingStats = true;
    var result = await Repository.getLeague(leagueId: leagueId);
    loadingStats = false;
    // TODO
    //print(result.data['matches']);
    // print(result.data['matches']['allMatches']);
    mathces = MatchModel.fromJsonList(result.data['matches']['allMatches']);
    update();
  }
}
