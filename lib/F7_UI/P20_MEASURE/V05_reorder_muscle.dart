import '/F0_BASIC/common_import.dart';
import 'dart:io';

class ReorderMuscle extends StatefulWidget {
  const ReorderMuscle({Key? key}) : super(key: key);

  @override
  State<ReorderMuscle> createState() => _ReorderMuscleState();
}

class _ReorderMuscleState extends State<ReorderMuscle> {
  List<DbMuscleIndex> dbMuscleIndexList = gv.dbMuscleIndexes;
  late List<bool> isSelectedList;
  late int deleteNumber=0;

  @override
  void initState() {
    super.initState();
    isSelectedList = List.generate(dbMuscleIndexList.length, (_) => false);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: asHeight(700),
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: asWidth(18)),
                  child: TextN(
                    '근육 리스트',
                    fontSize: tm.s14,
                    color: tm.grey04,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                asSizedBox(height: 20),
                Expanded(
                  child: ReorderableListView(
                    scrollDirection: Axis.vertical,
                    onReorder: (oldIndex, newIndex) async {
                      // 현재 reorderableListView 에 문제가 있는데 몇년째 버그가 해결이 안되어 있는 상태임 (2023.03.28)
                      // 참고 자료:https://github.com/flutter/flutter/issues/24786
                      // These two lines are workarounds for ReorderableListView problems
                      setState(() {
                        if (newIndex > gv.dbmMuscle.numberOfData) {
                          newIndex = gv.dbmMuscle.numberOfData;
                        }
                        if (newIndex > oldIndex) {
                          newIndex -= 1;
                        }

                        final bool isSelected = isSelectedList.removeAt(oldIndex);
                        isSelectedList.insert(newIndex, isSelected);

                        final DbMuscleIndex draggedItem =
                            dbMuscleIndexList.removeAt(oldIndex);
                        dbMuscleIndexList.insert(newIndex, draggedItem);
                      });
                      await updateMuscleIndexAndContents(oldIndex, newIndex);
                      keySelectMuscleState.currentState?.refresh();
                    },
                    children: List.generate(dbMuscleIndexList.length,
                        (index) => muscleTile(index, key: ValueKey(index))),
                  ),
                ),
              ],
            ),
          ),

          //------------------------------------------------------------------------
          // 하단 삭제버튼 (1개 이상 선택되면 나타남)
          //------------------------------------------------------------------------
          // _deleteSheet(context),
          Visibility(
            visible: deleteNumber > 0,
            child: Container(
              width: asWidth(324),
              height: asHeight(72),
              color: tm.white,
              padding: EdgeInsets.symmetric(vertical: asHeight(10)),
              alignment: Alignment.bottomCenter,
              child: textButtonI(
                width: asWidth(324),
                height: asHeight(52),
                radius: asHeight(8),
                title: '$deleteNumber개 삭제',
                fontSize: tm.s16,
                onTap: () async {
                  int idxMuscle = gv.control.idxMuscle.value; // 프로세스 전, 앱에 설정되어 있던 idxMuscle 값

                  for(int index = dbMuscleIndexList.length-1; index >= 0; index--) {
                    // 삭제하는 index 가 현재 앱에 설정된 index 일 경우
                    if (index == idxMuscle){
                      gv.control.idxMuscle.value = 0; // 앱에 설정된 index 값 초기화
                    }
                    // 삭제하는 index 가 현재 앱에 설정된 index 보다 작을 경우, 현재 앱 index 값을 -1
                    else if(index < idxMuscle){
                      gv.control.idxMuscle.value--;
                    }

                    if(isSelectedList[index]==true) {
                      //현재 근육의 이미지가 있으면 삭제
                      if (dbMuscleIndexList[index].imageFileName != '') {
                        String imagePath = await getImagePath(
                            dbMuscleIndexList[index].imageFileName);
                        if(File(imagePath).existsSync()) {
                          await removeImageFiles(filePath: imagePath);
                        }
                      }

                      setState(() {
                        // 메모리에서 muscle 데이터 삭제
                        dbMuscleIndexList.removeAt(index);
                        isSelectedList.removeAt(index);
                      });

                      // DB(dbmMuscle)에서 근육 데이터 삭제
                      await gv.dbmMuscle.deleteData(index: index);

                      // 메모리와 DB 에서 record 데이터 삭제
                      // - DB 에서는 안의 내용을 알 수 없으므로, 메모리에서 삭제할 index 값을 찾은 것으로 DB의 같은 위치에 있는 데이터를 삭제
                      await deleteDbRecordIndexes(index);
                    }
                  }

                    await gv.control
                        .updateIdxMuscle(gv.control.idxMuscle.value);


                  //관련 class 데이터 갱신
                  keySelectMuscleState.currentState?.refresh();
                  updateGraphData(); // 근육 데이터가 삭제되었거나 근육의 index 값이 변경되었을 수 있으므로 통계그래프 데이터 업데이트
                  openSnackBarBasic('근육 데이터 삭제 완료', '$deleteNumber 데이터를 삭제하였습니다.');
                  deleteNumber = 0;
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  //----------------------------------------------------------------------------
  // 근육리스트 타일 선택
  //----------------------------------------------------------------------------
  Widget muscleTile(int index, {Key? key}) {
    return Container(
      key: key,
      width: asWidth(360),
      height: asHeight(68),
      color: tm.white,
      child: Column(
        children: [
          // SizedBox(height: asHeight(12)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  //----------------------------------------------------------------------------
                  // 근육 삭제 체크 박스
                  //----------------------------------------------------------------------------
                  InkWell(
                    onTap: (() {
                      setState(() {
                        isSelectedList[index] = !isSelectedList[index];
                        if(isSelectedList[index] == true) {
                          deleteNumber++;
                        }else{
                          deleteNumber--;
                        }
                      });
                    }),
                    child: Container(
                      padding: EdgeInsets.fromLTRB(
                          asWidth(18), 0.0, asWidth(8), 0.0),
                      // l,t,r,b
                      width: asHeight(24) + asWidth(26),
                      height: asHeight(65),
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.check_circle,
                        size: asHeight(24), //asWidth(25),
                        color: isSelectedList[index] ? tm.mainBlue : tm.grey03,
                        // _isSelectedList
                      ),
                    ),
                  ),
                  //------------------------------------------------------------
                  // 근육 아이콘
                  //----------------------------------------------------------------------------
                  ClipRRect(
                      borderRadius: BorderRadius.circular(asHeight(20)),
                      child: Transform(
                        alignment: Alignment.center,
                        transform: dbMuscleIndexList[index].isLeft
                            ? Matrix4.rotationY(pi)
                            : Matrix4.rotationY(0),
                        child: Container(
                          color: tm.grey01,
                          height: asHeight(40),
                          width: asHeight(40),
                          child: muscleIcon(
                              height: asHeight(40),
                              muscleTypeIndex:
                                  dbMuscleIndexList[index].muscleTypeIndex),
                        ),
                      )),
                  SizedBox(width: asWidth(10)),

                  AutoSizeText(
                    dbMuscleIndexList[index].muscleName,
                    style: TextStyle(
                      fontSize: tm.s16,
                      color: tm.black,
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: asWidth(18)),
                width: asHeight(18)+asWidth(18)*2,
                height: asHeight(18),
                child: Image.asset(
                  'assets/icons/ic_edit.png',
                  height: asHeight(18),
                  width: asHeight(18),
                  // color: tm.black,
                ),
              ),
            ],
          ),
          // SizedBox(height: asHeight(12)),
          dividerSmall2(),
        ],
      ),
    );
  }
}

