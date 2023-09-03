import '/F0_BASIC/common_import.dart';
import 'package:intl/intl.dart';

// -----------------------------------------------------------------------------
// 임의의 DbMuscleContents 를 생성  (통계 그래프 테스트 용)
// -----------------------------------------------------------------------------
// 데이터 내보내기 테스를 위해 근육 index 의 수만큼 생성하도록 수정

void generateDbMuscleContents(
    {required DateTime startDate, DateTime? endDate}) async {
  // 이 메소드에서 생성할 data 초기화
  DbMuscleContents result = DbMuscleContents();
  Random rand = Random();

  // 생성한 랜덤 통계값을 저장하는 변수
  double mvcLevelMax;
  int exerciseTime;
  double aoeSet;
  double aoeTarget;

  // 입력 받은 시작로 부터 마지막 날(입력없으면 오늘)까지 몇일 차이 인지 계산
  int dateDifference;
  if (endDate != null) {
    dateDifference = endDate.difference(startDate).inDays;
  } else {
    dateDifference = (DateTime.now()).difference(startDate).inDays;
  }

  // print('gen_dbMuscle_contents.dart :: dateDifference = $dateDifference' );

  // 기간 동안 일자별로 통계값 생성
  for (int index = 0; index < dateDifference; index++) {
    int date = int.parse(
        DateFormat('yyyyMMdd').format(startDate.add(Duration(days: index))));
    result.dateStats.add(date); // YYYYMMDD 8자리 날짜. (예, 20220818)
    result.recordNumStats.add(rand.nextInt(7)+1);

    result.mvcMvMaxStats.add(rand.nextDouble() * 100);        // 0~100 사이의 랜덤값
    result.measuredMvcMvMaxStats.add(rand.nextDouble()*100);  // 0~100 사이의 랜덤값
    result.measuredMvcMvAccStats.add(rand.nextDouble()*100);  // 0~100 사이의 랜덤값

    result.exerciseTimeAccStats.add(rand.nextInt(28800));  // 하루 최대 8시간 운동을 가정. 8시간은 28800 초

    result.aoeSetAccStats.add(rand.nextDouble() * 100);    // 0~100 사이의 랜덤값
    result.aoeTargetAccStats.add(rand.nextDouble() * 100); // 0~100 사이의 랜덤값

    result.freqBeginAccStats.add(rand.nextDouble()*100);   // 0~100 사이의 랜덤값
    result.freqEndAccStats.add(rand.nextDouble()*100);     // 0~100 사이의 랜덤값

    result.emgCountMaxStats.add(rand.nextDouble()*100);    // 0~100 사이의 랜덤값
    result.emgCountAvAccStats.add(rand.nextDouble()*100);  // 0~100 사이의 랜덤값
    result.emgTimeMaxStats.add(rand.nextDouble()*100);     // 0~100 사이의 랜덤값
    result.emgTimeAvAccStats.add(rand.nextDouble()*100);   // 0~100 사이의 랜덤값

    result.repetitionAccStats.add(rand.nextInt(500));
    result.repetitionTargetAccStats.add(rand.nextInt(500));
  }
  // gv 에 있는 dbMuscleContents 에 입력
  // print('gen_dbmuscle_contents.dart :: mvcLevelMaxStats = ${result.mvcLevelMaxStats}' );
  gv.dbMuscleContents = result;
  await gv.dbmMuscle.updateData( index: 0,
      indexMap: gv.dbMuscleIndexes[0].toJson(),
      contentsMap: gv.dbMuscleContents.toJson());
}
