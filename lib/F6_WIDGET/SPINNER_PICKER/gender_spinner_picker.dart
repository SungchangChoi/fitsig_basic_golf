import 'package:fitsig_basic_golf/F0_BASIC/common_import.dart';

Widget genderPicker({int initialIndex=0,required  Function(int) callbackOnTap}) {
  return singleSpinnerPicker(
    width: asWidth(324),
    height: asHeight(220),
    idxInitial: initialIndex,
    itemTextList: gv.setting.genderList,
    callbackOnTap:
    callbackOnTap,
  );
}