//-----------------------------------
// muscle index 순서 바뀌면 호출
//-----------------------------------
Future<void> updateMuscleIndexAndContents(
  int currentIndex,
  // 이동하는 Tile 이 원래 있던 위치 index
  int newIndex, // 이동하는 Tile 이 가려고 하는 위치 index
) async {
  // 기존 근육 조절 값을 데이터베이스에 업데이트
  // await saveMuscleData();

  //--------------------------------------------------------------------------
  // DBMuscleIndex 에서 list 순서 변경 및 DbmMuscle 에서 indexMap 과 contentMap 순서 변경
  //--------------------------------------------------------------------------
  Map<String, dynamic> currentIndexMuscleIndex =
      gv.dbmMuscle.indexData[currentIndex];
  Map<String, dynamic> currentIndexMuscleContent =
      await gv.dbmMuscle.getDataContents(index: currentIndex);
  //drag 하는 tile 의 index 가 증가하는 쪽으로 이동하는 경우 => 그 사이에 있는 tile은 한칸씩 앞으로 이동
  if (newIndex > currentIndex) {
    for (int index = currentIndex; index < newIndex; index++) {
      await gv.dbmMuscle.updateData(
          index: index,
          indexMap: gv.dbmMuscle.indexData[index + 1],
          contentsMap: await gv.dbmMuscle
              .getDataContents(index: index + 1)); // muscle dB에 해당 index 수정
    }
    await gv.dbmMuscle.updateData(
        index: newIndex,
        indexMap: currentIndexMuscleIndex,
        contentsMap: currentIndexMuscleContent); // muscle dB에 해당 index 수정
  }
  //drag 하는 tile의 index 값이 감소하는 쪽으로 이동하는 경우 => 그 사이에 있는 tile은 한칸씩 뒤로 이동
  else if (newIndex < currentIndex) {
    for (int index = currentIndex; index > newIndex; index--) {
      await gv.dbmMuscle.updateData(
          index: index,
          indexMap: gv.dbmMuscle.indexData[index - 1],
          contentsMap: await gv.dbmMuscle.getDataContents(index: index - 1));
    }
    await gv.dbmMuscle.updateData(
        index: newIndex,
        indexMap: currentIndexMuscleIndex,
        contentsMap: currentIndexMuscleContent);
  }
  //drag 하는 tile 의 위치 변화 없음 (위치 변화가 없을 경우 ReorderableListView 가 onReorder 호출 하지 않음)
  else {
    if (kDebugMode) {
      print(
          '_SelectMuscleState :: updateMuscleIndexAndContents :: Error. 일어날 수 없는 상황');
    }
  }

  //--------------------------------------------------------------------------
  // Record DB 에서 각 record 마다 idxMuscle 를 확인하여 변경이 필요한 record 는 변경
  //--------------------------------------------------------------------------
  await changeIdxMuscleInRecordDB(currentIndex, newIndex);

  //--------------------------------------------------------------------------
  // 이동 하려는 muscle tile 에 의 해 현재 선택 되어 있는 muscle index(gv.control.idxMuscle.value)
  // 가 변경 된다면 Memory 에  선택된 muscle index 값 (gv.control.idxMuscle.value) 수정
  //--------------------------------------------------------------------------
  if (currentIndex == gv.control.idxMuscle.value) {
    gv.control.idxMuscle.value = newIndex;
  } else if (currentIndex < gv.control.idxMuscle.value &&
      gv.control.idxMuscle.value <= newIndex) {
    gv.control.idxMuscle.value--;
  } else if (currentIndex > gv.control.idxMuscle.value &&
      gv.control.idxMuscle.value >= newIndex) {
    gv.control.idxMuscle.value++;
  }

  //--------------------------------------------------------------------------
  // 현재 idxMuscle 이 변경된 idxMuscle 구간에 포함이 된다면, 메모리의 관련 data 들을 모두 새로 update
  //--------------------------------------------------------------------------
  if (currentIndex < newIndex
      ? (currentIndex <= gv.control.idxMuscle.value &&
          newIndex >= gv.control.idxMuscle.value)
      : (currentIndex >= gv.control.idxMuscle.value &&
          newIndex <= gv.control.idxMuscle.value)) {
    // 새로운 근육 인덱스 값으로 정보를 읽은 후 화면에 표시하기
    await gv.control
        .updateIdxMuscle(gv.control.idxMuscle.value); //관련 class 데이터 갱신
    // RefreshSetMuscle.muscle();
    RefreshSetMuscle.allInit(); //초기화 갱신
    await gv.control.updateIdxRecord(gv.control.idxMuscle.value);
    RefreshMuscleNameTextField.refresh();
    // 슬라이더 값 새로 불러오기
    gvMeasure.sliderValueTargetPrm =
        gv.deviceData[0].targetPrm.value.toDouble();
    gvMeasure.sliderValueMvc = gv.deviceData[0].mvc.value;
    initMvcSlider(); //슬라이더 범위 등의 값 초기화
    // 그래프 데이터 update
    await changeGraphMuscle();
  }
}

