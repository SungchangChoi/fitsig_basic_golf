import '/F0_BASIC/common_import.dart';
import 'package:intl/intl.dart';


//==============================================================================
// bottom sheet
//==============================================================================
openBottomSheetStatsDelete() {
  openBottomSheetBasic(
    height: asHeight(300),
    child: const StatsDeletePopup(),
    enableDrag: false,
  );
}

//==============================================================================
// 기록 삭제 팝업 페이지
//==============================================================================
class StatsDeletePopup extends StatefulWidget {
  const StatsDeletePopup({Key? key}) : super(key: key);

  @override
  State<StatsDeletePopup> createState() => _StatsDeletePopupState();
}

enum DateType { startDate, endDate }

class _StatsDeletePopupState extends State<StatsDeletePopup> {
  int _startDateAsInt = 0; // 삭제 시작 날짜
  int _endDateAsInt = 0; // 삭제 종료 날짜

  // int _startYear = 0;
  // int _startMonth = 0;
  // int _startDay = 0;
  // int _endYear = 0;
  // int _endMonth = 0;
  // int _endDay = 0;

  // double textFormWidth = asWidth(110);
  // double textFormHeight = asHeight(40);

  // List<int> dayList = List.generate(31, (index) => index + 1);
  // List<int> monthList = List.generate(12, (index) => index + 1);
  // List<int> yearList = List.generate(100, (index) => index + 1970);

