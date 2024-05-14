import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_xcore/app_core.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:tcard/tcard.dart';
import 'package:transfer_market/core/controller/feature_controller.dart';
import 'package:transfer_market/core/controller/home_controller.dart';
import 'package:transfer_market/core/data/club_data.dart';
import 'package:transfer_market/core/model/club_model.dart';
import 'package:transfer_market/core/model/transfer_model.dart';
import 'package:transfer_market/ui/utils/helper.dart';

class PlayerScreen extends StatefulWidget {
  final HomeController dataController;
  const PlayerScreen({super.key, required this.dataController});

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  final TCardController _controller = TCardController();
  final scController = ScreenshotController();

  Widget _card({required ClubModel club, required TransferModel player}) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        border: Border.all(color: Colors.white, width: 0.5),
        image: const DecorationImage(
          image: AssetImage("assets/images/bg-texture.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        children: [
          const SizedBox(height: 15.0),
          Expanded(
              child: textWithStroke(
            text: player.fee?.value != null
                ? '£${NumberFormat.compact().format(player.fee!.value)}'
                : player.transferType.text.toUpperCase(),
            strokeWidth: 3,
            fontSize: 30,
            strokeColor: club.secondarColor ?? club.color,
          )

              // Text(
              //   player.transferType.text.toUpperCase(),
              //   style: const TextStyle(
              //     fontSize: 30,
              //     color: Color(0xFF091c3d),
              //     fontWeight: FontWeight.bold,
              //   ),
              // ),

              ),
          Stack(
            children: [
              Center(
                child: Icon(
                  Icons.sports_soccer_rounded,
                  size: 280,
                  color: club.color.withOpacity(0.2),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 20),
                child: Column(
                  children: [
                    _textInfo(title: 'Name', text: player.name),
                    _textInfo(
                        title: 'Position', text: player.position?.label ?? "-"),
                    _textInfo(title: 'From', text: player.fromClub),
                    _textInfo(title: 'To', text: player.toClub),
                    _textInfo(
                      title: 'Start',
                      text: StringHelper.shortDate(date: player.fromDate),
                    ),
                    if (player.toDate != null)
                      _textInfo(
                        title: 'End',
                        text: StringHelper.shortDate(date: player.toDate!),
                      ),
                  ],
                ),
              ),
              // Center(
              //   child: Image.asset(
              //     club.logo!,
              //     opacity: const AlwaysStoppedAnimation(.3),
              //   ),
              // ),
              // Center(
              //   child: Image.network(
              //     'https://resources.premierleague.com/premierleague/photos/players/250x250/p223094.png',
              //     height: 270,
              //   ),
              // )
            ],
          ),
          Container(
            height: 70,
            width: 500,
            decoration: BoxDecoration(
              color: club.secondarColor ?? club.color,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  player.name,
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color:
                        club.secondarColor != null ? club.color : Colors.white,
                  ),
                ),
                Text(
                  'Market Value : £${NumberFormat.compact().format(player.marketValue)}',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color:
                        club.secondarColor != null ? club.color : Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ClubModel club = clubs[widget.dataController.indexTab];

    return GetBuilder(
      init: MyController.homeController,
      initState: (state) {
        WidgetsBinding.instance.addPostFrameCallback((_) async {
          await MyController.homeController.getTransfers(leagueId: club.id);
          setState(() {});
        });
      },
      builder: (HomeController controller) {
        return Scaffold(
          body: ListView(
            children: [
              Center(
                child: Text(
                  club.name,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Center(
                child: Text(
                  club.country,
                ),
              ),
              // const SizedBox(height: 30),
              if (controller.loading == false &&
                  controller.transferList.isNotEmpty)
                TCard(
                  cards: List.generate(
                    controller.transferList.length,
                    (int index) {
                      return _card(
                        club: club,
                        player: controller.transferList[index],
                      );
                    },
                  ),
                  size: const Size(380, 500),
                  controller: _controller,
                  onForward: (index, info) {
                    setState(() {
                      index = index;
                    });
                  },
                  onBack: (index, info) {
                    setState(() {
                      index = index;
                    });
                  },
                  onEnd: () {},
                ),
              if (controller.loading == true)
                const Center(
                  child: SizedBox(
                    height: 30,
                    width: 30,
                    child: CircularProgressIndicator(),
                  ),
                ),
              const SizedBox(height: 20),
              if (controller.loading == false &&
                  controller.transferList.isNotEmpty)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    _button(
                        text: 'Back',
                        onPressed: () {
                          _controller.back();
                        }),
                    _button(
                        text: 'Forward',
                        onPressed: () {
                          _controller.forward();
                        }),
                    _button(
                        text: 'Reset',
                        onPressed: () {
                          _controller.reset();
                        }),
                  ],
                ),
              if (controller.loading == false &&
                  controller.transferList.isNotEmpty)
                Container(
                  margin: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 10.0),
                  child: TextButton(
                    onPressed: () {
                      scController
                          .captureFromWidget(
                        SizedBox(
                          width: 380,
                          height: 500,
                          child: _card(
                              club: club,
                              player:
                                  controller.transferList[_controller.index]),
                        ),
                      )
                          .then((image) async {
                        final directory =
                            await getApplicationDocumentsDirectory();
                        final imagePath =
                            await File('${directory.absolute.path}/image.png')
                                .create();
                        await imagePath.writeAsBytes(image);
                        // ignore: use_build_context_synchronously
                        final box = context.findRenderObject() as RenderBox?;

                        XFile img = XFile(imagePath.path);
                        List<XFile> files = [img];
                        await Share.shareXFiles(
                          files,
                          sharePositionOrigin:
                              box!.localToGlobal(Offset.zero) & box.size,
                        );
                      });
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      //side: BorderSide(color: Colors.grey.shade400),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text(
                      "Share",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _button({required String text, required VoidCallback onPressed}) {
    return SizedBox(
      width: 100,
      child: TextButton(
        onPressed: () {
          onPressed();
        },
        style: TextButton.styleFrom(
          backgroundColor: Colors.white,
          side: BorderSide(color: Colors.grey.shade400),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(color: Colors.black87),
        ),
      ),
    );
  }

  Widget _textInfo({required String title, required String text}) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 100,
              child: Text(
                title,
                style: const TextStyle(fontSize: 16, color: Colors.black),
              ),
            ),
            const SizedBox(
              width: 20,
              child: Text(
                ':',
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
            ),
            Text(
              text,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ],
        ),
        const SizedBox(height: 5),
      ],
    );
  }
}
