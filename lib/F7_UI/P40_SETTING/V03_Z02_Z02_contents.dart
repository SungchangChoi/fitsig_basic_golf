import 'package:fitsig_basic_golf/F0_BASIC/common_import.dart';

//==============================================================================
// 근육 가이드 주의사항
//==============================================================================
Widget muscleGuideCaution() {
  return Expanded(
    child: SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: asWidth(18)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            textTitleSmall('부착 가이드 주의사항'),
            textNormal('본 장비에서는 일반 사용자들이 부착을 쉽게할 수 있는 위치로 표준 부착위치를 정의하였습니다.'
                ' 기본 원칙은 근육의 결 방향으로 항상 같은 곳에 붙이는 것입니다.'
                ' \n부착 위치를 선정할 때 신체 특징점을 이용하여 좀더 기억하기 쉬운 위치로 정하려고 노력하였습니다.'
                ' 본 제품을 이용하기 위해 제시하는 위치에 반드시 붙어야 하는 것은 아닙니다.'
                ' 더 중요한 것은 표준과 다른 위치에 부착하더라도 전극을 매번 계속 같은 위치에 붙이는 것입니다.'),
            textNormal('부착위치가 매번 바뀌면 같은 근육이라도 근전도 신호의 크기가 많이 달라질 수 있습니다.'
                ' 근력 비교 및 발달 확인을 위해서는 최대한 같은 위치에 부착해가며 근력 및 운동량을 측정하시기 바랍니다.'
                ' \n장비 부착 위치 사진을 찍어두면 다음에 부착할 때 크게 도움이 됩니다.'),
            textTitleSmall('부착 가이드 이해하기'),
            textNormal(
                '장비 폭 혹은 반개 길이는 대략 3cm 정도가 됩니다. 부착 위치 설명에서는 장비 반개 길이, 장비 폭 등으로 거리를 설명합니다.'),
            textNormal('신체적 특정이 일반적 상황과 차이나는 경우 사진 혹은 그림을 참조하여 부착하기 바랍니다.'),
            textNormal('부착 각도는 가로, 세로, 45도 3가지가 있습니다.'),
            textTitleSmall('관련 운동 이해하기'),
            textNormal('각 근육별 운동 방법으로 맨몸, 밴드, 케이블, 덤벨, 바벨, 머신이 있습니다.'
                ' 집에서 운동한다면 맨몸, 밴드가 적절합니다.'
                ' 본인의 환경에 따라 적합한 운동방식을 선택하세요.'),
            textNormal('각 근육에 관계된 운동을 기술하였으나, 운동에 따라 주동근이 모호한 경우도 있습니다.'
                ' 한 예로 중 승모근과 광배근은 자극을 구분하기 어려운 경우도 많습니다.'
                '\n중 승모근에 제품을 붙이기 어렵다면 광배근에 부착해도 좋습니다.'
                ' 스쿼트나 데드리프트는 둔근과 대퇴사두근 혹은 햄스트링에 동시에 자극을 줍니다.'
                ' 엉덩이에 제품을 붙이기 어렵다면 대퇴사두근에 부착해도 좋습니다.'),
            textTitleSmall('안전한 근력운동을 위해'),
            textNormal('연령대에 따라 권장되는 운동은 달라질 수 있습니다.'
                ' 나이가 있거나 척추 질환 경험이 있다면 무리가 되는 동작을 피해서 운동하시기 바랍니다.'),
            textNormal(
                '척추질환 경험이 있다면 윗몸일으키기 처럼 허리를 굽히는 운동이나 트위스트 처럼 몸을 비트는 운동은 피하는 것이 좋습니다.'),
            textNormal(
                '척추 질환에서 회복되지 않았다면 근력운동을 하지 않는 것이 바람직하며, 운동 진행 여부는 반드시 전문가의 도움을 받으시기를 바랍니다.'),
            textNormal('어떤 운동이든 통증이 있다면 바로 중단하는 것이 좋습니다.'),
            asSizedBox(height: 50),
          ],
        ),
      ),
    ),
  );
}