  @override
  void initState() {
    // _startYear = _startDateAsInt ~/ 10000;
    // _startMonth = (_startDateAsInt % 10000) ~/ 100;
    // _startDay = _startDateAsInt % 100;
    //
    // _endYear = _startYear;
    // _endMonth = _startMonth;
    // _endDay = _startDay;

    // print(
    //     'V02_Z02_stats_deletion.dart :: 초기 _startYear=$_startYear, _startMonth=$_startMonth, _startDay=$_startDay');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //--------------------------------------------------------------------
        // head
        //--------------------------------------------------------------------
        _head(),
        asSizedBox(height: 10),
        // dividerSmall(),
        //--------------------------------------------------------------------
        // Main
        //--------------------------------------------------------------------
        asSizedBox(height: 10),
        _main(),
        //--------------------------------------------------------------------
        // 하단 확인 버튼
        //--------------------------------------------------------------------
        asSizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            textButtonG(
              title: '삭제',
              width: asWidth(100),
              height: asHeight(40),
              touchWidth: asWidth(120),
              touchHeight: asHeight(60),
              onTap: (() async {
                if (_startDateAsInt <= _endDateAsInt && _startDateAsInt != 0 && _endDateAsInt!= 0 ) {
                  int result = await deleteStatsData(_startDateAsInt, _endDateAsInt);
                  Get.back();
                  if(result == 0){
                    openSnackBarBasic(
                        '통계 데이터 삭제', '선택한 날짜 구간에 해당하는 통계 데이터가 없습니다.''');
                  }else {
                    openSnackBarBasic(
                        '통계 데이터 삭제', '$result 개의 통계 데이터가 삭제 되었습니다');
                  }
                }
                else{
                  openSnackBarBasic('날짜 오류', '통계에서 삭제하고자 하는 날짜를 정확히 입력해주세요 .');
                }
              })
            ),
            textButtonG(
                title: '취소',
                width: asWidth(100),
                height: asHeight(40),
                touchWidth: asWidth(120),
                touchHeight: asHeight(60),
                onTap: ((){
                  Get.back();
                })
            ),

            // _button(),
            // asSizedBox(width: 50),
            // _cancelButton(),
          ],
        ),
      ],
    );
  }

  //==============================================================================
  // head
  //==============================================================================
  Widget _head() {
    return Container(
      // 여유공간
      margin: EdgeInsets.only(
          top: asHeight(20)),
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          //----------------------------------------------------------------------
          // 제목
          Align(
            alignment: Alignment.center,
            child: SizedBox(
              width: asWidth(220),
              child: Center(
                child: AutoSizeText(
                  '통계 데이터 삭제',
                  maxLines: 2,
                  style: TextStyle(
                    fontSize: tm.s20,
                    color: tm.grey04,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
          //----------------------------------------------------------------------
          // 닫기 x 버튼
          Align(
            alignment: Alignment.centerRight,
            child: InkWell(
              borderRadius: BorderRadius.circular(asHeight(12)),
              onTap: (() {
                Get.back();
              }),
              child: Container(
                width: asWidth(72),
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
  // 메인내용
  //----------------------------------------------------------------------------
  Widget _main() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: asWidth(18)),
      child: Column(
        children: [
          TextN(
            '시작일과 종료일을 선택하여 통계 데이터를 삭제할 수 있습니다.',
            fontSize: tm.s16,
            height: 1.5,
            color: tm.black,
          ),
          asSizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _dateSelectionPopupButton(DateType.startDate, MainAxisAlignment.end),
              SizedBox(width: asWidth(2)),
              TextN(
                ' ~ ',
                fontSize: tm.s16,
              ),
              SizedBox(width: asWidth(2)),
              _dateSelectionPopupButton(DateType.endDate, MainAxisAlignment.start),
            ],
          ),
        ],
      ),
    );
  }

  //----------------------------------------------------------------------------
  // 날자 선택창 팝업 확인 버튼
  //----------------------------------------------------------------------------
  Widget _dateSelectionPopupButton(DateType type, MainAxisAlignment mainAxisAlignment) {

    String startDateFormalText = '시작일';
    String endDateFormalText = '종료일';

    if(_startDateAsInt != 0) {
      startDateFormalText = convertToFormalText(_startDateAsInt);
    }
    if(_endDateAsInt != 0) {
      endDateFormalText = convertToFormalText(_endDateAsInt);
    }

    return InkWell(
      borderRadius: BorderRadius.circular(asWidth(10)),
      child: Container(
        // alignment: Alignment.center,
        width: asWidth(150),
        height: asHeight(50),
        // decoration: BoxDecoration(
        //     borderRadius: BorderRadius.circular(asHeight(10)),
        //     border: Border.(
        //         width: asWidth(1), color: tm.grey05.withOpacity(0.3))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextN(
              type == DateType.startDate ? startDateFormalText : endDateFormalText,
              fontSize: tm.s16,
              color: tm.black,
            ),
            SizedBox(width: asWidth(5)),
            Icon(Icons.calendar_month, color:tm.mainBlue, size:tm.s20),
          ],
        ),
      ),
      onTap: () async {
        DateTime today = DateTime.now();
        // 저장되어있는 데이터의 첫날
        //int firstDateAsInt = gv.dbMuscleContents.dateStats.first;
        int firstDateAsInt = 20220101;
        DateTime firstDate = DateTime(firstDateAsInt ~/ 10000,
            (firstDateAsInt % 10000) ~/ 100, firstDateAsInt % 100);
        DateTime lastDate = today;
        DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: today,
            firstDate: firstDate,
            lastDate: lastDate,
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
          if (type == DateType.startDate) {
            setState(() {
              _startDateAsInt =
                  int.parse(DateFormat('yyyyMMdd').format(pickedDate));
            });
          } else {
            setState(() {
              _endDateAsInt =
                  int.parse(DateFormat('yyyyMMdd').format(pickedDate));
            });
          }
        }
        print(
            'V02_Z02_stats_deletion.dart :: startDate=$_startDateAsInt, endDate=$_endDateAsInt');
      },
    );
  }

//----------------------------------------------------------------------------
// 확인 버튼
//----------------------------------------------------------------------------
//   Widget _button() {
//     return InkWell(
//       child: Container(
//         alignment: Alignment.center,
//         width: asWidth(100),
//         height: asHeight(40),
//         decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(asHeight(18)),
//             border:
//                 Border.all(width: asWidth(1), color: tm.blue.withOpacity(0.3))),
//         child: TextN(
//           '확인',
//           fontSize: tm.s16,
//           color: tm.blue,
//         ),
//       ),
//       onTap: () async {
//         if (_startDateAsInt <= _endDateAsInt && _startDateAsInt != 0 && _endDateAsInt!= 0 ) {
//           int result = await deleteStatsData(_startDateAsInt, _endDateAsInt);
//           openSnackBarBasic('통계 데이터 삭제', '$result 개의 통계 데이터가 삭제 되었습니다');
//           print('result = $result 개의 통계 데이터 삭제됨');
//
//           Get.back();
//         }
//         else{
//           openSnackBarBasic('날짜 오류', '통계에서 삭제하고자 하는 날짜를 정확히 입력해주세요 .');
//         }
//       },
//     );
//   }

//----------------------------------------------------------------------------
// 취소 버튼
//----------------------------------------------------------------------------
//   Widget _cancelButton() {
//     return InkWell(
//       child: Container(
//         alignment: Alignment.center,
//         width: asWidth(100),
//         height: asHeight(40),
//         decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(asHeight(18)),
//             border:
//                 Border.all(width: asWidth(1), color: tm.blue.withOpacity(0.3))),
//         child: TextN(
//           '취소',
//           fontSize: tm.s16,
//           color: tm.blue,
//         ),
//       ),
//       onTap: () {
//         Get.back();
//       },
//     );
//   }

//----------------------------------------------------------------------------
// 통계 데이터 삭제 메소드
//----------------------------------------------------------------------------
  Future<int> deleteStatsData(int startDate, int endDate) async {
    int date = startDate;
    int result = 0; // 삭제 되는 데이터 수
    while (date <= endDate) {
      // print('V02_Z02_stats_deletion.dart :: deleteStatsData : 삭제하려는 날짜는 $date');
      bool removeContentsResult = gv.dbMuscleContents.removeContents(date);
      int _year = date ~/ 10000;
      int _month = (date % 10000) ~/ 100;
      int _day = date % 100;
      int nextDate = int.parse(
          DateFormat('yyyyMMdd').format(DateTime(_year, _month, _day + 1)));
      date = nextDate;
      if(removeContentsResult == true){
        result++;
      }
    }

    //--------------------------------------------------------------------------
    // 근육 데이터 베이스 DB에 저장
    //--------------------------------------------------------------------------
    // 메모리에서 삭제가 끝났으므로, contents DB 업데이트
    await gv.dbmMuscle.updateData(
        index: gv.control.idxMuscle.value,
        indexMap: gv.dbMuscleIndexes[gv.control.idxMuscle.value].toJson(),
        contentsMap: gv.dbMuscleContents.toJson());

    //--------------------------------------------------------------------------
    // 통계 그래프에 사용되는 데이터 업데이트
    //--------------------------------------------------------------------------
    await updateGraphData(timePeriod: gvRecord.graphTimePeriod.value);
    gvRecord.graphDataUpdateCount.value++;

    return result;
  }

  String convertToFormalText(int dateAsInt){
    String result;
    int year = dateAsInt~/10000;
    int month = (dateAsInt%10000)~/100;
    int day = dateAsInt%100;
    return result = '$year년 $month월 $day일';
  }
}
