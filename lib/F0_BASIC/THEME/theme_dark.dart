import '/F0_BASIC/common_import.dart';

//==============================================================================
// light-blue
//==============================================================================
class SkinColorDarkBlue {
  static const Color grey05 = Color.fromARGB(255, 220, 220, 220); // 도움말 글씨

  // 새로 정의한 색상 추가 (A 타입 어두운 테마. 2023.03.29)
  static const Color red =  Color.fromARGB(255, 0xd1, 0x35, 0x35); // 알람 문구
  static const  Color yellow =  Color.fromARGB(255, 0xd1, 0xa0, 0x0b);
  static const Color pointOrange =  Color.fromARGB(255, 0xd1, 0x52, 0x2a);
  static const Color mainGreen =  Color.fromARGB(255, 0x51, 0xb5, 0x72);
  static const   Color softBlue =  Color.fromARGB(255, 0x27, 0x39, 0x49);
  static const  Color pointBlue =  Color.fromARGB(255, 0x45, 0x7d, 0xd1);
  static const   Color mainBlue =  Color.fromARGB(255, 0x45, 0x7d, 0xd1);

  static const  Color background =  Color.fromARGB(255, 0x1a, 0x1a, 0x1a);
  static const  Color black =  Color.fromARGB(255, 0xfa, 0xfa, 0xfa);
  static const   Color grey04 =  Color.fromARGB(255, 0xb4, 0xb4, 0xb4);
  static const  Color grey03 =  Color.fromARGB(255, 0x64, 0x64, 0x64);
  static const   Color grey02 =  Color.fromARGB(255, 0x32, 0x32, 0x32);
  static const   Color grey01 =  Color.fromARGB(255, 0x28, 0x28, 0x28);
  static const   Color white =  Color.fromARGB(255, 0x1a, 0x1a, 0x1a);

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
        brightness: Brightness.dark,
        fontFamily: 'NanumSquare',
      ),
    );
  }
}

//==============================================================================
// light-orange
//==============================================================================
class SkinColorDarkDeepBlue {
  static const Color grey05 = Color.fromARGB(255, 220, 220, 220); // 도움말 글씨

  // 새로 정의한 색상 추가 (B 타입 어두운 테마. 2023.03.29)
  static const Color red =  Color.fromARGB(255, 0xd1, 0x35, 0x35); // 알람 문구
  static const Color yellow =  Color.fromARGB(255, 0xd1, 0xa0, 0x0b);
  static const Color pointOrange =  Color.fromARGB(255, 0xd1, 0x52, 0x2a);
  static const Color mainGreen =  Color.fromARGB(255, 0x2e, 0x62, 0x4e);
  static const Color softBlue =  Color.fromARGB(255, 0x25, 0x32, 0x3f);
  static const Color pointBlue =  Color.fromARGB(255, 0x22, 0x68, 0xa8);
  static const Color mainBlue =  Color.fromARGB(255, 0x22, 0x68, 0xa8);

  static const Color background =  Color.fromARGB(255, 0x1a, 0x1a, 0x1a);
  static const Color black =  Color.fromARGB(255, 0xfa, 0xfa, 0xfa);
  static const Color grey04 =  Color.fromARGB(255, 0xb4, 0xb4, 0xb4);
  static const Color grey03 =  Color.fromARGB(255, 0x64, 0x64, 0x64);
  static const Color grey02 =  Color.fromARGB(255, 0x32, 0x32, 0x32);
  static const Color grey01 =  Color.fromARGB(255, 0x28, 0x28, 0x28);
  static const Color white =  Color.fromARGB(255, 0x1a, 0x1a, 0x1a);

  void convertColor() {
    tm.white = white;
    tm.mainGreen = mainGreen;
    tm.mainBlue = mainBlue;
    tm.softBlue = softBlue;
    tm.pointBlue = pointBlue;
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
        brightness: Brightness.dark,
        fontFamily: 'NanumSquare',
      ),
    );
  }
}
