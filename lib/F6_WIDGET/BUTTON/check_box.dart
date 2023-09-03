import 'package:fitsig_basic_golf/F0_BASIC/common_import.dart';

//==============================================================================
// check box
//==============================================================================
Widget checkBoxRound({
  required Function onChanged,
  required bool isChecked,
  double size = 20,
}) {

    return Container(
      width: asWidth(size),
      height: asHeight(size),
      child: Checkbox(
        checkColor: tm.white,
        activeColor: tm.mainBlue,
        // fillColor: tm.blue,
        // fillColor: MaterialStateProperty.resolveWith(getColor),
        // fillColor: MaterialStateProperty.resolveWith(getColor),
        value: isChecked,
        shape: const CircleBorder(),
        onChanged: (val) => onChanged,
      ),
    );
}
