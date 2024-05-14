import 'package:flutter/material.dart';
import 'package:flutter_xcore/app_core.dart';
import 'package:transfer_market/core/controller/home_controller.dart';
import 'package:transfer_market/core/data/club_data.dart';
import 'package:transfer_market/core/model/club_model.dart';
import 'package:transfer_market/core/model/match_model.dart';
import 'package:transfer_market/ui/utils/helper.dart';
import '../core/controller/feature_controller.dart';

class MatchScreen extends StatelessWidget {
  const MatchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ClubModel club = clubs[MyController.homeController.indexTabMatch];
    return GetBuilder(
      init: MyController.homeController,
      initState: (state) {
        WidgetsBinding.instance.addPostFrameCallback((_) async {
          await MyController.homeController.getLeague(leagueId: club.id);
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
            const SizedBox(height: 30),
            (controller.loadingStats && controller.mathces.isEmpty)
                ? const Center(child: CircularProgressIndicator())
                : Expanded(
                    child: ListView.separated(
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 10),
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.only(left: 5),
                      itemCount: controller.mathces.length,
                      itemBuilder: (BuildContext context, int index) {
                        MatchModel data = controller.mathces[index];
                        return Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(5)),
                          ),
                          child: ListTile(
                            leading: Text(
                              data.status.reason?.short ?? "",
                              style: const TextStyle(fontSize: 14),
                            ),
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  data.home.shortName,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  data.away.shortName,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            subtitle: Text(
                              StringHelper.shortDate(date: data.status.utcTime),
                              style: const TextStyle(fontSize: 12),
                            ),
                            trailing: Text(
                              data.status.scoreStr ?? "",
                              style: const TextStyle(fontSize: 14),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
          ],
        );
      },
    );
  }
}
