import '/F0_BASIC/common_import.dart';

//==============================================================================
// light-blue
//==============================================================================
class SkinColorLightBlue {
  static const Color grey05 = Color.fromARGB(255, 80, 80, 80); // 도움말 글씨

  // 새로 정의한 색상 추가 (A 타입 밝은 테마. 2023.03.29)
  static const Color red = Color.fromARGB(255, 0xff, 0x3c, 0x3c); // 알람 문구
  static const Color yellow =  Color.fromARGB(255, 0xff, 0xc1, 0x07);
  static const Color pointOrange =  Color.fromARGB(255, 0xff, 0x60, 0x2E);
  static const Color mainGreen =  Color.fromARGB(255, 0x5f, 0xdc, 0x8c);
  static const Color softBlue =  Color.fromARGB(255, 0xdc, 0xea, 0xff);
  static const Color pointBlue =  Color.fromARGB(255, 0x19, 0x6e, 0xff);
  static const Color mainBlue =  Color.fromARGB(255, 0x50, 0x96, 0xff);

  static const Color background =  Color.fromARGB(255, 0xff, 0xff, 0xff);
  static const Color black =  Color.fromARGB(255, 0x32, 0x32, 0x32);
  static const Color grey04 = Color.fromARGB(255, 0x64, 0x64, 0x64);
  static const Color grey03 =  Color.fromARGB(255, 0xb4, 0xb4, 0xb4);
  static const Color grey02 = Color.fromARGB(255, 0xf0, 0xf0, 0xf0);
  static const Color grey01 =  Color.fromARGB(255, 0xfa, 0xfa, 0xfa);
  static const Color white =  Color.fromARGB(255, 0xff, 0xff, 0xff);


  void convertColor() {
    tm.white = white;
    tm.mainGreen = mainGreen;
    tm.mainBlue = mainBlue;
    tm.pointBlue = pointBlue;
    tm.softBlue = softBlue;
    tm.black = black;
    tm.grey05 = grey05;
    tm.grey04 = grey04;
    tm.grey03 = grey03;
    tm.grey02 = grey02;
    tm.grey01 = grey01;
    tm.red = red;

    Get.changeTheme(
      ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.light,
        fontFamily: 'NanumSquare',
      ),
    );
  }
}

//==============================================================================
// light-orange
//==============================================================================
class SkinColorLightDeepBlue {
  static const Color grey05 = Color.fromARGB(255, 80, 80, 80); // 도움말 글씨


  // 새로 정의한 색상 추가 (B 타입 밝은 테마. 2023.03.29)
  static const Color red =  Color.fromARGB(255, 0xff, 0x3c, 0x3c); // 알람 문구
  static const Color yellow =  Color.fromARGB(255, 0xff, 0xc1, 0x07);
  static const Color pointOrange =  Color.fromARGB(255, 0xff, 0x60, 0x2E);
  static const Color mainGreen =  Color.fromARGB(255, 0x24, 0x41, 0x36);
  static const Color softBlue =  Color.fromARGB(255, 0xd3, 0xe5, 0xf5);
  static const Color pointBlue =  Color.fromARGB(255, 0x24, 0x7b, 0xcb);
  static const Color mainBlue = Color.fromARGB(255, 0x24, 0x7b, 0xcb);

  static const Color background =  Color.fromARGB(255, 0xff, 0xff, 0xff);
  static const Color black =  Color.fromARGB(255, 0x32, 0x32, 0x32);
  static const Color grey04 =  Color.fromARGB(255, 0x64, 0x64, 0x64);
  static const Color grey03 =  Color.fromARGB(255, 0xb4, 0xb4, 0xb4);
  static const Color grey02 =  Color.fromARGB(255, 0xf0, 0xf0, 0xf0);
  static const Color grey01 =  Color.fromARGB(255, 0xfa, 0xfa, 0xfa);
  static const Color white = Color.fromARGB(255, 0xff, 0xff, 0xff);

  void convertColor() {
    tm.white = white;
    tm.mainGreen = mainGreen;
    tm.mainBlue = mainBlue;
    tm.pointBlue = pointBlue;
    tm.softBlue = softBlue;
    tm.black = black;
    tm.grey05 = grey05;
    tm.grey04 = grey04;
    tm.grey03 = grey03;
    tm.grey02 = grey02;
    tm.grey01 = grey01;
    tm.red = red;

    Get.changeTheme(
      ThemeData(
        primarySwatch: Colors.orange,
        brightness: Brightness.light,
        fontFamily: 'NanumSquare',
      ),
    );
  }
}
