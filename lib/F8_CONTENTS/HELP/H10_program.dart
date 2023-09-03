import 'package:fitsig_basic_golf/F0_BASIC/common_import.dart';

//==============================================================================
// 도움말 - 운동 프로그램
//==============================================================================
Widget helpAboutProgram() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        padding: EdgeInsets.symmetric(
            horizontal: asWidth(18), vertical: asHeight(20)),
        decoration: BoxDecoration(
          color: tm.mainBlue,
        ),
        width: double.infinity,
        child: textNormal(
          '운동 초기에는 근신경이 발달하면서 근전도 신호가 커지며,'
              ' 개인차가 있지만 대략 3~6개월 정도 꾸준히 운동하면 근육의 부피증가를 볼 수 있습니다. ',
          fontColor: tm.fixedWhite,
          fontSize: tm.s14,
        ),
      ),
      SizedBox(height: asHeight(18)),
      Container(
        margin: EdgeInsets.symmetric(horizontal: asWidth(18)),
        padding: EdgeInsets.symmetric(
            horizontal: asWidth(12), vertical: asHeight(20)),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(asHeight(8)),
          color: tm.grey01,
        ),
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextN(
              '초보자의 운동 프로그램',
              fontSize: tm.s14,
              color: tm.black,
              fontWeight: FontWeight.w900,
            ),
            SizedBox(height: asHeight(12)),
            textNormal(
              '주 2~3회, 각 근육별 2~5세트로 구성하는 것이 일반적입니다.'
                  ' 운동 할 근육을 정한 후 가이드에서 제공하는 운동방법 중 각자의 환경에 맞은 방식으로 운동을 진행하세요.',
              fontColor: tm.black,
              fontSize: tm.s14,
            ),
          ],
        ),
      ),
      SizedBox(height: asHeight(40)),
      textNormal('근력 운동의 기본적 원칙',
          isBold: true, padH: 0, padW: asWidth(18), fontSize: tm.s18),
      SizedBox(height: asHeight(20)),
      textSub(
        '매 세트 마다 자세가 유지되는 최대 반복 횟수만큼 운동하거나'
        ' 운동량 게이지를 50% 이상 채울 만큼 운동을 진행하며 힘이 남는 경우 100%를 넘어도 계속 진행한다.',
        isCheck: true,
        padW: asWidth(18),
      ),
      textSub(
        '운동량을 50%이상 채우지 못했더라도 본인의 페이스에 맞출 수 있도록 스스로 중단하여 무리하지 않는다.',
        isCheck: true,
        padW: asWidth(18),
      ),
      textSub(
        '본인이 설정한 목표영역까지 힘을 주며 반복횟수보다는 운동량 목표 달성에 집중한다.'
            ' (1회 운동을 길게 하는 슈퍼슬로우도 OK)',
        isCheck: true,
        padW: asWidth(18),
      ),
      textSub(
        '운동 강도에 따라 매 세트 사이 30초에서 5분 가량의 휴식을 취하도록 합니다.'
            ' (앱에서의 휴식 시간은 힘 목표 설정에 따라 변화되므로 운동 결과를 반영하는 것은 아닙니다)',
        isCheck: true,
        padW: asWidth(18),
      ),
      textSub(
        '근력 성장 및 피로회복을 위해 적어도 이틀의 휴식을 권장합니다.',
        isCheck: true,
        padW: asWidth(18),
      ),
      SizedBox(height: asHeight(60)),
      _programItem(
          programNumber: 1,
          title: '건강 근력',
          description: '척추 및 무릎 건강에 좋은 근육입니다. 걷기는 매일하며, 근력운동은 주 1~2회 정도 권장합니다.',
          exerciseList: [
            EmaMuscle.m22GluteusMedius.index,
            EmaMuscle.m19LatissimusDorsi.index,
            EmaMuscle.m23QuadricepsFemoris.index,
            EmaMuscle.m20ErectorSpinae.index
          ]),
      _programItem(
          programNumber: 2,
          title: '몸짱 근력운동',
          description: '멋진 어깨와 가슴근육을 만드는 근육 구성입니다.',
          exerciseList: [
            EmaMuscle.m19LatissimusDorsi.index,
            EmaMuscle.m11MiddlePectoralis.index,
            EmaMuscle.m14RectusAbdominal.index,
            EmaMuscle.m10UpperPectoralis.index,
            EmaMuscle.m23QuadricepsFemoris.index,
            EmaMuscle.m03Biceps.index,
            EmaMuscle.m04Triceps.index,
            EmaMuscle.m06MiddleDeltoid.index,
            EmaMuscle.m05FrontDeltoid.index,
            EmaMuscle.m13SerratusAnterior.index,
          ]),
      _programItem(
          programNumber: 3,
          title: '힙업',
          description: '골반을 키우고 힙 탄력을 높이는 근육부위로 주2회, 매회 30분 정도 운동합니다.',
          exerciseList: [
            EmaMuscle.m22GluteusMedius.index,
            EmaMuscle.m21GluteusMaximus.index,
            EmaMuscle.m14RectusAbdominal.index,
            EmaMuscle.m23QuadricepsFemoris.index
          ]),
      textNormal(
        '위는 하나의 예시이며, 각 개인의 상황에 맞추어 운동 할 근육을 구성하는 것이 바람직 합니다.'
            ' 자세한 운동프로그램은 전문가의 도움을 받거나,'
            ' 서적 또는 인터넷을 등을 참조하시기 바랍니다.'
        ' 본 제품과 가이드의 맨몸/밴드 운동방법으로 집에서도 효과적인 근력운동을 즐겨보세요.',
        fontColor: tm.grey04,
        padW: asWidth(18),
      ),
      asSizedBox(height: 50),
    ],
  );
}

