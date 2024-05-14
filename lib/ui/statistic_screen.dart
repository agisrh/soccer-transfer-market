import 'package:flutter/material.dart';
import 'package:flutter_xcore/app_core.dart';
import 'package:transfer_market/core/controller/feature_controller.dart';
import 'package:transfer_market/core/controller/home_controller.dart';
import 'package:transfer_market/core/data/club_data.dart';
import 'package:transfer_market/core/model/club_model.dart';
import 'package:transfer_market/core/model/table_model.dart';

class StatisticScreen extends StatelessWidget {
  const StatisticScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ClubModel club = clubs[MyController.homeController.indexTabStat];
    return GetBuilder(
      init: MyController.homeController,
      initState: (state) {
        WidgetsBinding.instance.addPostFrameCallback((_) async {
          await MyController.homeController.getTable(leagueId: club.id);
          //setState(() {});
        });
      },
      builder: (HomeController controller) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Center(
              child: Text(
                club.name,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Center(child: Text(club.country)),
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 20),
              child: Row(
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: Get.width / 2.3,
                          child: const Text(
                            'Club',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.deepPurple,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: Get.width / 2,
                          child: Row(
                            children: [
                              boxPoint('PL', title: true),
                              boxPoint('W', title: true),
                              boxPoint('D', title: true),
                              boxPoint('L', title: true),
                              boxPoint('GD', title: true),
                              boxPoint('PTS', title: true),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Divider(thickness: 1.5),
            controller.loadingStats
                ? const Center(child: CircularProgressIndicator())
                : Expanded(
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.only(left: 5),
                      itemCount: controller.statistics.length,
                      itemBuilder: (BuildContext context, int index) {
                        TableModel data = controller.statistics[index];
                        return Column(
                          children: [
                            Container(
                              decoration: const BoxDecoration(
                                border: Border(
                                  left: BorderSide(
                                    color: Colors.transparent,
                                    width: 3,
                                    style: BorderStyle.solid,
                                  ),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: Get.width / 2.5,
                                    child: Row(
                                      children: [
                                        const SizedBox(width: 8),
                                        Text(
                                          data.shortName,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: Get.width / 2,
                                    child: Row(
                                      children: [
                                        boxPoint(data.played.toString()),
                                        boxPoint(data.wins.toString()),
                                        boxPoint(data.draws.toString()),
                                        boxPoint(data.losses.toString()),
                                        boxPoint(data.goalConDiff.toString()),
                                        boxPoint(data.pts.toString()),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Divider(thickness: 1),
                          ],
                        );
                      },
                    ),
                  ),
          ],
        );
      },
    );
  }

  Widget boxPoint(String value, {bool title = false}) {
    return SizedBox(
      width: 35,
      child: Text(
        value,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontWeight: title ? FontWeight.bold : FontWeight.normal,
          color: Colors.black,
        ),
      ),
    );
  }
}
