import 'dart:ui';
import 'package:transfer_market/core/model/club_model.dart';

List<ClubModel> clubs = [
  ClubModel(
    index: 0,
    id: 47,
    name: 'Premier League',
    country: 'England',
    color: const Color(0xFF3d195b),
    logo: 'assets/images/epl.png',
  ),
  ClubModel(
    index: 1,
    id: 53,
    name: 'Ligue 1',
    country: 'France',
    color: const Color(0xFFcefb0a),
    secondarColor: const Color(0xFF091c3d),
    logo: 'assets/images/ligue-1.png',
  ),
  ClubModel(
    index: 2,
    id: 87,
    name: 'Laliga',
    country: 'Spain',
    color: const Color(0xFFf84c45),
    logo: 'assets/images/laliga.png',
  ),
  ClubModel(
    index: 3,
    id: 54,
    name: 'Bundesliga',
    country: 'Germany',
    color: const Color(0xFFFFFFFF),
    secondarColor: const Color(0xFFcf1118),
    logo: 'assets/images/bundesliga.png',
  ),
  ClubModel(
    index: 4,
    id: 55,
    name: 'Serie A',
    country: 'Italy',
    color: const Color(0xFF008ed6),
    logo: 'assets/images/serie-a.png',
  ),
];