//------------------------------------------------------------------------------
// 프로그램 내용
//------------------------------------------------------------------------------
Widget _programItem(
    {required int programNumber,
    required String title,
    String description = '',
    required List<int> exerciseList}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: asWidth(18)),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: asWidth(360),
          height: asHeight(2),
          color: tm.mainBlue,
        ),
        SizedBox(height: asHeight(18)),
        TextN(
          'PROGRAM.${programNumber.toString().padLeft(2, '0')}',
          fontSize: tm.s14,
          color: tm.mainBlue,
          fontWeight: FontWeight.w900,
        ),
        asSizedBox(height: 4),
        //-------------------------------------
        // 제목
        TextN(
          title,
          fontSize: tm.s18,
          color: tm.black,
          fontWeight: FontWeight.w600,
        ),
        //-------------------------------------
        // 설명글 추가
        if (description.isNotEmpty) asSizedBox(height: 10),
        if (description.isNotEmpty)
          TextN(
            description,
            fontSize: tm.s14,
            color: tm.grey03,
            fontWeight: FontWeight.w600,
            height: 1.5,
          ),
        SizedBox(height: asHeight(20)),
        // Todo: N x 2 그리드 형태의 카드 display 하도록~!
        Center(
          child: GridView.builder(
            shrinkWrap: true,
            physics: const ScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisExtent: asHeight(108), //88
              mainAxisSpacing: asHeight(8),
              crossAxisSpacing: asWidth(8),
            ),
            //padding: const EdgeInsets.symmetric(horizontal: 30),
            itemCount: exerciseList.length,
            itemBuilder: (ctx, index) {
              String exerciseName = muscleTypeName(exerciseList[index]);
              int muscleIndex = exerciseList[index];
              // print(index);
              // print(muscleIndex);
              // print(exerciseToMuscle[1]);
              // print(exerciseName);
              // print(exerciseToMuscle[exerciseName]);
              return Container(
                padding: EdgeInsets.symmetric(
                    horizontal: asWidth(12), vertical: asHeight(20)),
                height: asHeight(108),
                //88
                width: asWidth(158),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: tm.grey01,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextN(
                      exerciseName,
                      fontSize: tm.s14,
                      color: tm.black,
                      fontWeight: FontWeight.w900,
                      height: 1,
                    ),
                    asSizedBox(height: 12),
                    TextN(
                      ': ${exerciseToMuscle[exerciseList[index]]}',
                      fontSize: tm.s14,
                      color: tm.black,
                      fontWeight: FontWeight.normal,
                      height: 1.5,
                    ),
                  ],
                ),
              );
            },
          ),
        ),

        asSizedBox(height: 60),
      ],
    ),
  );
}

