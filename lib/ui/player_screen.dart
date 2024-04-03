import 'package:flutter/material.dart';
import 'package:tcard/tcard.dart';
import 'package:transfer_market/core/model/club_model.dart';

class PlayerScreen extends StatefulWidget {
  final ClubModel club;
  const PlayerScreen({super.key, required this.club});

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  final TCardController _controller = TCardController();
  int index = 0;

  Widget _card() {
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
          const Expanded(
            child: Column(
              children: [
                Text(
                  'FREE TRANSFER',
                  style: TextStyle(
                    fontSize: 30,
                    color: Color(0xFF091c3d),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Stack(
            children: [
              Center(
                child: Image.asset(
                  widget.club.logo!,
                  opacity: const AlwaysStoppedAnimation(.3),
                ),
              ),
              Center(
                child: Image.network(
                  'https://resources.premierleague.com/premierleague/photos/players/250x250/p223094.png',
                  height: 270,
                ),
              )
            ],
          ),
          Container(
            height: 70,
            width: 500,
            decoration: BoxDecoration(
              color: Colors.white70,
              border: Border(
                top: BorderSide(
                    width: 1.5,
                    color: widget.club.secondarColor ?? widget.club.color),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.network(
                  'https://resources.premierleague.com/premierleague/badges/100/t1@x2.png',
                  height: 50,
                ),
                const Icon(Icons.arrow_forward_ios_rounded),
                const Icon(Icons.arrow_forward_ios_rounded),
                Image.network(
                  'https://resources.premierleague.com/premierleague/badges/100/t43@x2.png',
                  height: 50,
                ),
              ],
            ),
          ),
          Container(
            height: 70,
            width: 500,
            decoration: BoxDecoration(
              color: widget.club.secondarColor ?? widget.club.color,
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
                  'Erling Haaland',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: widget.club.secondarColor != null
                        ? widget.club.color
                        : Colors.white,
                  ),
                ),
                Text(
                  '£300',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: widget.club.secondarColor != null
                        ? widget.club.color
                        : Colors.white,
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
    return Scaffold(
      body: ListView(
        children: [
          Center(
            child: Text(
              widget.club.name,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Center(
            child: Text(
              widget.club.country,
            ),
          ),
          // const SizedBox(height: 30),
          TCard(
            cards: List.generate(
              5,
              (int index) {
                return _card();
              },
            ),
            size: const Size(380, 550),
            controller: _controller,
            onForward: (index, info) {
              index = index;
              // print(info.direction);
              setState(() {});
            },
            onBack: (index, info) {
              index = index;
              setState(() {});
            },
            onEnd: () {},
          ),
          const SizedBox(height: 20),
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
        ],
      ),
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
}