//============================================================================
// 가이드 내용
//============================================================================
Widget muscleGuideContents({int contentsIdx = 0}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      //--------------------------------------------------------------------
      // 팔
      //--------------------------------------------------------------------
      if (contentsIdx == 0)
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 손목굽힘근
            textTitleSmall('손목굽힘근(손목굴곡근)', padW: asWidth(18)),
            m01WristFlexor(),
            asSizedBox(height: 50),
            // 손목굴곡근
            textTitleSmall('손목폄근(손목신전근)', padW: asWidth(18)),
            m02WristExtensor(),
            asSizedBox(height: 50),
            // 위팔 두갈래근
            textTitleSmall('위팔 두갈래근(이두근)', padW: asWidth(18)),
            m03Biceps(),
            asSizedBox(height: 50),
            // 위팔 세갈래근
            textTitleSmall('위팔 세갈래근(삼두근)', padW: asWidth(18)),
            m04Triceps(),
          ],
        ),
      //--------------------------------------------------------------------
      // 어깨
      //--------------------------------------------------------------------
      if (contentsIdx == 1)
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 전면삼각근
            textTitleSmall('앞 어깨 세모근(전면 삼각근)', padW: asWidth(18)),
            m05FrontDeltoid(),
            asSizedBox(height: 50),
            // 측면 삼각근
            textTitleSmall('중간 어깨 세모근(측면 삼각근)', padW: asWidth(18)),
            m06MiddleDeltoid(),
            asSizedBox(height: 50),
            // 후면 삼각근
            textTitleSmall('뒤 어깨 세모근(후면 삼각근)', padW: asWidth(18)),
            m07BackDeltoid(),
            asSizedBox(height: 50),
            // 가쪽 어깨돌림근
            textTitleSmall('어깨 가쪽 돌림근(어깨 외회전근)', padW: asWidth(18)),
            m08ExternalRotator(),
            asSizedBox(height: 50),
            // 어깨 내회전근
            textTitleSmall('어깨 안쪽 돌림근(어깨 내회전근)', padW: asWidth(18)),
            m09ExternalRotator(),
          ],
        ),

      //--------------------------------------------------------------------
      // 가슴
      //--------------------------------------------------------------------
      if (contentsIdx == 2)
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 상부대흉근
            textTitleSmall('위 큰가슴근(상부대흉근)', padW: asWidth(18)),
            m10UpperPectoralis(),
            asSizedBox(height: 50),
            // 중부대흉근 - 여자 없음 (?)
            // if (gv.setting.genderIndex.value == 0 ||
            //     gv.setting.genderIndex.value == 2)
            textTitleSmall('중간 큰가슴근(중부 대흉근)', padW: asWidth(18)),
            m11MiddlePectoralis(),
            asSizedBox(height: 50),
            // 하부대흉근 - 여자 없음(?)
            // if (gv.setting.genderIndex.value == 0 ||
            //     gv.setting.genderIndex.value == 2)
            textTitleSmall('아래 큰가슴근(하부 대흉근)', padW: asWidth(18)),
            m12LowerPectoralis(),
            asSizedBox(height: 50),
            // 앞톱니근 (전거근)
            textTitleSmall('앞 톱니근(전거근)', padW: asWidth(18)),
            m13SerratusAnterior(),
          ],
        ),
      //--------------------------------------------------------------------
      // 복부
      //--------------------------------------------------------------------
      if (contentsIdx == 3)
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 복직근
            textTitleSmall('배 곧은근(복직근)', padW: asWidth(18)),
            m14RectusAbdominal(),
            asSizedBox(height: 50),
            // 배 바깥 빗근
            textTitleSmall('배 바깥빗근(외복사근)', padW: asWidth(18)),
            m15ExternalObliqueAbdominal(),
          ],
        ),
      //--------------------------------------------------------------------
      // 등
      //--------------------------------------------------------------------
      if (contentsIdx == 4)
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 상 승모근
            textTitleSmall('위 등세모근(상 승모근)', padW: asWidth(18)),
            m16UpperTrapezius(),
            asSizedBox(height: 50),
            // 중 승모근
            textTitleSmall('중간 등세모근(중 승모근)', padW: asWidth(18)),
            m17MiddleTrapezius(),
            asSizedBox(height: 50),
            // 하 승모근
            textTitleSmall('아래 등세모근(하 승모근)', padW: asWidth(18)),
            m18LowerTrapezius(),
            asSizedBox(height: 50),
            // 광배근
            textTitleSmall('넓은 등근(광배근)', padW: asWidth(18)),
            m19LatissimusDorsi(),
            asSizedBox(height: 50),
            // 척추세움근
            textTitleSmall('척추세움근(척추기립근)', padW: asWidth(18)),
            m20ErectorSpinae(),
          ],
        ),
      //--------------------------------------------------------------------
      // 엉덩이
      //--------------------------------------------------------------------
      if (contentsIdx == 5)
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 큰 볼기근
            textTitleSmall('큰 볼기근(대둔근)', padW: asWidth(18)),
            m21GluteusMaximus(),
            asSizedBox(height: 50),
            // 중간 볼기근
            textTitleSmall('중간 볼기근(중둔근)', padW: asWidth(18)),
            m22GluteusMedius(),
          ],
        ),
      //--------------------------------------------------------------------
      // 다리
      //--------------------------------------------------------------------
      if (contentsIdx == 6)
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 대퇴사두근
            textTitleSmall('넙다리 네갈래근(대퇴사두근)', padW: asWidth(18)),
            m23QuadricepsFemoris(),
            asSizedBox(height: 50),
            // 햄스트링
            textTitleSmall('넙다리 뒤근(슬괵근)', padW: asWidth(18)),
            m24Hamstrings(),
            asSizedBox(height: 50),
            // 모음근
            textTitleSmall('모음근(내전근)', padW: asWidth(18)),
            m25Adductor(),
            asSizedBox(height: 50),
            // 장딴지근
            textTitleSmall('장딴지근(비복근)', padW: asWidth(18)),
            m27Gastrocnemius(),
            asSizedBox(height: 50),
            // 앞정강근
            textTitleSmall('앞정강근(전경골근)', padW: asWidth(18)),
            m26TibialisAnterior(),
          ],
        ),

      asSizedBox(height: 50),
    ],
  );
}
