import 'package:flutter/material.dart';
import 'package:flutter_xcore/export_helper.dart';
import 'package:transfer_market/ui/home_tab.dart';
import 'package:transfer_market/ui/match_tab.dart';
import 'package:transfer_market/ui/statistics_tab.dart';
import 'package:transfer_market/ui/utils/bottom_navy_bar.dart';
import 'package:app_tracking_transparency/app_tracking_transparency.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Transfer Simulator',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  void changePage(int? index) {
    setState(() {
      _currentIndex = index!;
    });
  }

  Future<void> initPlugin() async {
    // If the system can show an authorization request dialog
    if (await AppTrackingTransparency.trackingAuthorizationStatus ==
        TrackingStatus.notDetermined) {
      // Show a custom explainer dialog before the system dialog
      // ignore: use_build_context_synchronously
      //await showCustomTrackingDialog(context);
      // Wait for dialog popping animation
      await Future.delayed(const Duration(milliseconds: 200));
      // Request system's tracking authorization dialog
      await AppTrackingTransparency.requestTrackingAuthorization();
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized()
        .addPostFrameCallback((_) => initPlugin());
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      const MatchTab(),
      const TransferTab(),
      const StatisticsTab(),
    ];

    return Scaffold(
      body: pages[_currentIndex],
      extendBody: true,
      bottomNavigationBar: BottomNavyBar(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        selectedIndex: _currentIndex,
        showElevation: true,
        itemCornerRadius: 24,
        curve: Curves.easeIn,
        onItemSelected: (index) => setState(() => _currentIndex = index),
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
            icon: const Icon(Icons.sports_soccer),
            title: const Text(
              'Matches',
              style: TextStyle(letterSpacing: 0.5, fontSize: 12),
            ),
            activeColor: Colors.deepPurple,
            inactiveColor: Colors.grey.shade400,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: const Icon(Icons.people),
            title: const Text(
              'Transfer',
              style: TextStyle(letterSpacing: 0.5, fontSize: 12),
            ),
            activeColor: Colors.deepPurple,
            inactiveColor: Colors.grey.shade400,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: const Icon(Icons.bar_chart),
            title: const Text(
              'Statistics',
              style: TextStyle(letterSpacing: 0.5, fontSize: 12),
            ),
            activeColor: Colors.deepPurple,
            inactiveColor: Colors.grey.shade400,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
