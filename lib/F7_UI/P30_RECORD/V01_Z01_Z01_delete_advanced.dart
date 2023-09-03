import '/F0_BASIC/common_import.dart';
import 'package:intl/intl.dart';

//==============================================================================
// 고급 삭제
//==============================================================================

Widget recordListDeleteAdvanced(BuildContext context) {
  return Container(
    width: Get.width * 0.8,
    //
    height: asHeight(400),
    // decoration: BoxDecoration(
    //     // color: Colors.green, //tm.grey02,
    //     borderRadius: BorderRadius.circular(30)),
    child: Column(
      children: [


        //----------------------------------------------------------------------
        // 제목
        Stack(
          alignment: AlignmentDirectional.center,
          children: [
            //----------------------------------------------------------------------
            // 제목
            Align(
              alignment: Alignment.center,
              child: SizedBox(
                width: asWidth(220),
                child: AutoSizeText(
                  '일괄 삭제',
                  style: TextStyle(
                    fontSize: tm.s20,
                    color: tm.grey04,
                    fontWeight: FontWeight.w600,

                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            //----------------------------------------------------------------------
            // 닫기 x 버튼
            Align(
              alignment: Alignment.centerRight,
              child: InkWell(
                borderRadius: BorderRadius.circular(asHeight(10)),
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
        asSizedBox(height: 8),
        dividerSmall(),
        asSizedBox(height: 8),
        TextN(
          '기록을 일괄 삭제할 수 있습니다. 한번 삭제가 되면 복구되지 않으니 주의하시기 바랍니다.',
          fontSize: tm.s15,
          color: tm.grey04,
        ),
        asSizedBox(height: 20),
        //----------------------------------------------------------------------
        // 날짜 지정
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextN(
                  '기준일',
                  fontSize: tm.s14,
                  color: tm.grey03,
                ),
                asSizedBox(height: 8),
                Obx(
                  () => TextN(
                    //'2022.01.01',
                    '${gvRecord.yearOfDeleteRecord.value}.'
                    '${gvRecord.monthOfDeleteRecord.value}.'
                    '${gvRecord.dayOfDeleteRecord.value}',
                    fontSize: tm.s20,
                    color: tm.black,
                  ),
                ),
              ],
            ),
            textButtonG(
              width: asWidth(54),
              touchWidth: asWidth(74),
              height: asHeight(36),
              touchHeight: asHeight(56),
              title: '변경',
              fontSize: tm.s16,
              onTap: (() async {
                // openPopupBasic(
                //   DateSpinnerPicker(
                //     onSelected: (results) {
                //       gvRecord.yearOfDeleteRecord.value = results[0];
                //       gvRecord.monthOfDeleteRecord.value = results[1];
                //       gvRecord.dayOfDeleteRecord.value = results[2];
                //     },
                //   ),
                // );
                int pickedDateAsInt = 0;
                DateTime today = DateTime.now();
                DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: today,
                    firstDate: today.subtract(const Duration(days: 365)),
                    lastDate: today,
                    builder: (context, child) {
                      return Theme(
                        data: Theme.of(context).copyWith(
                          dialogTheme: DialogTheme(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                          ),
                        ),
                        child: child!,
                      );
                    });

                if (pickedDate != null) {
                  gvRecord.yearOfDeleteRecord.value =
                      int.parse(DateFormat('yyyy').format(pickedDate));
                  gvRecord.monthOfDeleteRecord.value =
                      int.parse(DateFormat('MM').format(pickedDate));
                  gvRecord.dayOfDeleteRecord.value =
                      int.parse(DateFormat('dd').format(pickedDate));
                }
                // print(
                //     'V01_Z01_Z01_delete_advanced :: pieckedDate year=${gvRecord.yearOfDeleteRecord.value} month=${gvRecord.monthOfDeleteRecord.value} day=${gvRecord.dayOfDeleteRecord.value}');
              }),
            ),
          ],
        ),
        asSizedBox(height: 30),
        //----------------------------------------------------------------------
        // 이전날짜 모두 삭제
        textButtonG(
          width: double.infinity,
          height: asHeight(36),
          touchWidth: double.infinity,
          touchHeight: asHeight(56),
          title: '기준일 이전 모두 삭제',
          fontSize: tm.s16,
          onTap: (() {
            openPopupBasic(
              SizedBox(
                width: Get.width * 0.6,
                height: asHeight(180),
                child: Column(
                  children: [
                    //------------------------
                    // 제목 및 닫기 버튼
                    //------------------------
                    Stack(
                      alignment: AlignmentDirectional.center,
                      children: [
                        //------------------------
                        // 제목
                        Align(
                          alignment: Alignment.center,
                          child: SizedBox(
                            width: asWidth(220),
                            child: AutoSizeText(
                              '삭제 확인',
                              style: TextStyle(
                                fontSize: tm.s20,
                                color: tm.grey04,
                                fontWeight: FontWeight.w600,

                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        //------------------------
                        // 닫기 버튼
                        Align(
                          alignment: Alignment.centerRight,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(asHeight(10)),
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

                    //------------------------
                    // 본문 ( 텍스트 및 버튼 )
                    //------------------------
                    dividerSmall(),
                    asSizedBox(height: 8),
                    TextN(
                      '정말 삭제 하시겠습니까?',
                      fontSize: tm.s15,
                      color: tm.grey04,
                    ),
                    asSizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        textButtonG(
                            title: '확인',
                            width: asWidth(80),
                            height: asHeight(40),
                            touchWidth: asWidth(90),
                            touchHeight: asHeight(50),
                            fontSize: tm.s16,
                            onTap: (){
                              int result=0; // 삭제된 측정 데이터 수
                              int listTotalNum = gv.dbRecordIndexes.length;
                              // 설정 된 기준 날짜를 8자리 날짜 형식으로 변경
                              int refDate = gvRecord.yearOfDeleteRecord.value * 10000 +
                                  gvRecord.monthOfDeleteRecord.value * 100 +
                                  gvRecord.dayOfDeleteRecord.value;
                              // print('기준 날짜 : $refDate');
                              for (int n = 0; n < listTotalNum; n++) {
                                //-------------------------------------------------------------
                                // 현재 선택된 근육 관련 기록에 대해
                                if (gv.dbRecordIndexes[n].idxMuscle ==
                                    gv.control.idxMuscle.value) {
                                  //----------------------------------------------
                                  // 비교 할 날짜 읽기
                                  DateTime date = gv.dbRecordIndexes[n].startTime;
                                  int recodeDate =
                                      date.year * 10000 + date.month * 100 + date.day;
                                  // print('관련 근육 모든 날짜 : $n ${recodeDate}');
                                  //----------------------------------------------
                                  // 삭제하기 - 기준날짜보다 작은 경우 (기준날짜 과거 데이터)
                                  if (recodeDate < refDate) {
                                    // print('기준 이전 날짜 : $n ${recodeDate}');
                                    deleteRecordData(n);
                                    result++;
                                  }
                                }
                              }
                              Get.back();
                              Get.back();
                              if(result == 0){
                                openSnackBarBasic(
                                    '측정 데이터 삭제', '선택한 날짜 이전의 측정 데이터가 없습니다.''');
                              }else {
                                openSnackBarBasic(
                                    '측정 데이터 삭제', '$result 개의 측정 데이터가 삭제 되었습니다');
                              }

                            },
                        ),
                        textButtonG(
                            title: '취소',
                            width: asWidth(80),
                            height: asHeight(40),
                            touchWidth: asWidth(90),
                            touchHeight: asHeight(50),
                            fontSize: tm.s16,
                            onTap: ((){
                              Get.back();
                            })
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // backgroundColor: tm.green,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(asWidth(20)),
              ),
            );
          }),
        ),

        //----------------------------------------------------------------------
        // 이후날짜 모두 삭제
        asSizedBox(height: 10),
        textButtonG(
            width: double.infinity,
            height: asHeight(36),
            touchWidth: double.infinity,
            touchHeight: asHeight(56),
            fontSize: tm.s16,
            title: '기준일 이후 모두 삭제',
            onTap: (() {
              openPopupBasic(
                SizedBox(
                  width: Get.width * 0.6,
                  height: asHeight(180),
                  child: Column(
                    children: [
                      //------------------------
                      // 제목 및 닫기 버튼
                      //------------------------
                      Stack(
                        alignment: AlignmentDirectional.center,
                        children: [
                          //------------------------
                          // 제목
                          Align(
                            alignment: Alignment.center,
                            child: SizedBox(
                              width: asWidth(220),
                              child: AutoSizeText(
                                '삭제 확인',
                                style: TextStyle(
                                  fontSize: tm.s20,
                                  color: tm.grey04,
                                  fontWeight: FontWeight.w600,

                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          //------------------------
                          // 닫기 버튼
                          Align(
                            alignment: Alignment.centerRight,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(asHeight(10)),
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

                      //------------------------
                      // 본문 ( 텍스트 및 버튼 )
                      //------------------------
                      dividerSmall(),
                      asSizedBox(height: 8),
                      TextN(
                        '정말 삭제 하시겠습니까?',
                        fontSize: tm.s15,
                        color: tm.grey04,
                      ),
                      asSizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          textButtonG(
                            title: '확인',
                            width: asWidth(80),
                            height: asHeight(40),
                            touchWidth: asWidth(90),
                            touchHeight: asHeight(50),
                            fontSize: tm.s16,
                            onTap: (){
                              int result = 0; // 삭제된 측정 데이터 수
                              int listTotalNum = gv.dbRecordIndexes.length;
                              // 설정 된 기준 날짜를 8자리 날짜 형식으로 변경
                              int refDate = gvRecord.yearOfDeleteRecord.value * 10000 +
                                  gvRecord.monthOfDeleteRecord.value * 100 +
                                  gvRecord.dayOfDeleteRecord.value;
                              for (int n = 0; n < listTotalNum; n++) {
                                //-------------------------------------------------------------
                                // 현재 선택된 근육 관련 기록에 대해
                                if (gv.dbRecordIndexes[n].idxMuscle ==
                                    gv.control.idxMuscle.value) {
                                  //----------------------------------------------
                                  // 비교 할 날짜 읽기
                                  DateTime date = gv.dbRecordIndexes[n].startTime;
                                  int recodeDate =
                                      date.year * 10000 + date.month * 100 + date.day;
                                  //----------------------------------------------
                                  // 삭제하기 - 기준날짜보다 큰 경우 (기준날짜 미리 데이터)
                                  if (recodeDate > refDate) {
                                    deleteRecordData(n);
                                    result++;
                                  }
                                }
                              }
                              Get.back();
                              Get.back();
                              if(result == 0){
                                openSnackBarBasic(
                                    '측정 데이터 삭제', '선택한 날짜 이후의 측정 데이터가 없습니다.''');
                              }else {
                                openSnackBarBasic(
                                    '측정 데이터 삭제', '$result 개의 측정 데이터가 삭제 되었습니다');
                              }
                            },
                          ),
                          textButtonG(
                              title: '취소',
                              width: asWidth(80),
                              height: asHeight(40),
                              touchWidth: asWidth(90),
                              touchHeight: asHeight(50),
                              fontSize: tm.s16,
                              onTap: ((){
                                Get.back();
                              })
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // backgroundColor: tm.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(asWidth(20)),
                ),
              );
            })),
      ],
    ),
  );
}
