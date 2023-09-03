import '/F0_BASIC/common_import.dart';

part 'gv_db_record.g.dart';

// flutter pub run build_runner build
// 아래와 같은 에러 뜰 경우 pubspec.lock 지우고 다시 pub get 할 것
// type 'UnspecifiedInvalidResult' is not a subtype of type 'LibraryElementResult' in type cast

//==============================================================================
// 인덱스 데이터 - 리스트에 보여지는 간단한 항목들
// ex : 근육이름, 제목, 시간, 코멘트 등...
// 항목에 따라 장비 수에 따라 늘려서 생성
//==============================================================================
@JsonSerializable()
class DbRecordIndex {
  DbRecordIndex();

  //----------------------------------------------------------------------------
  // 기본 정보 - 장비 공통 사항들 (운동명, 시간, 회원이름 등)
  //----------------------------------------------------------------------------
  DateTime startTime = DateTime(2022);
  DateTime endTime = DateTime(2022);
  int exerciseTime = 0;

  //----------------------------------------------------------------------------
  // 장비별 정보 - basic 은 1개이므로... : 이 정보는 상세 데이터와 일부 중첩될 수 있음
  // 다른 버전의 경우 필요에 따라 디바이스 숫자만큼 생성
  //----------------------------------------------------------------------------
  int idxMuscle = 0;
  String muscleName = '근육이름';
  int muscleTypeIndex = 0;
  bool isLeft = false;
  int targetPrm = 70; //힘 목표 (0~100%)
  int targetCount = 10; //목표 반복 횟수

  double mvcMv = 0.1; //실제 적용된 최대근력 전압 (측정 최대근력보다 크거나 같음)
  double aoeSet = 0; //세트 운동량

  double greatestEverMvcMv = 0.0; // 측정근력 역대 최댓값(2023.04.03 추가)
  bool isEcgEmpty=true;   // 심전도 데이터 기록이 있는지 표시하는 플래그

  //----------------------------------------------------------------------------
  // json 자동 직렬화
  // 변수가 변하면, 터미널 창에서 flutter pub run build_runner build
  //----------------------------------------------------------------------------
  // factory DbRecordIndex.fromJson(Map<String, dynamic> json) =>
  //     _$DbRecordIndexFromJson(json);
  //----------------------------------------------------------------------------
  // json  수동 직렬화 : dB 변화에 대응
  //----------------------------------------------------------------------------
  DbRecordIndex.fromJson(Map<String, dynamic> json)
      : startTime = DateTime.parse(json['startTime'] as String),
        endTime = DateTime.parse(json['endTime'] as String),
        exerciseTime = json['exerciseTime'] as int,
        idxMuscle = json['idxMuscle'] as int,
        muscleName = json['muscleName'] as String,
        muscleTypeIndex = json['muscleTypeIndex'] as int,
        //신규 추가 변수
        isLeft = json['isLeft'] == null ? false : json['isLeft'] as bool,
        targetPrm = json['targetPrm'] as int,
        targetCount = json['targetCount'] as int,
        mvcMv = (json['mvcMv'] as num).toDouble(),
        aoeSet = (json['aoeSet'] as num).toDouble(),
        greatestEverMvcMv = json['greatestEverMvcMv'] == null
            ? 0.0
            : (json['greatestEverMvcMv'] as num).toDouble(),
        isEcgEmpty = json['isEcgEmpty'] == null ? false : json['isEcgEmpty'] as bool;


  Map<String, dynamic> toJson() => _$DbRecordIndexToJson(this);
}

//==============================================================================
// 기록 데이터  상세 내용 - 개별 읽기에 활용 - 데이터가 중복되지 않게
// 장비 수에 따라 늘려서 생성
//==============================================================================
@JsonSerializable()
class DbRecordContents {
  DbRecordContents();

  //----------------------------------------------------------------------------
  // 분석 정보
  //----------------------------------------------------------------------------
  //------------------- 최대근력
  // double mvcMv = 0.1; //실제 적용된 최대근력 전압 (측정 최대근력보다 크거나 같음)
  double measureMvcMv = 0.1; //측정된 최대근력 전압
  //------------------- 근활성도
  double emgTimeMax = 0; //최대 근활성도 (시간 방식)
  double emgTimeAv = 0; //평균 근활성도 (시간 방식)
  double emgCountMax = 0; //최대 근활성도 (카운트 방식)
  double emgCountAv = 0; //평균 근활성도 (카운트 방식)
  //------------------- 운동량
  // double aoeSet = 0; //세트 운동량
  double aoeTarget = 0; //세트 목표 운동량
  //------------------- 반복 횟수
  int repetition = 0; //측정된 반복횟수
  int repetitionTargetSuccess = 0; //목표 성공 횟수
  //------------------- 주파수
  double freqBegin = 0;
  double freqEnd = 0;

  //----------------------------------------------------------------------------
  // 근전도 파형
  //----------------------------------------------------------------------------
  List<double> emgData = []; //소수점 제한하여 직렬화 필요
  List<double> emgTime = []; //소수점 제한하여 직렬화 필요
  List<double> markTime = []; //마크 시간
  List<double> markValue = []; //마크 값
  List<EmlTargetResult> targetResult = []; //목표 결과