// Map<String, String> exerciseToMuscle = {
//   '스쿼트': '대둔근, 대퇴사두근',
//   '턱걸이': '광배근, 승모근',
//   '플랭크': '복근',
//   '뒤꿈치 들기': '비복근',
//   '팔굽혀펴기': '삼두근, 대흉근',
//   '힙업덕션': '중둔근, 대둔근',
//   '랫풀다운': '광배근',
//   '레그익스텐션': '대퇴사두근',
//   '리버스플라이': '후면삼각근',
//   '체스트프레스': '삼두근, 대흉근',
// };

Map<int, String> exerciseToMuscle = {
  // 팔
  EmaMuscle.m01WristFlexor.index: '손목굽히기',
  EmaMuscle.m02WristExtensor.index: '손목펴기, 수건비틀기',
  EmaMuscle.m03Biceps.index: '팔굽히기, 암컬, 프리쳐 컬',
  EmaMuscle.m04Triceps.index: '팔펴기, 덤벨 킥백, 푸쉬 업, 딥스',
  // 어깨
  EmaMuscle.m05FrontDeltoid.index: '팔 올리기, 숄더 프레스',
  EmaMuscle.m06MiddleDeltoid.index: '팔 벌리기, 래터럴 레이즈',
  EmaMuscle.m07BackDeltoid.index: '팔 벌리기, 리어 델토이드 플라이',
  EmaMuscle.m08ExternalRotator.index: '팔돌리기, 익스터널 로테이션',
  EmaMuscle.m09ExternalRotator.index: '인터널 로테이션',
  // 가슴
  EmaMuscle.m10UpperPectoralis.index: '양손밀기, 디클라인 푸쉬업, 인클라인 프레스',
  EmaMuscle.m11MiddlePectoralis.index: '양손밀기, 푸쉬업, 벤치프레스',
  EmaMuscle.m12LowerPectoralis.index: '양손밀기, 인클라인 푸쉬업, 디클라인 프레스',
  EmaMuscle.m13SerratusAnterior.index: '팔펴고 푸쉬업, 바벨 풀오버',
  // 복부
  EmaMuscle.m14RectusAbdominal.index: '몸통굽히기, 플랭크',
  EmaMuscle.m15ExternalObliqueAbdominal.index: '옆으로 몸들기, 덤벨 사이드밴드',
  // 등
  EmaMuscle.m16UpperTrapezius.index: '의자당기기, 슈러그',
  EmaMuscle.m17MiddleTrapezius.index: '밴드 노젓기, W 레이즈',
  EmaMuscle.m18LowerTrapezius.index: 'Y 레이즈',
  EmaMuscle.m19LatissimusDorsi.index: '밴드 노젓기, 턱걸이, 랫풀다운',
  EmaMuscle.m20ErectorSpinae.index: '걷기, 상체들기, 굿모닝',
  // 엉덩이
  EmaMuscle.m21GluteusMaximus.index: '스쿼트, 다리 뒤로 들기, 데드리프트',
  EmaMuscle.m22GluteusMedius.index: '다리벌리기, 힙업덕션',
  // 다리
  EmaMuscle.m23QuadricepsFemoris.index: '다리펴기, 스쿼트',
  EmaMuscle.m24Hamstrings.index: '다리굽히기, 레그컬',
  EmaMuscle.m25Adductor.index: '다리모으기, 힙 어덕션',
  EmaMuscle.m26TibialisAnterior.index: '장딴지 벽밀기, 다리 들기',
  EmaMuscle.m27Gastrocnemius.index: '발등들기, 에버젼',
};
