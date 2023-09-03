import '/F0_BASIC/common_import.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

GlobalKey<_MuscleNameTextFieldState> keyMuscleNameTextField =
    GlobalKey(); //외부 갱신 제어용 글로벌 key

//==============================================================================
// muscle name text field
// 텍스트 변화 시 getSelectedText on inactive InputConnection 버그 발생
// 상기 문제 해결 되었으나 일부 메시지로 뭔가 뜸 -> 동작에는 문제 없는 듯
//==============================================================================
class MuscleNameTextField extends StatefulWidget {
  const MuscleNameTextField({Key? key}) : super(key: key);

  @override
  State<MuscleNameTextField> createState() => _MuscleNameTextFieldState();
}

class _MuscleNameTextFieldState extends State<MuscleNameTextField> {
  //------------------------------------------------------------------------
  // 변수 선언
  //------------------------------------------------------------------------
  late TextEditingController textController = TextEditingController(
    // text: gv.dbMuscleIndexes[gv.control.idxMuscle.value].muscleName);
    text: gv.deviceData[0].muscleName.value,
  );
  bool isChangedMuscleName = false;

  //------------------------------------------------------------------------
  // 화면 갱신과 함께 다양한 역할
  //------------------------------------------------------------------------
  void refresh() {
    // 새로운 근육 값 정보 나타내기
    // textController.text = gv.dbMuscleIndexes[gv.control.idxMuscle.value].muscleName;
    textController.text = gv.deviceData[0].muscleName.value;
    // 커서를 맨 뒤로 보내기
    textController.selection = TextSelection.fromPosition(
        TextPosition(offset: textController.text.length));
    //변경 버튼 색상 변화시키기
    if (textController.text != gv.deviceData[0].muscleName.value) {
      // gv.dbMuscleIndexes[gv.control.idxMuscle.value].muscleName) {
      // print('text is changed');
      isChangedMuscleName = true;
      setState(() {});
    } else {
      isChangedMuscleName = false;
      setState(() {});
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  // // 근육 이름 변경시 호출됨. 해당 근육의 사진이 있을 경우 사진의 파일 명을 변경된 근육명으로 수정
  // void changeImageFileName(
  //     String previousImageFilePath, String newMuscleName) async {
  //   if (File(previousImageFilePath).existsSync()) {
  //     Directory imageDirectory;
  //     if (Platform.isIOS) {
  //       imageDirectory = await getApplicationSupportDirectory();
  //     } else {
  //       imageDirectory = await getApplicationDocumentsDirectory();
  //     }
  //     String newImageFilePath = '${imageDirectory.path}/$newMuscleName.jpg';
  //     File previousImageFile = File(previousImageFilePath);
  //     previousImageFile.renameSync(newImageFilePath);
  //
  //     //바뀐 이름의 이미지 파일이 존재하면, 관련 변수 값도 변경
  //     if (File(newImageFilePath).existsSync()) {
  //       gv.deviceData[0].imagePath = newImageFilePath;
  //       gv.deviceData[0].imageBytes.value =
  //           File(newImageFilePath).readAsBytesSync();
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    // textController = TextEditingController(
    //     text: gv.dbMuscleIndexes[gv.control.idxMuscle.value].muscleName);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: asWidth(18)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //--------------------------------------------------------------------
          // 근육 이름
          TextN(
            '근육 이름'.tr,
            fontSize: tm.s14,
            color: tm.grey03,
          ),
          asSizedBox(height: 12),
          //--------------------------------------------------------------------
          // 근육 이름 변경
          Container(
            height: asHeight(48),
            decoration: BoxDecoration(
              color: tm.grey01,
              borderRadius: BorderRadius.circular(asHeight(8)),
            ),
            child: Row(
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: asHeight(48),
                  width: asWidth(242),
                  // alignment: Alignment.centerLeft,
                  padding: EdgeInsets.symmetric(horizontal: asHeight(15)),
                  //------------------------------------------------------------
                  // 근육 이름 필드
                  child: TextFormField(
                    //---------------------------------------------------
                    // 글자 수 제한
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(
                          GvDef.maxLengthOfMuscleName),
                    ],
                    validator: (value) {
                      return _isNotDuplicated(value)
                          ? null
                          : '중복되지 않는 근육 이름을 입력해주세요';
                    },
                    style: TextStyle(
                        fontSize: tm.s14,
                        color: tm.black,
                        fontWeight: FontWeight.bold),
                    // textAlign: TextAlign.center,
                    // textAlignVertical: TextAlignVertical.center,
                    cursorColor: tm.mainBlue,

                    decoration: InputDecoration(
                      // filled: true,
                      // fillColor: Colors.yellow,
                      // hintText: gv.dbMuscleIndexes[gv.control.idxMuscle.value].muscleName,
                      labelStyle: TextStyle(
                          color: tm.black,
                          fontSize: tm.s14,
                          fontWeight: FontWeight.bold),
                      // 아래 contentsPadding을 하면 정렬이 무너지는 듯
                      // 폰트에 따라 textFormField 에 글자가 표시되는 높이가 다름 (아래 참고 링크)
                      // https://stackoverflow.com/questions/70083264/how-to-vertical-align-text-inside-textformfield
                      contentPadding: EdgeInsets.only(
                        left: 0,
                        right: 0,
                        top: 0,
                        bottom: asHeight(3),
                      ),
                      focusedBorder: InputBorder.none,
                      //밑 줄 없애기
                      border: InputBorder.none,
                    ),
                    keyboardType: TextInputType.text,
                    //.emailAddress,
                    controller: textController,
                    textAlignVertical: TextAlignVertical.center,

                    // gv.system.isIos
                    //     ? TextAlignVertical.top
                    //     : TextAlignVertical.center,
                    // iOS 와 안드로이드에 따라 TextField 안의 글자 위치가 다름
                    onChanged: ((text) {
                      //---------------------------------------------------
                      // 내용 변화 감지 - 버튼 색상 활성화/비활성화
                      if (text != gv.deviceData[0].muscleName.value) {
                        // gv.dbMuscleIndexes[gv.control.idxMuscle.value]
                        //     .muscleName) {
                        // print('text is changed');
                        isChangedMuscleName = true;
                        setState(() {});
                      } else {
                        isChangedMuscleName = false;
                        setState(() {});
                      }
                    }),
                  ),
                  // alignment: Alignment.center,
                ),

                //--------------------------------------------------------------
                // 변경 버튼
                textButtonBasic(
                  width: asWidth(62),
                  height: asHeight(32),
                  radius: asHeight(8),
                  touchWidth: asWidth(82),
                  touchHeight: asHeight(52),
                  touchRadius: asHeight(16),
                  backgroundColor:
                      isChangedMuscleName ? tm.mainBlue : tm.black.withOpacity(0.5),
                  textColor: tm.fixedWhite,
                  isViewBorder: false,
                  title: '변경',
                  onTap: (() async {
                    if (textController.text.length >
                        GvDef.maxLengthOfMuscleName) {
                      openSnackBarBasic(
                          '근육명 길이 초과',
                          '근육 이름의 길이는 최대 ${GvDef.maxLengthOfMuscleName}자'
                              ' 이하가 되어야 합니다.');
                    } else if (textController.text.isEmpty) {
                      isChangedMuscleName = false;
                      setState(() {});
                      //아무런 변화 없음 (기존 이름 값 유지)
                      // openSnackBarBasic('빈 근육 이름', '근육 이름을 입력해 주세요.');
                    } else {
                      isChangedMuscleName = false;
                      setState(() {});
                      // 이름 갱신
                      gv.deviceData[0].muscleName.value = textController.text;

                      //기존에 imagePath 정보가 있었다면, 해당 패스가 가리키는 파일의 파일명을 변경(새 근육명으로)
                      // if (gv.deviceData[0].imagePath != '') {
                      //   changeImageFileName(gv.deviceData[0].imagePath,
                      //       gv.deviceData[0].muscleName.value);
                      // }

                      // muscl 메모리에 변경된 근육 이름 저장
                      gv.dbMuscleIndexes[gv.control.idxMuscle.value]
                          .muscleName = textController.text;
                      // muscle DB 에 해당 idxMuscle 의 근육 이름 변경
                      await gv.dbmMuscle.updateData(
                          index: gv.control.idxMuscle.value,
                          indexMap: gv
                              .dbMuscleIndexes[gv.control.idxMuscle.value]
                              .toJson(),
                          contentsMap: gv.dbMuscleContents.toJson());
                      // Record DB 에 해당 idxMuscle 를 가지고 있는 측정 데이터에 있는 근육 이름 변경
                      changeMuscleNameInDbRecord(gv.control.idxMuscle.value , textController.text);

                      // 화면 갱신
                      RefreshSetMuscle.all();
                    }
                  }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  bool _isNotDuplicated(String? value) {
    int dataNumber = gv.dbmMuscle.numberOfData;
    for (int index = 0; index < dataNumber; index++) {
      if (value == gv.dbMuscleIndexes[index].muscleName) {
        return false;
      }
    }
    return true;
  }
}

//------------------------------------------------------------------------------
// 메모리에 있는 dbRecordIndexes 중 dbRecordIndexes[index].idxMuscle 값이 입력 받은 muscleIndex 와 같을 경우,
// dbRecordIndexes 리스트의 해당 element 에 있는 muscleName 을 변경
//------------------------------------------------------------------------------
Future<void> changeMuscleNameInDbRecord(int muscleIndex, String newMuscleName) async {
  for(int index=0;index<gv.dbRecordIndexes.length;index++){
    if(gv.dbRecordIndexes[index].idxMuscle == muscleIndex){
      gv.dbRecordIndexes[index].muscleName = newMuscleName;
      await gv.dbmRecord.updateAnIndexData(index: index, indexMap: gv.dbRecordIndexes[index].toJson() );
    }
  }
}

//==============================================================================
// 화면 갱신
//==============================================================================
class RefreshMuscleNameTextField {
  //----------------------------------------------------------------------------
  // 전체 갱신
  //----------------------------------------------------------------------------
  static refresh() {
    keyMuscleNameTextField.currentState?.refresh();
  }
}