  //----------------------------------------------------------------------------
  // 전극 접촉 품질
  //----------------------------------------------------------------------------
  List<double> electrodeContactData = []; //전극 접촉 데이터
  List<double> isExBufferCleared = []; //버퍼 클리어 여부 데이터
  double endTime = 0;
  double electrodeContactMax = 0; //접촉 품질 최대 값
  int exCntDetach = 0; //전극 분리 횟수
  double exTimeDetached = 0; //전극 분리 시간
  int exCntExternal = 0; //무선 손실 예외 횟수
  double exTimeFake = 0; //가짜 신호 시간

  //----------------------------------------------------------------------------
  // 심전도 데이터
  //----------------------------------------------------------------------------
  List<double> ecgData = []; //심전도 데이터
  List<double> ecgCountTime = []; //심전도 카운트 시간

  double ecgHeartRateMax = 0; //최대 심박 수
  double ecgHeartRateMin = 0; //최저 심박 수
  double ecgHeartRateAv = 0; //평균 심박 수

  //----------------------------------------------------------------------------
  // json 자동 직렬화
  // 변수가 변하면, 터미널 창에서 flutter pub run build_runner build
  // 새로 추가된 변수를 고려한 null 처리
  //----------------------------------------------------------------------------
  // factory DbRecordContents.fromJson(Map<String, dynamic> json) =>
  //     _$DbRecordContentsFromJson(json);

  DbRecordContents.fromJson(Map<String, dynamic> json)
      : measureMvcMv = (json['measureMvcMv'] as num).toDouble(),
        emgTimeMax = (json['emgTimeMax'] as num).toDouble(),
        emgTimeAv = (json['emgTimeAv'] as num).toDouble(),
        emgCountMax = (json['emgCountMax'] as num).toDouble(),
        emgCountAv = (json['emgCountAv'] as num).toDouble(),
        aoeTarget = (json['aoeTarget'] as num).toDouble(),
        repetition = json['repetition'] as int,
        repetitionTargetSuccess = json['repetitionTargetSuccess'] as int,
        freqBegin = (json['freqBegin'] as num).toDouble(),
        freqEnd = (json['freqEnd'] as num).toDouble(),
        emgData = (json['emgData'] as List<dynamic>)
            .map((e) => (e as num).toDouble())
            .toList(),
        emgTime = (json['emgTime'] as List<dynamic>)
            .map((e) => (e as num).toDouble())
            .toList(),
        markTime = (json['markTime'] as List<dynamic>)
            .map((e) => (e as num).toDouble())
            .toList(),
        markValue = (json['markValue'] as List<dynamic>)
            .map((e) => (e as num).toDouble())
            .toList(),
        targetResult = (json['targetResult'] as List<dynamic>)
            .map((e) => $enumDecode(_$EmlTargetResultEnumMap, e))
            .toList(),
        electrodeContactData = json['electrodeContactData'] == null
            ? [0, 0]
            : (json['electrodeContactData'] as List<dynamic>)
                .map((e) => (e as num).toDouble())
                .toList(),
        isExBufferCleared = json['isExBufferCleared'] == null
            ? [0, 0]
            : (json['isExBufferCleared'] as List<dynamic>)
                .map((e) => (e as num).toDouble())
                .toList(),
        endTime =
            json['endTime'] == null ? 1 : (json['endTime'] as num).toDouble(),
        electrodeContactMax = json['electrodeContactMax'] == null
            ? 0
            : (json['electrodeContactMax'] as num).toDouble(),
        exCntDetach =
            json['exCntDetach'] == null ? 0 : json['exCntDetach'] as int,
        exTimeDetached = json['exTimeDetached'] == null
            ? 0
            : (json['exTimeDetached'] as num).toDouble(),
        exCntExternal =
            json['exCntExternal'] == null ? 0 : json['exCntExternal'] as int,
        exTimeFake = json['exTimeFake'] == null
            ? 0
            : (json['exTimeFake'] as num).toDouble(),
        //------------------------
        // 심전도 데이터
        ecgData = json['ecgData'] == null
            ? []
            : (json['ecgData'] as List<dynamic>)
                .map((e) => (e as num).toDouble())
                .toList(),
        ecgCountTime = json['ecgCountTime'] == null
            ? []
            : (json['ecgCountTime'] as List<dynamic>)
                .map((e) => (e as num).toDouble())
                .toList(),
        ecgHeartRateMax = json['ecgHeartRateMax'] == null
            ? 0
            : (json['ecgHeartRateMax'] as num).toDouble(),
        ecgHeartRateMin = json['ecgHeartRateMin'] == null
            ? 0
            : (json['ecgHeartRateMin'] as num).toDouble(),
        ecgHeartRateAv = json['ecgHeartRateAv'] == null
            ? 0
            : (json['ecgHeartRateAv'] as num).toDouble();

  Map<String, dynamic> toJson() => _$DbRecordContentsToJson(this);
}

//==============================================================================
// map 데이터를 class 데이터로 변환 (처리 편리 목적)
//==============================================================================
void indexMapToRecordIndexObject(int index) {
  if (gv.dbmRecord.indexData.isNotEmpty) {
    gv.dbRecordIndexes[index] =
        DbRecordIndex.fromJson(gv.dbmRecord.indexData[index]);
  }
}

void contentsMapToRecordContentsObject() {
  if (gv.dbmRecord.contentsData.isNotEmpty) {
    gv.dbRecordContents = DbRecordContents.fromJson(gv.dbmRecord.contentsData);
  }
}
