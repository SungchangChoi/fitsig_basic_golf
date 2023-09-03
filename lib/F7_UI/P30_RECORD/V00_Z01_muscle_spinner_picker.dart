import 'package:fitsig_basic_golf/F0_BASIC/common_import.dart';

//==============================================================================
// 근육 선택
//==============================================================================
Widget muscleSpinnerPicker()
{
  // 초기 선택된 근육은 현재의 근육
  int _muscleIndex = gv.control.idxMuscle.value;
  final List<String> _muscleNameList = List<String>.generate(
      gv.dbMuscleIndexes.length,
          (index) => gv.dbMuscleIndexes[index].muscleName);
  return singleSpinnerPicker(
    width: asWidth(324),
    height: asHeight(220),
    idxInitial: _muscleIndex,
    itemTextList: _muscleNameList,
    callbackOnTap: (idxPresent) async{
      await gv.control.updateIdxMuscle(idxPresent);
      await changeGraphMuscle();
      Get.back();
      // Navigator.pop(context);
    },
  );
}
//==============================================================================
// 근육 선택
//==============================================================================
class MuscleSpinnerPicker extends StatefulWidget {
  const MuscleSpinnerPicker({
    Key? key,
    required this.context,
  }) : super(key: key);
  final BuildContext context;

  @override
  State<MuscleSpinnerPicker> createState() => _MuscleSpinnerPickerState();
}

class _MuscleSpinnerPickerState extends State<MuscleSpinnerPicker> {
  // 초기 선택된 근육은 현재의 근육
  int _muscleIndex = gv.control.idxMuscle.value;
  final List<String> _muscleNameList = List<String>.generate(
      gv.dbMuscleIndexes.length,
      (index) => gv.dbMuscleIndexes[index].muscleName);

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          _head(),
          // dividerBig(),
          _main(),
          asSizedBox(height: 20),
          // _selectButton(context),
          textButtonI(
            title: '확인',
            width: asWidth(324),
            height: asHeight(58),
            radius: asHeight(8),
            // touchWidth: asWidth(120),
            // touchHeight: asHeight(60),
            onTap: (() async{
              await gv.control.updateIdxMuscle(_muscleIndex);
              await changeGraphMuscle();
              Navigator.pop(context);
            })
          ),
        ],
      ),
    );
  }

  //----------------------------------------------------------------------------
  //다이얼로그 제목
  //----------------------------------------------------------------------------
  Widget _head() {
    return Container(
      // 여유공간
      margin: EdgeInsets.only(
        top: asHeight(10),
        left: asWidth(8),
        right: asWidth(8),
        bottom: asHeight(10),
      ),
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Align(
            alignment: Alignment.center,
            child: TextN(
              '근육선택',
              fontSize: tm.s20,
              color: tm.grey04,
              fontWeight: FontWeight.w600,
            ),
          ),
          //----------------------------------------------------------------------
          // 닫기 버튼
          Align(
            alignment: Alignment.centerRight,
            child: InkWell(
              borderRadius: BorderRadius.circular(asWidth(10)),
              onTap: (() {
                Get.back();
              }),
              child: Container(
                width: asWidth(56),
                height: asHeight(56),
                alignment: Alignment.center,
                child: Icon(
                  Icons.close,
                  size: asHeight(36),
                  color: tm.grey03,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  //----------------------------------------------------------------------------
  // 다이얼로그 메인내용
  //----------------------------------------------------------------------------
  Widget _main() {
    return spinnerBasic(
      width: asWidth(360-36), // asWidth(Get.width * 0.7),
      height: asHeight(220), // tm.s30 * 7,
      itemHeight: asHeight(40), //tm.s40,
      backgroundColor: Colors.transparent, //tm.grey01,
      onSelectedItemChanged: (index) {
        _muscleIndex = index;
      },
      childCount: gv.dbMuscleIndexes.length,
      initialItem: gv.control.idxMuscle.value,
      fontSize: tm.s20,
      textColor: tm.grey04,
      itemTextList: _muscleNameList,
    );
  }
}
