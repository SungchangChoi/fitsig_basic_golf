import '/F0_BASIC/common_import.dart';

//==============================================================================
// 근육 추가
//==============================================================================
void openAddMuscle() {
  openBottomSheetBasic(
      isHeadView: true,
      headTitle: '새근육 추가',
      height: asHeight(790),
      child: const _EditMuscle(isNewMuscle: true));
}

//==============================================================================
// 근육 부위 변경
//==============================================================================
void openEditMuscle() {
  openBottomSheetBasic(
      isHeadView: true,
      headTitle: '근육 변경',
      height: asHeight(790),
      child: const _EditMuscle(isNewMuscle: false));
}

//==============================================================================
// 근육 추가화면 내용
//==============================================================================

class _EditMuscle extends StatefulWidget {
  final bool isNewMuscle; //

  const _EditMuscle({this.isNewMuscle = false, Key? key}) : super(key: key);

  @override
  State<_EditMuscle> createState() => _EditMuscleState();
}

class _EditMuscleState extends State<_EditMuscle> {
  int muscleGroup = 0; //근육 그룹 선택
  bool isLeft = false; //좌우 선택
  int muscleListIndex = 0; //근육 부위 선택

  int presentMuscleIndex = gv.control.idxMuscle.value; //현재의 근육

  @override
  void initState() {
    // 변경의 경우 설정 값 현재 근육으로 초기화
    if (widget.isNewMuscle == false) {
      isLeft = gv.deviceData[0].isLeft.value;
      muscleListIndex = gv.deviceData[0].muscleTypeIndex.value;
      muscleGroup = muscleIndexToGroupNumber(muscleTypeIndex: muscleListIndex);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: asHeight(720),
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          //----------------------------------------------------------------------
          // 전체내용
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //----------------------------------------------------------------------
              // 카테고리
              //----------------------------------------------------------------------
              Padding(
                padding: EdgeInsets.symmetric(horizontal: asWidth(18)),
                child: TextN('카테고리', fontSize: tm.s14, color: tm.grey04),
              ),
              asSizedBox(height: 8),
              _category(),
              //----------------------------------------------------------------------
              // 좌우
              //----------------------------------------------------------------------
              asSizedBox(height: 46),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: asWidth(18)),
                child: TextN('좌우', fontSize: tm.s14, color: tm.grey04),
              ),
              asSizedBox(height: 8),
              _leftRight(),
              //----------------------------------------------------------------------
              // 근육 선택
              //----------------------------------------------------------------------
              asSizedBox(height: 46),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: asWidth(18)),
                child: TextN('근육선택', fontSize: tm.s14, color: tm.grey04),
              ),
              asSizedBox(height: 8),
              muscleList(),
            ],
          ),
          //----------------------------------------------------------------------
          // 근육 버튼
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                  color: tm.white,
                  height: asHeight(82),
                  width: asWidth(360),
                  alignment: Alignment.center,
                  child: textButtonI(
                      width: asWidth(324),
                      height: asHeight(52),
                      radius: asHeight(8),
                      title: widget.isNewMuscle ? '근육 추가' : '근육 선택',
                      fontSize: tm.s16,
                      onTap: (() async {
                        int d = 0; //deviceIndex
                        //■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
                        // 근육을 새롭게 추가하는 경우
                        //■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
                        if (widget.isNewMuscle) {
                          //----------------------------------------------------
                          // 추가 할 근육 한계 검증
                          if (gv.dbmMuscle.numberOfData + 1 >
                              GvDef.maxNumOfMuscle) {
                            openSnackBarBasic(
                              '한계 초과',
                              '본 앱에서 기록 관리할 수 있는 최대 근육 수에 도달하였습니다.',
                              //backgroundColor: tm.red,
                            );
                          }
                          //----------------------------------------------------
                          // 신규 근육 추가
                          else {
                            //--------------------------------------------------
                            // 디바이스 데이터에 근육부위 및 좌우 기록
                            gv.deviceData[d].muscleTypeIndex.value =
                                muscleListIndex;
                            gv.deviceData[d].isLeft.value = isLeft;
                            //--------------------------------------------------
                            // 신규 데이터베이스 생성
                            gv.dbMuscleIndexes.add(DbMuscleIndex());
                            gv.dbMuscleContents = DbMuscleContents();
                            presentMuscleIndex =
                                gv.dbmMuscle.numberOfData; //마지막 index + 1
                            gv.control.idxMuscle.value =
                                presentMuscleIndex; //추가된 index
                            gv.deviceData[0].imagePath.value = '';

                            //--------------------------------------------------
                            // 순 우리말 설정 시
                            // todo : 영어 등 다국어 일 경우 수정 필요
                            // 좌우 붙이기!
                            String muscleName = '';
                            if (gv.setting.isMuscleNameKrPure.value) {
                              muscleName = GvDef.muscleListKrPure[
                                  gv.deviceData[0].muscleTypeIndex.value];
                            } else {
                              muscleName = GvDef.muscleListKr[
                                  gv.deviceData[0].muscleTypeIndex.value];
                            }
                            //--------------------------------------------------
                            // 좌우 기록
                            String leftRight = '';
                            if (muscleListIndex == 0) {
                              leftRight = '';
                            }
                            if (isLeft == true) {
                              leftRight = ' 좌';
                            } else {
                              leftRight = ' 우';
                            }
                            //--------------------------------------------------
                            // 기본적으로 생성되는 근육이름 (사용자 수정 가능)
                            gv.deviceData[d].muscleName.value =
                                '$muscleName$leftRight';
                            gv.dbMuscleIndexes[presentMuscleIndex].muscleName =
                                gv.deviceData[d].muscleName.value;
                            //--------------------------------------------------
                            // dB index 에 근육 부위 및 좌우 기록
                            gv.dbMuscleIndexes[presentMuscleIndex]
                                    .muscleTypeIndex =
                                gv.deviceData[d].muscleTypeIndex.value;
                            gv.dbMuscleIndexes[presentMuscleIndex].isLeft =
                                gv.deviceData[d].isLeft.value;

                            //--------------------------------------------------
                            // 데이터베이스에 신규 근육 추가
                            await gv.dbmMuscle.insertData(
                                indexMap: gv.dbMuscleIndexes[presentMuscleIndex]
                                    .toJson(),
                                contentsMap: gv.dbMuscleContents.toJson());
                            //--------------------------------------------------
                            // 현재의 근육으로 모두 갱신
                            await gv.control.updateIdxMuscle(
                                presentMuscleIndex); //관련 class 데이터 갱신
                            RefreshSetMuscle.allInit(); //초기화 갱신
                            //--------------------------------------------------
                            // 신규 추가 시 스크롤 자동으로 맨 끝으로 이동 (with animation)
                            muscleListScrollPositionToLast();
                            //--------------------------------------------------
                            // 창 닫기
                            Get.back();
                            changeGraphMuscle();
                          }
                        }
                        //■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
                        // 근육 부위만 갱신하는 경우
                        //■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
                        else {
                          //--------------------------------------------------
                          // 디바이스 데이터에 근육부위 및 좌우 기록
                          gv.deviceData[d].muscleTypeIndex.value =
                              muscleListIndex;
                          gv.deviceData[d].isLeft.value = isLeft;
                          //--------------------------------------------------
                          // dB index 에 근육 부위 및 좌우 기록
                          gv.dbMuscleIndexes[presentMuscleIndex]
                                  .muscleTypeIndex =
                              gv.deviceData[d].muscleTypeIndex.value;
                          gv.dbMuscleIndexes[presentMuscleIndex].isLeft =
                              gv.deviceData[d].isLeft.value;

                          //--------------------------------------------------
                          // 데이터베이스에 신규 근육 추가
                          await gv.dbmMuscle.updateData(
                              index: gv.control.idxMuscle.value,
                              indexMap: gv.dbMuscleIndexes[presentMuscleIndex]
                                  .toJson(),
                              contentsMap: gv.dbMuscleContents.toJson());
                          //--------------------------------------------------
                          // 현재의 근육으로 모두 갱신
                          await gv.control.updateIdxMuscle(
                              presentMuscleIndex); //관련 class 데이터 갱신
                          RefreshSetMuscle.allInit(); //초기화 갱신
                          //------------------------------------------------------------
                          // 창 닫기
                          Get.back();
                        }
                      }))),
            ],
          ),
        ],
      ),
    );
  }

  ///---------------------------------------------------------------------------
  /// 카테고리
  ///---------------------------------------------------------------------------
  Widget _category() {
    return Column(
      children: [
        //----------------------------------------------------------------------
        // 근육 부위 1행
        //----------------------------------------------------------------------
        Padding(
          padding: EdgeInsets.symmetric(horizontal: asWidth(14)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              wButtonAwGeneral(
                  height: asHeight(36),
                  touchHeight: asHeight(44),
                  padTouchWidth: asWidth(4),
                  padWidth: asWidth(10),
                  borderColor:
                      muscleGroup == 0 ? tm.softBlue : tm.grey02,
                  borderWidth: 2,
                  child: TextN('팔',
                      fontSize: tm.s16,
                      color: muscleGroup == 0 ? tm.mainBlue : tm.grey04),
                  onTap: (() {
                    muscleGroup = 0;
                    setState(() {});
                  })),
              wButtonAwGeneral(
                  height: asHeight(36),
                  touchHeight: asHeight(44),
                  padTouchWidth: asWidth(4),
                  padWidth: asWidth(10),
                  borderColor:
                      muscleGroup == 1 ? tm.softBlue : tm.grey02,
                  borderWidth: 2,
                  child: TextN('어깨',
                      fontSize: tm.s16,
                      color: muscleGroup == 1 ? tm.mainBlue : tm.grey04),
                  onTap: (() {
                    muscleGroup = 1;
                    setState(() {});
                  })),
              wButtonAwGeneral(
                  height: asHeight(36),
                  touchHeight: asHeight(44),
                  padTouchWidth: asWidth(4),
                  padWidth: asWidth(10),
                  borderColor:
                      muscleGroup == 2 ? tm.softBlue : tm.grey02,
                  borderWidth: 2,
                  child: TextN('가슴',
                      fontSize: tm.s16,
                      color: muscleGroup == 2 ? tm.mainBlue : tm.grey04),
                  onTap: (() {
                    muscleGroup = 2;
                    setState(() {});
                  })),
              wButtonAwGeneral(
                  height: asHeight(36),
                  touchHeight: asHeight(44),
                  padTouchWidth: asWidth(4),
                  padWidth: asWidth(10),
                  borderColor:
                      muscleGroup == 3 ? tm.softBlue : tm.grey02,
                  borderWidth: 2,
                  child: TextN('복부',
                      fontSize: tm.s16,
                      color: muscleGroup == 3 ? tm.mainBlue : tm.grey04),
                  onTap: (() {
                    muscleGroup = 3;
                    setState(() {});
                  })),
              wButtonAwGeneral(
                  height: asHeight(36),
                  touchHeight: asHeight(44),
                  padTouchWidth: asWidth(4),
                  padWidth: asWidth(10),
                  borderColor:
                      muscleGroup == 4 ? tm.softBlue : tm.grey02,
                  borderWidth: 2,
                  child: TextN('등',
                      fontSize: tm.s16,
                      color: muscleGroup == 4 ? tm.mainBlue : tm.grey04),
                  onTap: (() {
                    muscleGroup = 4;
                    setState(() {});
                  })),
            ],
          ),
        ),
        //----------------------------------------------------------------------
        // 근육 부위 2행
        //----------------------------------------------------------------------
        Padding(
          padding: EdgeInsets.symmetric(horizontal: asWidth(14)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              wButtonAwGeneral(
                  height: asHeight(36),
                  touchHeight: asHeight(44),
                  padTouchWidth: asWidth(4),
                  padWidth: asWidth(10),
                  borderColor:
                      muscleGroup == 5 ? tm.softBlue : tm.grey02,
                  borderWidth: 2,
                  child: TextN('엉덩이',
                      fontSize: tm.s16,
                      color: muscleGroup == 5 ? tm.mainBlue : tm.grey04),
                  onTap: (() {
                    muscleGroup = 5;
                    setState(() {});
                  })),
              wButtonAwGeneral(
                  height: asHeight(36),
                  touchHeight: asHeight(44),
                  padTouchWidth: asWidth(4),
                  padWidth: asWidth(10),
                  borderColor:
                      muscleGroup == 6 ? tm.softBlue : tm.grey02,
                  borderWidth: 2,
                  child: TextN('다리',
                      fontSize: tm.s16,
                      color: muscleGroup == 6 ? tm.mainBlue : tm.grey04),
                  onTap: (() {
                    muscleGroup = 6;
                    setState(() {});
                  })),
              wButtonAwGeneral(
                  height: asHeight(36),
                  touchHeight: asHeight(44),
                  padTouchWidth: asWidth(4),
                  padWidth: asWidth(10),
                  borderColor:
                      muscleGroup == 7 ? tm.softBlue : tm.grey02,
                  borderWidth: 2,
                  child: TextN('사용자',
                      fontSize: tm.s16,
                      color: muscleGroup == 7 ? tm.mainBlue : tm.grey04),
                  onTap: (() {
                    muscleGroup = 7;
                    setState(() {});
                  })),
            ],
          ),
        ),
      ],
    );
  }

  ///---------------------------------------------------------------------------
  /// 좌우
  ///---------------------------------------------------------------------------
  Widget _leftRight() {
    return
        //----------------------------------------------------------------------
        // 근육 부위 1행
        //----------------------------------------------------------------------
        Padding(
      padding: EdgeInsets.symmetric(horizontal: asWidth(14)),
      child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
        wButtonAwGeneral(
            height: asHeight(36),
            touchHeight: asHeight(44),
            padTouchWidth: asWidth(4),
            padWidth: asWidth(10),
            borderColor: isLeft ? tm.softBlue : tm.grey02,
            borderWidth: 2,
            child: TextN('왼쪽',
                fontSize: tm.s16, color: isLeft ? tm.mainBlue : tm.grey04),
            onTap: (() {
              isLeft = true;
              setState(() {});
            })),
        wButtonAwGeneral(
            height: asHeight(36),
            touchHeight: asHeight(44),
            padTouchWidth: asWidth(4),
            padWidth: asWidth(10),
            borderColor: !isLeft ? tm.softBlue : tm.grey02,
            borderWidth: 2,
            child: TextN('오른쪽',
                fontSize: tm.s16, color: !isLeft ? tm.mainBlue : tm.grey04),
            onTap: (() {
              isLeft = false;
              setState(() {});
            })),
      ]),
    );
  }

  ///---------------------------------------------------------------------------
  /// 근육 리스트
  ///---------------------------------------------------------------------------
  Widget muscleList() {
    int idxStart = 0;
    int idxEnd = 0;
    //--------------------------------------------------------------------------
    // 팔
    if (muscleGroup == 0) {
      idxStart = 1;
      idxEnd = 4;
    }
    //--------------------------------------------------------------------------
    // 어깨
    else if (muscleGroup == 1) {
      idxStart = 5;
      idxEnd = 9;
    }
    //--------------------------------------------------------------------------
    // 가슴
    else if (muscleGroup == 2) {
      idxStart = 10;
      idxEnd = 13;
    }
    //--------------------------------------------------------------------------
    // 복부
    else if (muscleGroup == 3) {
      idxStart = 14;
      idxEnd = 15;
    }
    //--------------------------------------------------------------------------
    // 등
    else if (muscleGroup == 4) {
      idxStart = 16;
      idxEnd = 20;
    }
    //--------------------------------------------------------------------------
    // 엉덩이
    else if (muscleGroup == 5) {
      idxStart = 21;
      idxEnd = 22;
    }
    //--------------------------------------------------------------------------
    // 다리
    else if (muscleGroup == 6) {
      idxStart = 23;
      idxEnd = 27;
    }
    //--------------------------------------------------------------------------
    // 사용자
    else {
      //--------------------------------------------------------------------------
      // 이름 설정
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: asHeight(66),
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: asWidth(18)),
            color: tm.softBlue,
            child: TextN('사용자 정의 근육', fontSize: tm.s16, color: tm.mainBlue),
          ),
          asSizedBox(height: 10),
        ],
      );
    }
    //--------------------------------------------------------------------------
    // 근육선택
    return Container(
        height: asHeight(400),
        child: Column(
          children: List.generate(idxEnd - idxStart + 1,
              (index) => _basicMuscleBox(muscleTypeIndex: idxStart + index)),
        ));
  }

  ///---------------------------------------------------------------------------
  /// 근육 리스트
  ///---------------------------------------------------------------------------
  Widget _basicMuscleBox({int muscleTypeIndex = 0}) {
    bool isSelected = muscleListIndex == muscleTypeIndex;
    return Stack(
      alignment: Alignment.center,
      children: [
        //----------------------------------------------------------------------
        // 선택 버튼
        //----------------------------------------------------------------------
        InkWell(
          onTap: (() {
            muscleListIndex = muscleTypeIndex;
            setState(() {});
          }),
          child: Container(
            width: asWidth(360),
            height: asHeight(66),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color:
                    isSelected ? tm.softBlue : Colors.transparent,
                border: Border(bottom: BorderSide(color: tm.grey01, width: 1))),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: asWidth(18)),
              child: Row(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      //------------------------------------------------------------
                      // 근육 아이콘
                      ClipRRect(
                          borderRadius: BorderRadius.circular(asHeight(20)),
                          child: Transform(
                            alignment: Alignment.center,
                            transform: isLeft
                                ? Matrix4.rotationY(pi)
                                : Matrix4.rotationY(0),
                            child: Container(
                              color: tm.grey01,
                              height: asHeight(40),
                              width: asHeight(40),
                              child: muscleIcon(
                                  height: asHeight(40),
                                  muscleTypeIndex: muscleTypeIndex),
                            ),
                          )),
                      //------------------------------------------------------------
                      // 근육 이름
                      asSizedBox(width: 10),
                      TextN(
                        gv.setting.isMuscleNameKrPure.value == true
                            ? GvDef.muscleListKrPure[muscleTypeIndex]
                            : GvDef.muscleListKr[muscleTypeIndex],
                        // '${GvDef.muscleListKrPure[muscleTypeIndex]}'
                        // ' (${GvDef.muscleListKr[muscleTypeIndex]})',
                        fontSize: tm.s16,
                        color: isSelected ? tm.mainBlue: tm.grey04,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
        //----------------------------------------------------------------------
        // 상세보기 버튼
        //----------------------------------------------------------------------
        Container(
          width: asWidth(360),
          height: asHeight(66),
          // padding: EdgeInsets.symmetric(horizontal: asWidth(18)),
          alignment: Alignment.centerRight,
          child: InkWell(
            onTap: (() {}),
            borderRadius: BorderRadius.circular(asHeight(8)),
            child: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: asWidth(18), vertical: asHeight(23)),
              child: Image.asset(
                'assets/icons/ic_guide.png',
                height: asHeight(18),
                color: tm.softBlue,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

//==============================================================================
// 근육 아이콘
//==============================================================================
Widget muscleIcon({double height = 30, int muscleTypeIndex = 1}) {
  //--------------------------------------------------------
  // 근육 아이콘 이름
  String fileName = '';
  if (muscleTypeIndex == 1) {
    fileName = '01 손목 굽힘근';
  } else if (muscleTypeIndex == 2) {
    fileName = '02 손목 폄근';
  } else if (muscleTypeIndex == 3) {
    fileName = '03 위팔 두갈래근';
  } else if (muscleTypeIndex == 4) {
    fileName = '04 위팔 세갈래근';
  } else if (muscleTypeIndex == 5) {
    fileName = '05 앞 어깨세모근';
  } else if (muscleTypeIndex == 6) {
    fileName = '06 중간 어깨세모근';
  } else if (muscleTypeIndex == 7) {
    fileName = '07 뒤 어깨세모근';
  } else if (muscleTypeIndex == 8) {
    fileName = '08 가쪽 어깨돌림근';
  } else if (muscleTypeIndex == 9) {
    fileName = '09 안쪽 어깨돌림근';
  } else if (muscleTypeIndex == 10) {
    fileName = '10 위 큰가슴근';
  } else if (muscleTypeIndex == 11) {
    fileName = '11 중간 큰가슴근';
  } else if (muscleTypeIndex == 12) {
    fileName = '12 아래 큰가슴근';
  } else if (muscleTypeIndex == 13) {
    fileName = '13 앞 톱니근';
  } else if (muscleTypeIndex == 14) {
    fileName = '14 배곧은근';
  } else if (muscleTypeIndex == 15) {
    fileName = '15 배 바깥빗근';
  } else if (muscleTypeIndex == 16) {
    fileName = '16 위 등세모근';
  } else if (muscleTypeIndex == 17) {
    fileName = '17 중간 등세모근';
  } else if (muscleTypeIndex == 18) {
    fileName = '18 아래 등세모근';
  } else if (muscleTypeIndex == 19) {
    fileName = '19 넓은 등근';
  } else if (muscleTypeIndex == 20) {
    fileName = '20 척추세움근';
  } else if (muscleTypeIndex == 21) {
    fileName = '21 큰 볼기근';
  } else if (muscleTypeIndex == 22) {
    fileName = '22 중간 볼기근';
  } else if (muscleTypeIndex == 23) {
    fileName = '23 넙다리 네갈래근';
  } else if (muscleTypeIndex == 24) {
    fileName = '24 넙다리 뒤근';
  } else if (muscleTypeIndex == 25) {
    fileName = '25 모음근';
  } else if (muscleTypeIndex == 26) {
    fileName = '26 앞 정강근';
  } else if (muscleTypeIndex == 27){
    fileName = '27 장딴지근';
  }else{
    fileName = 'default1';
    // return Image.asset(
    //   'assets/muscle_icons/$fileName.png',
    //   height: height,
    //   fit: BoxFit.cover,
    //   color: tm.mainBlue,
    // );
  }

  return Image.asset(
    'assets/muscle_icons/$fileName.png',
    height: height,
    fit: BoxFit.cover,
  );
}

//==============================================================================
// 근육 번호를 그룹 넘버로 변경
//==============================================================================
int muscleIndexToGroupNumber({int muscleTypeIndex = 1}) {
  int groupNumber = 0;
  // 사용자
  if (muscleTypeIndex == 0) {
    groupNumber = 7;
  }
  // 팔
  else if (muscleTypeIndex <= 4) {
    groupNumber = 0;
  }
  // 어깨
  else if (muscleTypeIndex <= 9) {
    groupNumber = 1;
  }
  // 가슴
  else if (muscleTypeIndex <= 13) {
    groupNumber = 2;
  }
  // 복부
  else if (muscleTypeIndex <= 15) {
    groupNumber = 3;
  }
  // 등
  else if (muscleTypeIndex <= 20) {
    groupNumber = 4;
  }
  // 엉덩이
  else if (muscleTypeIndex <= 22) {
    groupNumber = 5;
  }
  // 다리
  else {
    groupNumber = 6;
  }

  return groupNumber;
}
