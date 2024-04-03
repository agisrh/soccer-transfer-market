import 'package:flutter/material.dart';
import 'package:transfer_market/core/data/club_data.dart';
import 'package:transfer_market/core/model/club_model.dart';
import 'package:transfer_market/ui/player_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  late final tabController = TabController(length: 5, vsync: this)
    ..animation?.addListener(() => setState(() {}));

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: DefaultTabController(
          length: 5,
          child: Column(
            children: [
              SizedBox(
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
                    return _tabItem(data: e);
                  }).toList(),
                ),
              ),
              Expanded(
                child: TabBarView(
                  physics: const NeverScrollableScrollPhysics(),
                  children: <Widget>[
                    PlayerScreen(club: clubs[tabController.index]),
                    PlayerScreen(club: clubs[tabController.index]),
                    PlayerScreen(club: clubs[tabController.index]),
                    PlayerScreen(club: clubs[tabController.index]),
                    PlayerScreen(club: clubs[tabController.index]),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _tabItem({required ClubModel data}) {
    int currentIndex = tabController.index;
    return AnimatedContainer(
      width: currentIndex == data.index ? 100 : 75,
      height: currentIndex == data.index ? 100 : 75,
      decoration: BoxDecoration(
        color: data.secondarColor ?? data.color.withOpacity(0.4),
        borderRadius: const BorderRadius.all(Radius.circular(20.0)),
      ),
      duration: const Duration(milliseconds: 500),
      curve: Curves.fastOutSlowIn,
      child: data.logo != null
          ? Container(
              padding: const EdgeInsets.all(15),
              child: Image.asset(data.logo!),
            )
          : Icon(
              Icons.shield,
              size: currentIndex == data.index ? 50 : 30,
              color: data.color,
            ),
    );
  }
}
