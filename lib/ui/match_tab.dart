import 'package:flutter/material.dart';
import 'package:flutter_xcore/export_helper.dart';
import 'package:transfer_market/core/controller/home_controller.dart';
import 'package:transfer_market/core/data/club_data.dart';
import 'package:transfer_market/ui/match_screen.dart';
import '../core/controller/feature_controller.dart';

class MatchTab extends StatelessWidget with WidgetsBindingObserver {
  const MatchTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var ui = DefaultTabController(
      length: 4,
      child: GetBuilder(
        init: MyController.homeController,
        initState: (state) {
          WidgetsBinding.instance.addPostFrameCallback((_) async {
            await MyController.homeController.getLeague(leagueId: clubs[0].id);
          });
        },
        builder: (HomeController controller) {
          return Scaffold(
            appBar: AppBar(
              title: const Text(
                'MATCHES',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            body: DefaultTabController(
              length: 5,
              child: Column(
                children: [
                  SizedBox(
                    height: 150,
                    child: HomeTabBar(controller: controller),
                  ),
                  const Expanded(
                    child: TabBarView(
                      physics: NeverScrollableScrollPhysics(),
                      children: <Widget>[
                        MatchScreen(),
                        MatchScreen(),
                        MatchScreen(),
                        MatchScreen(),
                        MatchScreen(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
    return ui;
  }
}

class HomeTabBar extends StatefulWidget {
  const HomeTabBar({Key? key, required this.controller}) : super(key: key);
  final HomeController controller;

  @override
  State<HomeTabBar> createState() => _HomeTabBarState();
}

class _HomeTabBarState extends State<HomeTabBar> {
  @override
  Widget build(BuildContext context) {
    TabController? tabController = DefaultTabController.of(context);
    tabController.addListener(() {
      setState(() {
        widget.controller.indexTabMatch = tabController.index;
        widget.controller.update();
      });
    });
    return SizedBox(
      height: 150,
      child: TabBar(
        controller: tabController,
        isScrollable: true,
        indicatorColor: Colors.transparent,
        splashFactory: NoSplash.splashFactory,
        dividerColor: Colors.transparent,
        overlayColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
          return states.contains(MaterialState.focused)
              ? null
              : Colors.transparent;
        }),
        tabs: clubs.map((e) {
          return AnimatedContainer(
            width: tabController.index == e.index ? 100 : 75,
            height: tabController.index == e.index ? 100 : 75,
            decoration: BoxDecoration(
              color: e.secondarColor ?? e.color.withOpacity(0.4),
              borderRadius: const BorderRadius.all(Radius.circular(20.0)),
            ),
            duration: const Duration(milliseconds: 500),
            curve: Curves.fastOutSlowIn,
            child: Icon(
              Icons.sports_soccer_rounded,
              size: tabController.index == e.index ? 50 : 30,
              color: e.color,
            ),
          );
        }).toList(),
      ),
    );
  }
}
