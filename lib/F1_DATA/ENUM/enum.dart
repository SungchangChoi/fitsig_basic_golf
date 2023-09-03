//------------------------------------------------------------------------------
// 기록 평가
//------------------------------------------------------------------------------
enum EmaAward {
  veryOver,
  over,
  great,
  good,
  notGood,
}

//------------------------------------------------------------------------------
// 근육 부위
//------------------------------------------------------------------------------
enum EmaMuscleType {
  none, //미 선택
  arm, //팔
  shoulder, //어깨
  breast, //가슴
  abdomen, //복부
  back, //등
  leg, //다리
  hip, //엉덩이
}

//------------------------------------------------------------------------------
// 근육
//------------------------------------------------------------------------------
enum EmaMuscle {
  m00User, //사용자 정의
  //----------------- 팔
  m01WristFlexor, //손목굽힘근
  m02WristExtensor, //손목 폄근
  m03Biceps, //이두근
  m04Triceps, //삼두근
  //----------------- 어깨
  m05FrontDeltoid, //전면삼각근
  m06MiddleDeltoid, //측면삼각근
  m07BackDeltoid, //후면삼각근
  m08ExternalRotator, //가쪽 어깨돌림근
  m09ExternalRotator, //안쪽 어깨돌림근
  //----------------- 가슴
  m10UpperPectoralis, //상부대흉근
  m11MiddlePectoralis, //중부대흉근
  m12LowerPectoralis, //하부대흉근
  m13SerratusAnterior, //앞톱니근
  //----------------- 복부
  m14RectusAbdominal, //복직근
  m15ExternalObliqueAbdominal, //배 바깥빗근
  //-----------------등
  m16UpperTrapezius, //상 승모근
  m17MiddleTrapezius, //중 승모근
  m18LowerTrapezius, //하 승모근
  m19LatissimusDorsi, //넓은 등근
  m20ErectorSpinae, //척추세움근
  //-----------------힙
  m21GluteusMaximus, //큰 볼기근
  m22GluteusMedius, //중간 볼기근
  //----------------- 다리
  m23QuadricepsFemoris, //대퇴사두근
  m24Hamstrings, //넙다리뒤근
  m25Adductor, //모음근
  m26TibialisAnterior, //앞 정강근
  m27Gastrocnemius, //장딴지근
}
//------------------------------------------------------------------------------
// 좌우
//------------------------------------------------------------------------------
enum EmaLeftRight{
  left,
  right,
}


//------------------------------------------------------------------------------
// 기록 평가
//------------------------------------------------------------------------------
enum EmaFirmwareStatus {
  noDevice, // 연결된 장비가 없음
  isUpdating, //FW 업데이트 중
  needUpdate, // FW 업데이트 필요
  upToDate, // 최신 FW 상태
}

//------------------------------------------------------------------------------
// 사운드 타입
//------------------------------------------------------------------------------
enum EmaSoundType {
  warning,
  targetSuccess,
  btConnect,
  btDisconnect,
  saveSuccess,
  update1Rm,
  measureStart,
  measureEnd,
}

// Map<String, String> exerciseToMuscle = {
//   // 펄
//   muscleTypeName(EmaMuscle.m01WristFlexor.index): '손목굽히기',
//   muscleTypeName(EmaMuscle.m02WristExtensor.index): '손목펴기, 수건비틀기',
//   muscleTypeName(EmaMuscle.m03Biceps.index): '팔굽히기, 암컬, 프리쳐 컬',
//   muscleTypeName(EmaMuscle.m04Triceps.index): '팔펴기, 덤벨 킥백, 푸쉬 업, 딥스',
//   // 어깨
//   muscleTypeName(EmaMuscle.m05FrontDeltoid.index): '팔 올리기, 숄더 프레스',
//   muscleTypeName(EmaMuscle.m06MiddleDeltoid.index): '팔 벌리기, 래터럴 레이즈',
//   muscleTypeName(EmaMuscle.m07BackDeltoid.index): '팔 벌리기, 리어 델토이드 플라이',
//   muscleTypeName(EmaMuscle.m08ExternalRotator.index): '팔돌리기, 익스터널 로테이션',
//   muscleTypeName(EmaMuscle.m09ExternalRotator.index): '인터널 로테이션',
//   // 가슴
//   muscleTypeName(EmaMuscle.m10UpperPectoralis.index):
//   '양손밀기, 디클라인 푸쉬업, 인클라인 프레스',
//   muscleTypeName(EmaMuscle.m11MiddlePectoralis.index): '양손밀기, 푸쉬업, 벤치프레스',
//   muscleTypeName(EmaMuscle.m12LowerPectoralis.index):
//   '양손밀기, 인클라인 푸쉬업, 디클라인 프레스',
//   muscleTypeName(EmaMuscle.m13SerratusAnterior.index): '팔펴고 푸쉬업, 바벨 풀오버',
//   // 복부
//   muscleTypeName(EmaMuscle.m14RectusAbdominal.index): '몸통굽히기, 플랭크',
//   muscleTypeName(EmaMuscle.m15ExternalObliqueAbdominal.index):
//   '옆으로 몸들기, 덤벨 사이드밴드',
//   //등
//   muscleTypeName(EmaMuscle.m16UpperTrapezius.index): '의자당기기, 슈러그',
//   muscleTypeName(EmaMuscle.m17MiddleTrapezius.index): '밴드 노젓기, W 레이즈',
//   muscleTypeName(EmaMuscle.m18LowerTrapezius.index): 'Y 레이즈',
//   muscleTypeName(EmaMuscle.m19LatissimusDorsi.index): '밴드 노젓기, 턱걸이, 랫풀다운',
//   muscleTypeName(EmaMuscle.m20ErectorSpinae.index): '상체들기, 굿모닝',
//   //힙
//   muscleTypeName(EmaMuscle.m21GluteusMaximus.index): '스쿼트, 다리 뒤로 들기, 데드리프트',
//   muscleTypeName(EmaMuscle.m22GluteusMedius.index): '다리벌리기, 힙업덕션',
//   //다리
//   muscleTypeName(EmaMuscle.m23QuadricepsFemoris.index): '다리펴기, 스쿼트',
//   muscleTypeName(EmaMuscle.m24Hamstrings.index): '다리굽히기, 레그컬',
//   muscleTypeName(EmaMuscle.m25Adductor.index): '다리모으기, 힙 어덕션',
//   muscleTypeName(EmaMuscle.m26TibialisAnterior.index): '장딴지 벽밀기, 다리 들기',
//   muscleTypeName(EmaMuscle.m27Gastrocnemius.index): '발등들기, 에버젼',
// };