Future<void> changeIdxMuscleInRecordDB(int currentIndex, int newIndex) async {
  if (currentIndex < newIndex) {
    for (int recordIndex = 0;
        recordIndex < gvRecord.totalNumOfRecord.value;
        recordIndex++) {
      int idxMuscle = gv.dbRecordIndexes[recordIndex].idxMuscle;
      if (idxMuscle > currentIndex && idxMuscle <= newIndex) {
        gv.dbRecordIndexes[recordIndex].idxMuscle = idxMuscle - 1;
      } else if (idxMuscle == currentIndex) {
        gv.dbRecordIndexes[recordIndex].idxMuscle = newIndex;
      }
      await gv.dbmRecord.updateAnIndexData(
          index: recordIndex,
          indexMap: gv.dbRecordIndexes[recordIndex].toJson());
    }
  } else if (currentIndex > newIndex) {
    for (int recordIndex = 0;
        recordIndex < gvRecord.totalNumOfRecord.value;
        recordIndex++) {
      int idxMuscle = gv.dbRecordIndexes[recordIndex].idxMuscle;
      if (idxMuscle < currentIndex && idxMuscle >= newIndex) {
        gv.dbRecordIndexes[recordIndex].idxMuscle = idxMuscle + 1;
      } else if (idxMuscle == currentIndex) {
        gv.dbRecordIndexes[recordIndex].idxMuscle = newIndex;
      }
      await gv.dbmRecord.updateAnIndexData(
          index: recordIndex,
          indexMap: gv.dbRecordIndexes[recordIndex].toJson());
    }
  } else {
    if (kDebugMode) {
      print(
          '_SelectMuscleState :: changeIdxMuscleInRecordDB :: Error 일어날 수 없음');
    }
  }
}

//------------------------------------------------------------------------------
// 메모리에 있는 dbRecordIndexes 중 dbRecordIndexes[index].idxMuscle 값이 입력 받은 muscleIndex 와 같을 경우,
// 1. dbRecordIndexes 리스트의 해당 element 를 삭제
// 2. dbRecordIndexes 에서 삭제한 index 와 같은 위치의 element 를 dbmRecored 에서도 삭제(index, context 둘다)
//------------------------------------------------------------------------------
Future<void> deleteDbRecordIndexes(int muscleIndex) async {
  for(int index=0;index<gv.dbRecordIndexes.length;index++){
    if(gv.dbRecordIndexes[index].idxMuscle == muscleIndex){
      gv.dbRecordIndexes.removeAt(index);
      await gv.dbmRecord.deleteData(index: index);  // 이 명려으로 indexBox 와 contentsBox(lazy) 의 해당 element 삭제
      gvRecord.totalNumOfRecord.value = gv.dbmRecord.numberOfData;
    }
  }
}
