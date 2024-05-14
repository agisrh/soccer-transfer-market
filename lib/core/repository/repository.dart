import 'package:flutter_xcore/app_core.dart';
import 'package:transfer_market/core/config/environment.dart';

class Repository {
  static ApiService apiv1 = ApiService(EnvironmentConfig.baseUrl());

  static Future<dynamic> getTransfer(
      {required int leagueId, String page = '1'}) async {
    var result = await apiv1.call(
      "transfers?leagueIds=$leagueId&page=$page",
      method: MethodRequest.GET,
    );

    return result;
  }

  static Future<dynamic> getTable({required int leagueId}) async {
    var result = await apiv1.call(
      "tltable?leagueId=$leagueId",
      method: MethodRequest.GET,
    );

    return result;
  }

  static Future<dynamic> getLeague({required int leagueId}) async {
    var result = await apiv1.call(
      "leagues?id=$leagueId",
      method: MethodRequest.GET,
    );

    return result;
  }
}
