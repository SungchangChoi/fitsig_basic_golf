import '/F0_BASIC/common_import.dart';

//==============================================================================
// award mark (훌륭해요, 보통이에요, 아쉬워요)
//==============================================================================
Widget awardMark({EmaAward emaAward = EmaAward.good}) {
  if (emaAward == EmaAward.great) {
    return _awardGreat();
  } else if (emaAward == EmaAward.good) {
    return _awardGood();
  } else {
    return _awardBad();
  }
}

Widget _awardGreat() {
  return Image.asset(
    'assets/icons/ic_great.png',
    fit: BoxFit.scaleDown,
    height: asHeight(30),
    color: tm.mainBlue,
  );
}

Widget _awardGood() {
  return Image.asset(
    'assets/icons/ic_good.png',
    fit: BoxFit.scaleDown,
    height: asHeight(30),
    color: tm.mainBlue,
  );
}

Widget _awardBad() {
  return Image.asset(
    'assets/icons/ic_bad.png',
    fit: BoxFit.scaleDown,
    height: asHeight(30),
    color: tm.mainBlue,
  );
}

//==============================================================================
// award text (훌륭해요, 좋아요, 아쉬워요)
//==============================================================================
Widget awardText({EmaAward emaAward = EmaAward.good}) {
  if (emaAward == EmaAward.great) {
    return _awardTextBox(
      text: '훌륭해요',
      textColor: tm.mainBlue,
      backgroundColor: tm.softBlue,
    );
  } else if (emaAward == EmaAward.good) {
    return _awardTextBox(
      text: '좋아요',
      textColor: tm.mainGreen,
      backgroundColor: tm.mainGreen.withOpacity(0.1),
    );
  } else {
    return _awardTextBox(
      text: '아쉬워요',
      textColor: tm.grey03,
      backgroundColor: tm.grey03.withOpacity(0.1),
    );
  }
}

Widget _awardTextBox(
    {String text = '',
    Color backgroundColor = Colors.grey,
    Color textColor = Colors.blue}) {
  return Container(
      alignment: Alignment.center,
      width: asWidth(67),
      height: asHeight(30),
      decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(asWidth(10)),
              topRight: Radius.circular(asWidth(10)))),
      child:
          FittedBoxN(child: TextN(text, fontSize: tm.s14, color: textColor)));
}
