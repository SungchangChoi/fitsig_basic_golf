import 'package:fitsig_basic_golf/F0_BASIC/common_import.dart';

//==============================================================================
// basic theme
//==============================================================================

class BasicTheme {
  //----------------------------------------------------------------------------
  // color map
  // 사용되는 컬러 수가 많지 않아, 기본디자인 컬러로 지정
  // 스킨을 변경할 때는 기본 디자인과 비교하여 정의
  //----------------------------------------------------------------------------
  Color green01 = const Color.fromARGB(255, 36, 142, 72); //운동량 바에서 1RM 표시 점선
  Color grey05 = const Color.fromARGB(255, 80, 80, 80); // 도움말 글씨
  Color fixedGrey01 = const Color.fromARGB(255, 0xfa, 0xfa, 0xfa); // "운동 기록 확인", "운동시작"
  Color fixedBlack = const Color.fromARGB(255, 0x32, 0x32, 0x32);
  Color fixedWhite = const Color.fromARGB(255, 0xff, 0xff, 0xff); // "운동 기록 확인", "운동시작"

  // 새로 정의한 색상 추가 (A 타입 밝은 테마. 2023.03.29)
  Color red = const Color.fromARGB(255, 0xff, 0x3c, 0x3c); // 알람 문구
  Color yellow = const Color.fromARGB(255, 0xff, 0xc1, 0x07);
  Color pointOrange = const Color.fromARGB(255, 0xff, 0x60, 0x2E);
  Color mainGreen = const Color.fromARGB(255, 0x5f, 0xdc, 0x8c);
  Color softBlue = const Color.fromARGB(255, 0xdc, 0xea, 0xff);
  Color pointBlue = const Color.fromARGB(255, 0x19, 0x6e, 0xff);
  Color mainBlue = const Color.fromARGB(255, 0x50, 0x96, 0xff);
  Color background = const Color.fromARGB(255, 0xff, 0xff, 0xff);
  Color black = const Color.fromARGB(255, 0x32, 0x32, 0x32);
  Color grey04 = const Color.fromARGB(255, 0x64, 0x64, 0x64);
  Color grey03 = const Color.fromARGB(255, 0xb4, 0xb4, 0xb4);
  Color grey02 = const Color.fromARGB(255, 0xf0, 0xf0, 0xf0);
  Color grey01 = const Color.fromARGB(255, 0xfa, 0xfa, 0xfa);
  Color white = const Color.fromARGB(255, 0xff, 0xff, 0xff);

  //----------------------------------------------------------------------------
  // font size
  //----------------------------------------------------------------------------
  double s300 = 300 * gv.setting.fontScale + gv.setting.bigFontAddVal;
  double s200 = 200 * gv.setting.fontScale + gv.setting.bigFontAddVal;
  double s100 = 100 * gv.setting.fontScale + gv.setting.bigFontAddVal;
  double s67 = 67 * gv.setting.fontScale + gv.setting.bigFontAddVal;
  double s50 = 50 * gv.setting.fontScale + gv.setting.bigFontAddVal;
  double s40 = 40 * gv.setting.fontScale + gv.setting.bigFontAddVal;
  double s30 =
      30 * gv.setting.fontScale + gv.setting.bigFontAddVal; // 매우 큰 폰트 크기
  double s28 =
      28 * gv.setting.fontScale + gv.setting.bigFontAddVal; // 매우 큰 폰트 크기
  double s24 = 24 * gv.setting.fontScale + gv.setting.bigFontAddVal;
  double s20 = 20 * gv.setting.fontScale + gv.setting.bigFontAddVal; // 큰 폰트 크기
  double s18 = 18 * gv.setting.fontScale + gv.setting.bigFontAddVal; // 기본 폰트 크기
  double s16 = 16 * gv.setting.fontScale + gv.setting.bigFontAddVal; // 작은 폰트 크기
  double s15 = 15 * gv.setting.fontScale + gv.setting.bigFontAddVal;
  double s14 =
      14 * gv.setting.fontScale + gv.setting.bigFontAddVal; // 매우 작은 폰트 크기
  double s12 = 12 * gv.setting.fontScale + gv.setting.bigFontAddVal;
  double s10 = 10 * gv.setting.fontScale + gv.setting.bigFontAddVal;
  double s6 = 6 * gv.setting.fontScale + gv.setting.bigFontAddVal;

  //----------------------------------------------------------------------------
  // 공통 테마 - 사이즈
  //----------------------------------------------------------------------------
  void convertFontSize() {
    s300 = 300 * gv.setting.fontScale + gv.setting.bigFontAddVal;
    s200 = 200 * gv.setting.fontScale + gv.setting.bigFontAddVal;
    s100 = 100 * gv.setting.fontScale + gv.setting.bigFontAddVal;
    s67 = 67 * gv.setting.fontScale + gv.setting.bigFontAddVal;
    s40 = 40 * gv.setting.fontScale + gv.setting.bigFontAddVal;
    s30 =
        30 * gv.setting.fontScale + gv.setting.bigFontAddVal; // 매우 큰 폰트 크기
    s28 =
        28 * gv.setting.fontScale + gv.setting.bigFontAddVal; // 매우 큰 폰트 크기
    s24 = 24 * gv.setting.fontScale + gv.setting.bigFontAddVal;
    s20 = 20 * gv.setting.fontScale + gv.setting.bigFontAddVal; // 큰 폰트 크기
    s18 = 18 * gv.setting.fontScale + gv.setting.bigFontAddVal; // 기본 폰트 크기
    s16 = 16 * gv.setting.fontScale + gv.setting.bigFontAddVal; // 작은 폰트 크기
    s15 = 15 * gv.setting.fontScale + gv.setting.bigFontAddVal;
    s14 =
        14 * gv.setting.fontScale + gv.setting.bigFontAddVal; // 매우 작은 폰트 크기
    s12 = 12 * gv.setting.fontScale + gv.setting.bigFontAddVal;
    s10 = 10 * gv.setting.fontScale + gv.setting.bigFontAddVal;
    s6 = 6 * gv.setting.fontScale + gv.setting.bigFontAddVal;
  }
}
