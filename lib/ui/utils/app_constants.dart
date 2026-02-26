import 'package:flutter/material.dart';

import 'package:movies/ui/utils/app_assets.dart';

abstract final class AppConstants {
  static const List<String> avatars =[
    AppAssets.gamer1,
    AppAssets.gamer,
    AppAssets.gamer2,
    AppAssets.gamer3,
    AppAssets.gamer4,
    AppAssets.gamer5,
    AppAssets.gamer6,
    AppAssets.gamer7,
    AppAssets.gamer8,
  ];
  static const Color redColor=Color(0xffE82626);
  static String defaultErrorMessage="Something went wrong, please try again later!";

}