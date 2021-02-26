import 'package:flutter/material.dart';

/// Ini adalah class static data atau data yang tidak mungkin berubah, kecuali dirubah sendiri
/// * [baseUrl] berisi halaman url untuk API
/// * [oneSignalKey] berisi key one signal
/// * [screenWidth] berisi nilai lebar ukuran layar hp default
/// * [screenHeight] berisi nilai tinggi ukuran layar hp default
/// * [textColor] berisi warna utama tulisan
/// * [inputColor] berisi warna utama isian
/// * [bgColor] berisi warna main background
/// * [bgColor2] berisi warna secondary background
abstract class StaticData {
  /// [baseUrl] nilai defaultnya adalah `https://tesonline129.herokuapp.com/`
  static String baseUrl = "https://tesonline129.herokuapp.com/";

  /// [oneSignalKey]
  static String oneSignalKey = "246fbd22-450f-4ffb-b5b6-5bc03fbf6046";

  /// [screenWidth] nilai defaultnya adalah `360`
  static double screenWidth = 360;

  /// [screenHeight] nilai defaultnya adalah `640`
  static double screenHeight = 640;

  /// [textColor] nilai defaultnya adalah `#156778`
  static Color textColor = Color(0xFF156778);

  /// [inputColor] nilai defaultnya adalah `#535353`
  static Color inputColor = Color(0xFF535353);

  /// [bgColor] nilai defaultnya adalah `#3A9AD9`
  static Color bgColor = Color(0xFFf1c40f);

  /// [bgColor2] nilai defaultnya adalah `#F8F8F8`
  static Color bgColor2 = Color(0xFFF8F8F8);
}
