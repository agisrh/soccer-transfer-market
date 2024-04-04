import 'package:flutter_xcore/app_core.dart';
import 'package:transfer_market/core/model/transfer_model.dart';
import 'package:transfer_market/core/repository/transfer_repo.dart';

class HomeController extends BaseController {
  List<TransferModel> transferList = [];
  int indexTab = 0;
  bool loading = false;

  Future<void> getTransfers({required int leagueId}) async {
    loading = true;
    var result = await TransferRepo.getTransfer(leagueId: leagueId);
    loading = false;
    transferList = TransferModel.fromJsonList(result.data['transfers']);
    // if (result.success == true) {
    //   checklistData = result.checklists;
    // }
    update();
  }
}
