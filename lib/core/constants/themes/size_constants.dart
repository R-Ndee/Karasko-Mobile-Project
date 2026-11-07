import 'package:flutter/widgets.dart';

class BaseSize {
  BaseSize._();

  static const double s2 = 2;
  static const double s4 = 4;
  static const double s6 = 6;
  static const double s8 = 8;
  static const double s10 = 10;
  static const double s12 = 12;
  static const double s14 = 14;
  static const double s16 = 16;
  static const double s18 = 18;
  static const double s20 = 20;
  static const double s24 = 24;
  static const double s28 = 28;
  static const double s32 = 32;
  static const double s36 = 36;
  static const double s40 = 40;
  static const double s48 = 48;
  static const double s56 = 56;
  static const double s64 = 64;
  static const double s72 = 72;
  static const double s80 = 80;
}

class Gap {
  Gap._();

  static const SizedBox h2 = SizedBox(height: BaseSize.s2);
  static const SizedBox h4 = SizedBox(height: BaseSize.s4);
  static const SizedBox h6 = SizedBox(height: BaseSize.s6);
  static const SizedBox h8 = SizedBox(height: BaseSize.s8);
  static const SizedBox h10 = SizedBox(height: BaseSize.s10);
  static const SizedBox h12 = SizedBox(height: BaseSize.s12);
  static const SizedBox h14 = SizedBox(height: BaseSize.s14);
  static const SizedBox h16 = SizedBox(height: BaseSize.s16);
  static const SizedBox h18 = SizedBox(height: BaseSize.s18);
  static const SizedBox h20 = SizedBox(height: BaseSize.s20);
  static const SizedBox h24 = SizedBox(height: BaseSize.s24);
  static const SizedBox h28 = SizedBox(height: BaseSize.s28);
  static const SizedBox h32 = SizedBox(height: BaseSize.s32);
  static const SizedBox h36 = SizedBox(height: BaseSize.s36);
  static const SizedBox h40 = SizedBox(height: BaseSize.s40);
  static const SizedBox h48 = SizedBox(height: BaseSize.s48);
  static const SizedBox h56 = SizedBox(height: BaseSize.s56);
  static const SizedBox h64 = SizedBox(height: BaseSize.s64);
  static const SizedBox h72 = SizedBox(height: BaseSize.s72);
  static const SizedBox h80 = SizedBox(height: BaseSize.s80);

  static const SizedBox w2 = SizedBox(width: BaseSize.s2);
  static const SizedBox w4 = SizedBox(width: BaseSize.s4);
  static const SizedBox w6 = SizedBox(width: BaseSize.s6);
  static const SizedBox w8 = SizedBox(width: BaseSize.s8);
  static const SizedBox w10 = SizedBox(width: BaseSize.s10);
  static const SizedBox w12 = SizedBox(width: BaseSize.s12);
  static const SizedBox w14 = SizedBox(width: BaseSize.s14);
  static const SizedBox w16 = SizedBox(width: BaseSize.s16);
  static const SizedBox w18 = SizedBox(width: BaseSize.s18);
  static const SizedBox w20 = SizedBox(width: BaseSize.s20);
  static const SizedBox w24 = SizedBox(width: BaseSize.s24);
  static const SizedBox w28 = SizedBox(width: BaseSize.s28);
  static const SizedBox w32 = SizedBox(width: BaseSize.s32);
  static const SizedBox w36 = SizedBox(width: BaseSize.s36);
  static const SizedBox w40 = SizedBox(width: BaseSize.s40);
  static const SizedBox w48 = SizedBox(width: BaseSize.s48);
  static const SizedBox w56 = SizedBox(width: BaseSize.s56);
  static const SizedBox w64 = SizedBox(width: BaseSize.s64);
  static const SizedBox w72 = SizedBox(width: BaseSize.s72);
  static const SizedBox w80 = SizedBox(width: BaseSize.s80);

  static SizedBox customHeight(double value) => SizedBox(height: value);
  static SizedBox customWidth(double value) => SizedBox(width: value);
}
