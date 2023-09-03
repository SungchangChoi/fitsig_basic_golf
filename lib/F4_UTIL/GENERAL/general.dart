
import '/F0_BASIC/common_import.dart';

//==============================================================================
// 근육 종류 이름 반환
//==============================================================================

String muscleTypeName(int muscleTypeIndex){
  //----------------------------------------------
// 근육이름
  String muscleTypeName = '';
  if (gv.setting.isMuscleNameKrPure.value == true) {
    muscleTypeName =
    GvDef.muscleListKrPure[muscleTypeIndex];
  } else {
    muscleTypeName = GvDef.muscleListKr[muscleTypeIndex];
  }
  return muscleTypeName;
}