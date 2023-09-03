import 'package:fitsig_basic_golf/F0_BASIC/common_import.dart';

//==============================================================================
// 010 손목굴곡근
//==============================================================================
Widget m01WristFlexor() {
  return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    guideSlideImage(
      isViewLeft: dvSetting.isViewLeft,
      guideContents: dvSetting.guideContents,
      imageManRight: [
        '01-팔_어깨_손묵굴곡근_남_맨살_0도.jpg',
        '01-팔_어깨_손묵굴곡근_남_장비_0도.jpg',
        '01-팔_어깨_손묵굴곡근_남_맨살_45도.jpg',
        '01-팔_어깨_손묵굴곡근_남_장비_45도.jpg',
      ],
      imageWomanRight: [
        '01-팔_어깨_손묵굴곡근_여_맨살_0도.jpg',
        '01-팔_어깨_손묵굴곡근_여_장비_0도.jpg',
        '01-팔_어깨_손묵굴곡근_여_맨살_45도.jpg',
        '01-팔_어깨_손묵굴곡근_여_장비_45도.jpg',
      ],
      imageGuideLeft: [
        '01-팔_어깨_손묵굴곡근_마좌.jpg',
        '01-팔_어깨_손묵굴곡근_근좌.jpg',
      ],
      imageGuideRight: [
        '01-팔_어깨_손묵굴곡근_마우.jpg',
        '01-팔_어깨_손묵굴곡근_근우.jpg',
      ],
      exerciseVideo: m01WristFlexorExerciseList,
    ),
    //--------------------------------------------------------------------------
    // 부착 가이드
    if (dvSetting.guideContents != EmaGuideContents.exercise)
      textNormalC('아래 팔의 세로 중심선(B)의 안쪽, 팔의 가로선(A)에서 장비 반개 간격 띄위서 세로방향으로 부착합니다.',
          padW: asWidth(18)),
    //--------------------------------------------------------------------------
    // 관련운동
    if (dvSetting.guideContents == EmaGuideContents.exercise)
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          textNormalC('저항을 주며 팔목을 안으로 구부리는 동작', padW: asWidth(18)),
          textSub('(1) 손목 굽히기: 손목을 굽힐 때 주먹 쥔 다른 팔로 저항주며 운동', padW: asWidth(18)),
          textSub('(2) 밴드 손목굽히기 (리스트 컬)', padW: asWidth(18)),
          textSub('(3) 덤벨 손목굽히기 (리스트 컬)', padW: asWidth(18)),
          textSub('(4) 바벨 손목굽히기 (리스트 컬)', padW: asWidth(18)),
          textSub('(5) 바벨 뒤로 손목굽히기 (리어 리스트 컬)', padW: asWidth(18)),
        ],
      ),
  ]);
}

//==============================================================================
// 020 손목신전근
//==============================================================================
Widget m02WristExtensor() {
  return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    guideSlideImage(
      isViewLeft: dvSetting.isViewLeft,
      guideContents: dvSetting.guideContents,
      imageManRight: [
        '02-팔_어깨_손목신전근_남_맨살_0도.jpg',
        '02-팔_어깨_손목신전근_남_장비_0도.jpg',
        '02-팔_어깨_손목신전근_남_맨살_45도.jpg',
        '02-팔_어깨_손목신전근_남_장비_45도.jpg',
      ],
      imageWomanRight: [
        '02-팔_어깨_손목신전근_여_맨살_0도.jpg',
        '02-팔_어깨_손목신전근_여_장비_0도.jpg',
        '02-팔_어깨_손목신전근_여_맨살_45도.jpg',
        '02-팔_어깨_손목신전근_여_장비_45도.jpg',
      ],
      imageGuideLeft: [
        '02-팔_어깨_손목신전근_마좌.jpg',
        '02-팔_어깨_손목신전근_근좌.jpg',
      ],
      imageGuideRight: [
        '02-팔_어깨_손목신전근_마우.jpg',
        '02-팔_어깨_손목신전근_근우.jpg',
      ],
      exerciseVideo: m02WristExtensorExerciseList,
    ),
    //--------------------------------------------------------------------------
    // 부착 가이드
    if (dvSetting.guideContents != EmaGuideContents.exercise)
      textNormalC(
          '아래 팔의 뒤쪽 세로 중심선(B)의 바깥쪽, 팔꿈치 라인(A)에서 장비 반개 간격 띄워서 세로방향으로 부착합니다.',
          padW: asWidth(18)),
    //--------------------------------------------------------------------------
    // 관련운동
    if (dvSetting.guideContents == EmaGuideContents.exercise)
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          textNormalC('저항을 주며 팔목을 펴는 동작', padW: asWidth(18)),
          textSub('(1) 손등 들기: 책상 위에 팔을 올린 상태에서 손등을 위로 들 때 다른 손으로 눌러 저항주기',
              padW: asWidth(18)),
          textSub('(2) 수건 비틀기', padW: asWidth(18)),
          textSub('(3) 밴드 손목 펴기 (리버스 리스트 컬)', padW: asWidth(18)),
          textSub('(4) 밴드 손가락 펴기 (핑거 익스텐션)', padW: asWidth(18)),
          textSub('(5) 밴드 양손 손목 펴기 (리버스 리스트 컬)', padW: asWidth(18)),
          textSub('(6) 덤벨 손목 펴기 (리버스 리스트 컬)', padW: asWidth(18)),
          textSub('(7) 바벨 손목 펴기 (리버스 리스트 컬)', padW: asWidth(18)),
        ],
      ),
  ]);
}

//==============================================================================
// 030 위팔 두갈래근
//==============================================================================
Widget m03Biceps() {
  return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    guideSlideImage(
      isViewLeft: dvSetting.isViewLeft,
      guideContents: dvSetting.guideContents,
      imageManRight: [
        '03-팔_어깨_이두근_남_맨살_0도.jpg',
        '03-팔_어깨_이두근_남_장비_0도.jpg',
        '03-팔_어깨_이두근_남_맨살_45도.jpg',
        '03-팔_어깨_이두근_남_장비_45도.jpg',
      ],
      imageWomanRight: [
        '03-팔_어깨_이두근_여_맨살_0도.jpg',
        '03-팔_어깨_이두근_여_장비_0도.jpg',
        '03-팔_어깨_이두근_여_맨살_45도.jpg',
        '03-팔_어깨_이두근_여_장비_45도.jpg',
      ],
      imageGuideLeft: [
        '03-팔_어깨_이두근_마좌.jpg',
        '03-팔_어깨_이두근_근좌.jpg',
      ],
      imageGuideRight: [
        '03-팔_어깨_이두근_마우.jpg',
        '03-팔_어깨_이두근_근우.jpg',
      ],
      exerciseVideo:m03BicepsExerciseList,
    ),
    //--------------------------------------------------------------------------
    // 부착 가이드
    if (dvSetting.guideContents != EmaGuideContents.exercise)
      textNormalC(
          '장비 전극의 한쪽 끝을 겨드랑이 선(A)에 정렬하고 위 팔의 세로 중심선(B)에 부착합니다.',
          padW: asWidth(18)),
    //--------------------------------------------------------------------------
    // 관련운동
    if (dvSetting.guideContents == EmaGuideContents.exercise)
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          textNormalC('저항을 주며 팔을 굽히는 동작', padW: asWidth(18)),
          textSub('(1) 팔 굽히기: 다른 팔꿈치로 저항을 주며 팔 굽히기', padW: asWidth(18)),
          textSub('(2) 책상 들기: 책상 아래를 잡고 들어올리기', padW: asWidth(18)),
          textSub('(3) 밴드 팔 굽히기 (바이셉스 컬)', padW: asWidth(18)),
          textSub('(4) 밴드 크로스 래터럴 컬', padW: asWidth(18)),
          textSub('(5) 밴드 프리쳐 컬', padW: asWidth(18)),
          textSub('(6) 케이블 햄머 컬', padW: asWidth(18)),
          textSub('(7) 덤벨 팔 굽히기 (덤벨 컬)', padW: asWidth(18)),
          textSub('(8) 바벨 프리쳐 컬', padW: asWidth(18)),
        ],
      ),
  ]);
}

//==============================================================================
// 040 위팔 세갈래근
//==============================================================================
Widget m04Triceps() {
  return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    guideSlideImage(
      isViewLeft: dvSetting.isViewLeft,
      guideContents: dvSetting.guideContents,
      imageManRight: [
        '04-팔_어깨_삼두근_남_맨살_0도.jpg',
        '04-팔_어깨_삼두근_남_장비_0도.jpg',
        '04-팔_어깨_삼두근_남_맨살_45도.jpg',
        '04-팔_어깨_삼두근_남_장비_45도.jpg',
      ],
      imageWomanRight: [
        '04-팔_어깨_삼두근_여_맨살_0도.jpg',
        '04-팔_어깨_삼두근_여_장비_0도.jpg',
        '04-팔_어깨_삼두근_여_맨살_45도.jpg',
        '04-팔_어깨_삼두근_여_장비_45도.jpg',
      ],
      imageGuideLeft: [
        '04-팔_어깨_삼두근_마좌.jpg',
        '04-팔_어깨_삼두근_근좌.jpg',
      ],
      imageGuideRight: [
        '04-팔_어깨_삼두근_마우.jpg',
        '04-팔_어깨_삼두근_근우.jpg',
      ],
      exerciseVideo:m04TricepsExerciseList,
    ),
    //--------------------------------------------------------------------------
    // 부착 가이드
    if (dvSetting.guideContents != EmaGuideContents.exercise)
      textNormalC('위 팔의 뒤 가로 중심 선(A)에서 장비 반개 위쪽, 팔의 뒤 세로 중심선(B)의 바깥쪽에 세로방향으로 부착합니다.',
          padW: asWidth(18)),
    //--------------------------------------------------------------------------
    // 관련운동
    if (dvSetting.guideContents == EmaGuideContents.exercise)
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          textNormalC('저항을 주며 팔을 펴는 동작. 푸시업이나 딥스도 삼두근에 많은 자극을 줌',
              padW: asWidth(18)),
          textSub('(1) 서서 책상 누르기', padW: asWidth(18)),
          textSub('(2) 앉아서 책상 누르기', padW: asWidth(18)),
          textSub('(3) 밴드 로 킥백', padW: asWidth(18)),
          textSub('(4) 밴드 트라이셉스 익스텐션', padW: asWidth(18)),
          textSub('(5) 밴드 아래로 누르기 (푸시다운)', padW: asWidth(18)),
          textSub('(6) 케이블 아래로 누르기 (푸시다운)', padW: asWidth(18)),
          textSub('(7) 덤벨 킥백', padW: asWidth(18)),
          textSub('(8) 덤벨 오버헤드 익스텐션', padW: asWidth(18)),
          textSub('(9) 바벨 누워서 팔펴기 (라잉 트리이셉스 익스텐션)', padW: asWidth(18)),
        ],
      ),
  ]);
}

//==============================================================================
// 050 전면삼각근
//==============================================================================
Widget m05FrontDeltoid() {
  return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    guideSlideImage(
      isViewLeft: dvSetting.isViewLeft,
      guideContents: dvSetting.guideContents,
      imageManRight: [
        '05-팔_어깨_전면삼각근_남_맨살_0도.jpg',
        '05-팔_어깨_전면삼각근_남_장비_0도.jpg',
        '05-팔_어깨_전면삼각근_남_맨살_45도.jpg',
        '05-팔_어깨_전면삼각근_남_장비_45도.jpg',
      ],
      imageWomanRight: [
        '05-팔_어깨_전면삼각근_여_맨살_0도.jpg',
        '05-팔_어깨_전면삼각근_여_장비_0도.jpg',
        '05-팔_어깨_전면삼각근_여_맨살_45도.jpg',
        '05-팔_어깨_전면삼각근_여_장비_45도.jpg',
      ],
      imageGuideLeft: [
        '05-팔_어깨_전면삼각근_마좌.jpg',
        '05-팔_어깨_전면삼각근_근좌.jpg',
      ],
      imageGuideRight: [
        '05-팔_어깨_전면삼각근_마우.jpg',
        '05-팔_어깨_전면삼각근_근우.jpg',
      ],
      exerciseVideo: m05FrontDeltoidExerciseList,
    ),
    //--------------------------------------------------------------------------
    // 부착 가이드
    if (dvSetting.guideContents != EmaGuideContents.exercise)
      textNormalC('겨드랑이 가로선(A) 위쪽, 어깨 세로선(B) 중앙에 세로방향으로 부착합니다.',
          padW: asWidth(18)),

    //--------------------------------------------------------------------------
    // 관련운동
    if (dvSetting.guideContents == EmaGuideContents.exercise)
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          textNormalC('저항을 주며 팔을 앞으로 올리거나 위로 드는 동작', padW: asWidth(18)),
          textSub('(1) 팔 올리기: 다른팔로 저항을 주며 팔을 편 상태로 들어 올림', padW: asWidth(18)),
          textSub('(2) 책상들기 : 팔을 편 상태로 책상 아래 들기', padW: asWidth(18)),
          textSub('(3) 밴드 앞으로 올리기 (프론트 레이즈)', padW: asWidth(18)),
          textSub('(4) 밴드 위로 밀기 (밀리터리 프레스)', padW: asWidth(18)),
          textSub('(5) 덤벨 앞으로 올리기 (프론트 레이즈)', padW: asWidth(18)),
          textSub('(6) 바벨 위로 밀기 (밀리터리 프레스)', padW: asWidth(18)),
          textSub('(7) 머신 숄더 프레스', padW: asWidth(18)),
        ],
      ),
  ]);
}

//==============================================================================
// 051 측면삼각근
//==============================================================================
Widget m06MiddleDeltoid() {
  return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    guideSlideImage(
      isViewLeft: dvSetting.isViewLeft,
      guideContents: dvSetting.guideContents,
      imageManRight: [
        '06-팔_어깨_측면삼각근_남_맨살_90도.jpg',
        '06-팔_어깨_측면삼각근_남_장비_90도.jpg',
        '06-팔_어깨_측면삼각근_남_맨살_45도.jpg',
        '06-팔_어깨_측면삼각근_남_장비_45도.jpg',
      ],
      imageWomanRight: [
        '06-팔_어깨_측면삼각근_여_맨살_90도.jpg',
        '06-팔_어깨_측면삼각근_여_장비_90도.jpg',
        '06-팔_어깨_측면삼각근_여_맨살_45도.jpg',
        '06-팔_어깨_측면삼각근_여_장비_45도.jpg',
      ],
      imageGuideLeft: [
        '06-팔_어깨_측면삼각근_마좌.jpg',
        '06-팔_어깨_측면삼각근_근좌.jpg',
      ],
      imageGuideRight: [
        '06-팔_어깨_측면삼각근_마우.jpg',
        '06-팔_어깨_측면삼각근_근우.jpg',
      ],
      exerciseVideo: m06MiddleDeltoidExerciseList,
    ),
    //--------------------------------------------------------------------------
    // 부착 가이드
    if (dvSetting.guideContents != EmaGuideContents.exercise)
      textNormalC('겨드랑이 가로선(A) 위쪽, 어깨 측면 세로 중심선(B)의 중앙에 세로방향으로 부착합니다.',
          padW: asWidth(18)),
    //--------------------------------------------------------------------------
    // 관련운동
    if (dvSetting.guideContents == EmaGuideContents.exercise)
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          textNormalC('저항을 주며 팔을 옆으로 올리는 동작', padW: asWidth(18)),
          textSub('(1) 팔 벌리기: 다리로 저항을 주며 팔 벌리기', padW: asWidth(18)),
          textSub('(2) 책상들기 : 팔을 편 상태로 책상을 옆으로 들기', padW: asWidth(18)),
          textSub('(3) 밴드 옆으로 올리기 (래터럴 레이즈)', padW: asWidth(18)),
          textSub('(4) 밴드 수직 노젓기 (업라이트 로우)', padW: asWidth(18)),
          textSub('(5) 케이블 옆으로 올리기 (래터럴 레이즈)', padW: asWidth(18)),
          textSub('(6) 덤벨 옆으로 올리기 (래터럴 레이즈)', padW: asWidth(18)),
        ],
      ),
  ]);
}

//==============================================================================
// 052 후면삼각근
//==============================================================================
Widget m07BackDeltoid() {
  return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    guideSlideImage(
      isViewLeft: dvSetting.isViewLeft,
      guideContents: dvSetting.guideContents,
      imageManRight: [
        '07-팔_어깨_후면삼각근_남_맨살_0도.jpg',
        '07-팔_어깨_후면삼각근_남_장비_0도.jpg',
        '07-팔_어깨_후면삼각근_남_맨살_45도.jpg',
        '07-팔_어깨_후면삼각근_남_장비_45도.jpg',
      ],
      imageWomanRight: [
        '07-팔_어깨_후면삼각근_여_맨살_0도.jpg',
        '07-팔_어깨_후면삼각근_여_장비_0도.jpg',
        '07-팔_어깨_후면삼각근_여_맨살_45도.jpg',
        '07-팔_어깨_후면삼각근_여_장비_45도.jpg',
      ],
      imageGuideLeft: [
        '07-팔_어깨_후면삼각근_마좌.jpg',
        '07-팔_어깨_후면삼각근_근좌.jpg',
      ],
      imageGuideRight: [
        '07-팔_어깨_후면삼각근_마우.jpg',
        '07-팔_어깨_후면삼각근_근우.jpg',
      ],
      exerciseVideo: m07BackDeltoidExerciseList,
    ),
    //--------------------------------------------------------------------------
    // 부착 가이드
    if (dvSetting.guideContents != EmaGuideContents.exercise)
      textNormalC('겨드랑이 뒤 가로선(A)의 위쪽, 어깨 뒤 세로 중심선(B)의 중앙에 세로방향으로 부착합니다.',
          padW: asWidth(18)),
    //--------------------------------------------------------------------------
    // 관련운동
    if (dvSetting.guideContents == EmaGuideContents.exercise)
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          textNormalC('저항을 주며 팔을 뒤로 미는 동작', padW: asWidth(18)),
          textSub('(1) 팔 누르기: 팔을 편 상태에서 아래로 누르기', padW: asWidth(18)),
          textSub('(2) 팔 벌리기 : 다리로 저항주며 팔 벌리기', padW: asWidth(18)),
          textSub('(3) 뒤로 벽밀기 : 팔을 편 상태에서 뒤로 벽밀기', padW: asWidth(18)),
          textSub('(4) 밴드 뒤로 올리기 (밴드 벤트 오버 리버스 레이즈)', padW: asWidth(18)),
          textSub('(5) 밴드 뒤로 날갯짓 (리어 델토이드 플라이)', padW: asWidth(18)),
          textSub('(6) 밴드 숙이고 옆 올리기 (벤트 오버 래터럴 레이즈)', padW: asWidth(18)),
          textSub('(7) 덤벨 숙이고 옆 올리기 (벤트 오버 래터럴 레이즈)', padW: asWidth(18)),
          textSub('(8) 머신 리어 델토이드 플라이', padW: asWidth(18)),
        ],
      ),
  ]);
}

//==============================================================================
// 080 가쪽 어깨돌림근
//==============================================================================
Widget m08ExternalRotator() {
  return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    guideSlideImage(
      isViewLeft: dvSetting.isViewLeft,
      guideContents: dvSetting.guideContents,
      imageManRight: [
        '08-팔_어깨_어깨외회전근_남_맨살_0도.jpg',
        '08-팔_어깨_어깨외회전근_남_장비_0도.jpg',
        '08-팔_어깨_어깨외회전근_남_맨살_45도.jpg',
        '08-팔_어깨_어깨외회전근_남_장비_45도.jpg',
      ],
      imageWomanRight: [
        '08-팔_어깨_어깨외회전근_여_맨살_0도.jpg',
        '08-팔_어깨_어깨외회전근_여_장비_0도.jpg',
        '08-팔_어깨_어깨외회전근_여_맨살_45도.jpg',
        '08-팔_어깨_어깨외회전근_여_장비_45도.jpg',
      ],
      imageGuideLeft: [
        '08-팔_어깨_어깨외회전근_마좌.jpg',
        '08-팔_어깨_어깨외회전근_근좌.jpg',
      ],
      imageGuideRight: [
        '08-팔_어깨_어깨외회전근_마우.jpg',
        '08-팔_어깨_어깨외회전근_근우.jpg',
      ],
      exerciseVideo: m08ExternalRotatorExerciseList,
    ),
    //--------------------------------------------------------------------------
    // 부착 가이드
    if (dvSetting.guideContents != EmaGuideContents.exercise)
      textNormalC(
          '장비를 45도 기울인 상태에서 겨드랑이 가로선(A)에 중심을 맞춘 후'
          ' 겨드랑이 세로선(B)에서 장비 1개 간격을 띄운 후 부착합니다.',
          padW: asWidth(18)),
    //--------------------------------------------------------------------------
    // 관련운동
    if (dvSetting.guideContents == EmaGuideContents.exercise)
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          textNormalC('저항을 주며 팔을 바깥으로 회전하는 동작', padW: asWidth(18)),
          textSub('(1) 팔 돌리기: 다른 팔로 저항을 주며 바깥으로 돌리기', padW: asWidth(18)),
          textSub('(2) 밴드 양손 밖으로 돌리기 (익스터널 로테이션)', padW: asWidth(18)),
          textSub('(3) 밴드 위로 돌리기 (쿠반 로테이션)', padW: asWidth(18)),
          textSub('(4) 밴드 밖으로 돌리기 (익스터널 로테이션)', padW: asWidth(18)),
          textSub('(5) 밴드 위로 돌리기 (쿠반 로테이션)', padW: asWidth(18)),
          textSub('(6) 밴드 얼굴로 당기기 (페이스 풀)', padW: asWidth(18)),
          textSub('(7) 케이블 얼굴로 당기기 (페이스 풀)', padW: asWidth(18)),
          textSub('(8) 덤벨 밖으로 돌리기 (익스터널 로테이션)', padW: asWidth(18)),
          textSub('(9) 바벨 쿠반 로케이션', padW: asWidth(18)),
        ],
      ),
  ]);
}

//==============================================================================
// 090 안쪽 어깨돌림근
//==============================================================================
Widget m09ExternalRotator() {
  return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    guideSlideImage(
      isViewLeft: dvSetting.isViewLeft,
      guideContents: dvSetting.guideContents,
      imageManRight: [
        '10-가슴_복부_상부대흉근_남_맨살_0도.jpg',
        '10-가슴_복부_상부대흉근_남_장비_0도.jpg',
        '10-가슴_복부_상부대흉근_남_맨살_45도.jpg',
        '10-가슴_복부_상부대흉근_남_장비_45도.jpg',
      ],
      imageWomanRight: [
        '10-가슴_복부_상부대흉근_여_맨살_0도.jpg',
        '10-가슴_복부_상부대흉근_여_장비_0도.jpg',
        '10-가슴_복부_상부대흉근_여_맨살_45도.jpg',
        '10-가슴_복부_상부대흉근_여_장비_45도.jpg',
      ],
      imageGuideLeft: [
        '10-가슴_복부_상부대흉근_마좌.jpg',
        '10-가슴_복부_상부대흉근_근좌.jpg',
      ],
      imageGuideRight: [
        '10-가슴_복부_상부대흉근_마우.jpg',
        '10-가슴_복부_상부대흉근_근우.jpg',
      ],
      exerciseVideo: m09ExternalRotatorExerciseList,
    ),
    //--------------------------------------------------------------------------
    // 부착 가이드
    if (dvSetting.guideContents != EmaGuideContents.exercise)
      textNormalC(
          '어깨 내회전근은 속근육으로 직접적인 부착이 어렵습니다.'
          ' 대신 상부대흉근에 부착하여 간접적으로 측정을 합니다. 어깨 등 다른 근육에 부착해도 됩니다.'
          '\n쇄골 선(A)에서 장비 1개 간격을 띄우고, 가슴 중심세로선(B)에서 장비 반개 간격 띄운 후 가로방향으로 부착합니다.',
          padW: asWidth(18)),
    //--------------------------------------------------------------------------
    // 관련운동
    if (dvSetting.guideContents == EmaGuideContents.exercise)
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          textNormalC('저항을 주며 팔을 안으로 회전하는 동작', padW: asWidth(18)),
          textSub('(1) 밴드 안으로 돌리기 (인터널 로테이션)', padW: asWidth(18)),
          textSub('(2) 밴드 누워서 안으로 돌리기 (라잉 인터널 로테이션)', padW: asWidth(18)),
          textSub('(3) 밴드 등뒤에서 안으로 돌리기 (비하인드 백 인터널 로테이션)', padW: asWidth(18)),
          textSub('(4) 바벨 등뒤 팔꿈치 굽히기 (비하인드 백 엘보우 플렉션)', padW: asWidth(18)),
        ],
      ),
  ]);
}

//==============================================================================
// 100 상부대흉근
//==============================================================================
Widget m10UpperPectoralis() {
  return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    guideSlideImage(
      isViewLeft: dvSetting.isViewLeft,
      guideContents: dvSetting.guideContents,
      imageManRight: [
        '10-가슴_복부_상부대흉근_남_맨살_0도.jpg',
        '10-가슴_복부_상부대흉근_남_장비_0도.jpg',
        '10-가슴_복부_상부대흉근_남_맨살_45도.jpg',
        '10-가슴_복부_상부대흉근_남_장비_45도.jpg',
      ],
      imageWomanRight: [
        '10-가슴_복부_상부대흉근_여_맨살_0도.jpg',
        '10-가슴_복부_상부대흉근_여_장비_0도.jpg',
        '10-가슴_복부_상부대흉근_여_맨살_45도.jpg',
        '10-가슴_복부_상부대흉근_여_장비_45도.jpg',
      ],
      imageGuideLeft: [
        '10-가슴_복부_상부대흉근_마좌.jpg',
        '10-가슴_복부_상부대흉근_근좌.jpg',
      ],
      imageGuideRight: [
        '10-가슴_복부_상부대흉근_마우.jpg',
        '10-가슴_복부_상부대흉근_근우.jpg',
      ],
      exerciseVideo: m10UpperPectoralisExerciseList,
    ),
    //--------------------------------------------------------------------------
    // 부착 가이드
    if (dvSetting.guideContents != EmaGuideContents.exercise)
      textNormalC(
          '쇄골 선(A)에서 장비 1개 간격을 띄우고,'
          ' 가슴 중심세로선(B)에서 장비 반개 간격 띄운 후 가로방향으로 부착합니다.',
          padW: asWidth(18)),
    //--------------------------------------------------------------------------
    // 관련운동
    if (dvSetting.guideContents == EmaGuideContents.exercise)
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          textNormalC('저항을 주며 팔로 위로 밀거나 모으는 동작', padW: asWidth(18)),
          textSub('(1) 양손 위로 들고 마주밀기: 정지한 상태로 밀거나 좌우로 조금씩 움직이며 밀기',
              padW: asWidth(18)),
          textSub('(2) 양손 위로 팔 펴고 마주밀기', padW: asWidth(18)),
          textSub('(3) 디클라인 푸쉬업', padW: asWidth(18)),
          textSub('(4) 밴드 위로 밀기(인클라인 프레스)', padW: asWidth(18)),
          textSub('(5) 밴드 크로스 오버 로우', padW: asWidth(18)),
          textSub('(6) 덤벨 위로 밀기(인클라인 프레스)', padW: asWidth(18)),
          textSub('(7) 바벨 위로 밀기(인클라인 프레스)', padW: asWidth(18)),
          textSub('(8) 머신 위로 밀기(인클라인 체스트 프레스)', padW: asWidth(18)),
        ],
      ),
  ]);
}

//==============================================================================
// 101 중부대흉근
//==============================================================================
Widget m11MiddlePectoralis() {
  return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    guideSlideImage(
      isViewLeft: dvSetting.isViewLeft,
      guideContents: dvSetting.guideContents,
      imageManRight: [
        '11-가슴_복부_중부대흉근_남_맨살_0도.jpg',
        '11-가슴_복부_중부대흉근_남_장비_0도.jpg',
        '11-가슴_복부_중부대흉근_남_맨살_45도.jpg',
        '11-가슴_복부_중부대흉근_남_장비_45도.jpg',
      ],
      imageWomanRight: [
        '11-가슴_복부_중부대흉근_남_맨살_0도.jpg',
        '11-가슴_복부_중부대흉근_남_장비_0도.jpg',
        '11-가슴_복부_중부대흉근_남_맨살_45도.jpg',
        '11-가슴_복부_중부대흉근_남_장비_45도.jpg',
      ],
      imageGuideLeft: [
        '11-가슴_복부_중부대흉근_마좌.jpg',
        '11-가슴_복부_중부대흉근_근좌.jpg',
      ],
      imageGuideRight: [
        '11-가슴_복부_중부대흉근_마우.jpg',
        '11-가슴_복부_중부대흉근_근우.jpg',
      ],
      exerciseVideo: m11MiddlePectoralisExerciseList,
    ),
    //--------------------------------------------------------------------------
    // 부착 가이드
    if (dvSetting.guideContents != EmaGuideContents.exercise)
      textNormalC(
          '장비를 45도 기울인 상태에서 유두선(A) 위쪽에 맞추고,'
          ' 가슴 중심세로선(B)에서 장비 반개 간격 띄운 후 부착합니다.',
          padW: asWidth(18)),
    //--------------------------------------------------------------------------
    // 관련운동
    if (dvSetting.guideContents == EmaGuideContents.exercise)
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          textNormalC('저항을 주며 팔로 밀거나 모으는 동작', padW: asWidth(18)),
          textSub('(1) 양손 마주밀기: 정지한 상태 혹은 좌우로 조금씩 움직이며 밀기', padW: asWidth(18)),
          textSub('(2) 양손 팔 펴고 마주밀기', padW: asWidth(18)),
          textSub('(3) 푸시 업', padW: asWidth(18)),
          textSub('(4) 밴드 밀기(프레스)', padW: asWidth(18)),
          textSub('(5) 밴드 크로스 오버 미들', padW: asWidth(18)),
          textSub('(6) 케이블 크로스 오버 미들', padW: asWidth(18)),
          textSub('(7) 덤벨 밀기(프레스)', padW: asWidth(18)),
          textSub('(8) 바벨 밀기(벤치 프레스)', padW: asWidth(18)),
          textSub('(9) 머신 가슴 날갯짓(팩토럴 플라이)', padW: asWidth(18)),
          textSub('(10) 머신 가슴 밀기(체스트 프레스)', padW: asWidth(18)),
        ],
      ),
  ]);
}

//==============================================================================
// 102 하부대흉근
//==============================================================================
Widget m12LowerPectoralis() {
  return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    guideSlideImage(
      isViewLeft: dvSetting.isViewLeft,
      guideContents: dvSetting.guideContents,
      imageManRight: [
        '12-가슴_복부_하부대흉근_남_맨살_0도.jpg',
        '12-가슴_복부_하부대흉근_남_장비_0도.jpg',
        '12-가슴_복부_하부대흉근_남_맨살_45도.jpg',
        '12-가슴_복부_하부대흉근_남_장비_45도.jpg',
      ],
      imageWomanRight: [
        '12-가슴_복부_하부대흉근_남_맨살_0도.jpg',
        '12-가슴_복부_하부대흉근_남_장비_0도.jpg',
        '12-가슴_복부_하부대흉근_남_맨살_45도.jpg',
        '12-가슴_복부_하부대흉근_남_장비_45도.jpg',
      ],
      imageGuideLeft: [
        '12-가슴_복부_하부대흉근_마좌.jpg',
        '12-가슴_복부_하부대흉근_근좌.jpg',
      ],
      imageGuideRight: [
        '12-가슴_복부_하부대흉근_마우.jpg',
        '12-가슴_복부_하부대흉근_근우.jpg',
      ],
      exerciseVideo: m12LowerPectoralisExerciseList,
    ),
    //--------------------------------------------------------------------------
    // 부착 가이드
    if (dvSetting.guideContents != EmaGuideContents.exercise)
      textNormalC(
          '장비를 45도 기울인 상태에서 중심을 유두선(A)에 맞추고,'
          ' 가슴 중심세로선(B)에서 장비 반개 간격 띄운 후 부착 합니다.',
          padW: asWidth(18)),
    //--------------------------------------------------------------------------
    // 관련운동
    if (dvSetting.guideContents == EmaGuideContents.exercise)
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          textNormalC('저항을 주며 팔로 아래로 밀거나 모으는 동작', padW: asWidth(18)),
          textSub('(1) 양손 아래로 팔 펴고 마주밀기', padW: asWidth(18)),
          textSub('(2) 인클라인 푸시 업', padW: asWidth(18)),
          textSub('(3) 밴드 아래로 밀기(디클라인 프레스)', padW: asWidth(18)),
          textSub('(4) 밴드 크로스 오버 하이', padW: asWidth(18)),
          textSub('(5) 케이블 크로스 오버 하이', padW: asWidth(18)),
          textSub('(6) 덤벨 아래로 밀기(디클라인 프레스)', padW: asWidth(18)),
          textSub('(7) 바벨 아래로 밀기(디클라인 프레스)', padW: asWidth(18)),
          textSub('(8) 머신 체스트 딥스', padW: asWidth(18)),
        ],
      ),
  ]);
}

//==============================================================================
// 130 앞톱니근
// ==============================================================================
Widget m13SerratusAnterior() {
  return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    guideSlideImage(
      isViewLeft: dvSetting.isViewLeft,
      guideContents: dvSetting.guideContents,
      imageManRight: [
        '13-가슴_복부_전거근_남_맨살_0도.jpg',
        '13-가슴_복부_전거근_남_장비_0도.jpg',
        '13-가슴_복부_전거근_남_맨살_45도.jpg',
        '13-가슴_복부_전거근_남_장비_45도.jpg',
        '13-가슴_복부_전거근_남_맨살_90도.jpg',
        '13-가슴_복부_전거근_남_장비_90도.jpg',
      ],
      imageWomanRight: [
        '13-가슴_복부_전거근_여_맨살_0도.jpg',
        '13-가슴_복부_전거근_여_장비_0도.jpg',
        '13-가슴_복부_전거근_여_맨살_45도.jpg',
        '13-가슴_복부_전거근_여_장비_45도.jpg',
        '13-가슴_복부_전거근_여_맨살_90도.jpg',
        '13-가슴_복부_전거근_여_장비_90도.jpg',
      ],
      imageGuideLeft: [
        '13-가슴_복부_전거근_마좌.jpg',
        '13-가슴_복부_전거근_근좌.jpg',
      ],
      imageGuideRight: [
        '13-가슴_복부_전거근_마우.jpg',
        '13-가슴_복부_전거근_근우.jpg',
      ],
      exerciseVideo:m13SerratusAnteriorExerciseList,
    ),
    //--------------------------------------------------------------------------
    // 부착 가이드
    if (dvSetting.guideContents != EmaGuideContents.exercise)
      textNormalC('유두라인(A) 아래, 겨드랑이 앞 수직선(B) 앞쪽으로 45도 기울인 후 부착합니다.',
          padW: asWidth(18)),
    //--------------------------------------------------------------------------
    // 관련운동
    if (dvSetting.guideContents == EmaGuideContents.exercise)
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          textNormalC('저항을 주며 팔을 앞으로 끌어내리거나 미는 동작', padW: asWidth(18)),
          textSub('(1) 팔꿈치 벽밀기', padW: asWidth(18)),
          textSub('(2) 팔꿈치 밀기: 다른 손으로 저항하며 앞으로 밀기', padW: asWidth(18)),
          textSub('(3) 밴드 팔펴고 밀기(다이나믹 허그)', padW: asWidth(18)),
          textSub('(4) 밴드 암 슬라이드', padW: asWidth(18)),
          textSub('(5) 덤벨 풀 오버', padW: asWidth(18)),
          textSub('(6) 덤벨 팔 펴고 밀기(체스트 프레스 플러스)', padW: asWidth(18)),
          textSub('(7) 바벨 풀오버', padW: asWidth(18)),
          textSub('(8) 머신 팔 펴고 밀기(체스트 프레스 플러스)', padW: asWidth(18)),
        ],
      ),
  ]);
}

//==============================================================================
// 140 상 승모근
// ==============================================================================
Widget m16UpperTrapezius() {
  return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    guideSlideImage(
      isViewLeft: dvSetting.isViewLeft,
      guideContents: dvSetting.guideContents,
      imageManRight: [
        '17-등_상승모근_남_맨살_0도.jpg',
        '17-등_상승모근_남_장비_0도.jpg',
        '17-등_상승모근_남_맨살_45도.jpg',
        '17-등_상승모근_남_장비_45도.jpg',
      ],
      imageWomanRight: [
        '17-등_상승모근_여_맨살_0도.jpg',
        '17-등_상승모근_여_장비_0도.jpg',
        '17-등_상승모근_여_맨살_45도.jpg',
        '17-등_상승모근_여_장비_45도.jpg',
        '17-등_상승모근_여_맨살_90도.jpg',
        '17-등_상승모근_여_장비_90도.jpg',
      ],
      imageGuideLeft: [
        '17-등_상승모근_마좌.jpg',
        '17-등_상승모근_근좌.jpg',
      ],
      imageGuideRight: [
        '17-등_상승모근_마우.jpg',
        '17-등_상승모근_근우.jpg',
      ],
      exerciseVideo: m16UpperTrapeziusExerciseList,
    ),
    //--------------------------------------------------------------------------
    // 부착 가이드
    if (dvSetting.guideContents != EmaGuideContents.exercise)
      textNormalC('어깨 중심선(A) 뒤쪽, 목 경계선(B) 아래쪽에 가로방향으로 부착합니다.',
          padW: asWidth(18)),
    //--------------------------------------------------------------------------
    // 관련운동
    if (dvSetting.guideContents == EmaGuideContents.exercise)
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          textNormalC('저항을 주며 어깨를 위로 으쓱하는 동작', padW: asWidth(18)),
          textSub('(1) 의자 당기기: 의자 아래부분을 잡고 위로 당김', padW: asWidth(18)),
          textSub('(2) 밴드 으쓱(슈러그)', padW: asWidth(18)),
          textSub('(3) 밴드 대각 펼치기(다이아고널 익스텐션)', padW: asWidth(18)),
          textSub('(4) 덤벨 으쓱(슈러그)', padW: asWidth(18)),
          textSub('(5) 바벨 으쓱(슈러그)', padW: asWidth(18)),
        ],
      ),
  ]);
}

//==============================================================================
// 141 중 승모근
// ==============================================================================
Widget m17MiddleTrapezius() {
  return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    guideSlideImage(
      isViewLeft: dvSetting.isViewLeft,
      guideContents: dvSetting.guideContents,
      imageManRight: [
        '18-등_중승모근_남_맨살_0도.jpg',
        '18-등_중승모근_남_장비_0도.jpg',
        '18-등_중승모근_남_맨살_45도.jpg',
        '18-등_중승모근_남_장비_45도.jpg',
      ],
      imageWomanRight: [
        '18-등_중승모근_여_맨살_0도.jpg',
        '18-등_중승모근_여_장비_0도.jpg',
        '18-등_중승모근_여_맨살_45도.jpg',
        '18-등_중승모근_여_장비_45도.jpg',
      ],
      imageGuideLeft: [
        '18-등_중승모근_마좌.jpg',
        '18-등_중승모근_근좌.jpg',
      ],
      imageGuideRight: [
        '18-등_중승모근_마우.jpg',
        '18-등_중승모근_근우.jpg',
      ],
      exerciseVideo: m17MiddleTrapeziusExerciseList,
    ),
    //--------------------------------------------------------------------------
    // 부착 가이드
    if (dvSetting.guideContents != EmaGuideContents.exercise)
      textNormalC(
          '어깨 선(A)에서 장비 1개 간격 아래,'
          ' 등 중심선(B)에서 장비 반개 띄워서 가로방향으로 부착합니다.'
          ' 중 승모근에 부착이 어려운 경우 광배근에 부착해도 됩니다.',
          padW: asWidth(18)),
    //--------------------------------------------------------------------------
    // 관련운동
    if (dvSetting.guideContents == EmaGuideContents.exercise)
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          textNormalC(
              '저항을 주며 몸으로 당기거나 옆으로 팔을 T 형태로 드는 동작.'
              ' 당기는 운동은 광배근이 함께 자극됨',
              padW: asWidth(18)),
          textSub('(1) 팔 당기기: 다른 팔로 저항 주며 팔을 뒤로 당기기', padW: asWidth(18)),
          textSub('(2) 몸을 숙이고 의자 당기기: 의자 아래부분을 잡고 위로 당김', padW: asWidth(18)),
          textSub('(3) 밴드 노젓기(시티드 로우)', padW: asWidth(18)),
          textSub('(4) 밴드 T 올리기(T 레이즈)', padW: asWidth(18)),
          textSub('(5) 밴드 노젓기(시티드 로우)', padW: asWidth(18)),
          textSub('(6) 밴드 W 레이즈', padW: asWidth(18)),
          textSub('(7) 덤벨 T 올리기(T 레이즈)', padW: asWidth(18)),
          textSub('(8) 바벨 숙이고 노젓기(벤트 오버 로우)', padW: asWidth(18)),
          textSub('(9) 머신 노젓기(시티드 로우)', padW: asWidth(18)),
        ],
      ),
  ]);
}

//==============================================================================
// 142 하 승모근
// ==============================================================================
Widget m18LowerTrapezius() {
  return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    guideSlideImage(
      isViewLeft: dvSetting.isViewLeft,
      guideContents: dvSetting.guideContents,
      imageManRight: [
        '19-등_하승모근_남_맨살_0도.jpg',
        '19-등_하승모근_남_장비_0도.jpg',
        '19-등_하승모근_남_맨살_45도.jpg',
        '19-등_하승모근_남_장비_45도.jpg',
      ],
      imageWomanRight: [
        '19-등_하승모근_여_맨살_0도.jpg',
        '19-등_하승모근_여_장비_0도.jpg',
        '19-등_하승모근_여_맨살_45도.jpg',
        '19-등_하승모근_여_장비_45도.jpg',
      ],
      imageGuideLeft: [
        '19-등_하승모근_마좌.jpg',
        '19-등_하승모근_근좌.jpg',
      ],
      imageGuideRight: [
        '19-등_하승모근_마우.jpg',
        '19-등_하승모근_근우.jpg',
      ],
      exerciseVideo: m18LowerTrapeziusExerciseList,
    ),
    //--------------------------------------------------------------------------
    // 부착 가이드
    if (dvSetting.guideContents != EmaGuideContents.exercise)
      textNormalC('겨드랑이 수평선(A) 아래, 등 중심선(B)에서 장비 반개 띄워서 45도 기울여 부착합니다.',
          padW: asWidth(18)),
    //--------------------------------------------------------------------------
    // 관련운동
    if (dvSetting.guideContents == EmaGuideContents.exercise)
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          textNormalC(
              '저항을 주며 몸으로 당기거나 옆으로 팔을 T 형태로 드는 동작.'
              ' 당기는 운동은 광배근이 함께 자극됨',
              padW: asWidth(18)),
          textSub('(1) 팔 뒤로 Y 들기: Y자 형태로 팔 뒤로 들기. 물건 등을 이용해서 저항 주기',
              padW: asWidth(18)),
          textSub('(2) 팔 뒤로 들기 : 다른 쪽 다리를 들고 엎드린 상태에서 팔 뒤로 들기',
              padW: asWidth(18)),
          textSub('(3) 팔 뒤로 Y 들기 (리프트 오프)', padW: asWidth(18)),
          textSub('(4) 밴드 Y 올리기(Y 레이즈)', padW: asWidth(18)),
          textSub('(5) 밴드 Y 올리기(Y 레이즈)', padW: asWidth(18)),
          textSub('(6) 밴드 대각 펼치기(다이아고널 익스텐션)', padW: asWidth(18)),
          textSub('(7) 덤벨 Y 올리기(Y 레이즈)', padW: asWidth(18)),
        ],
      ),
  ]);
}

//==============================================================================
// 170 넓은 등근
// ==============================================================================
Widget m19LatissimusDorsi() {
  return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    guideSlideImage(
      isViewLeft: dvSetting.isViewLeft,
      guideContents: dvSetting.guideContents,
      imageManRight: [
        '20-등_광배근_남_맨살_0도.jpg',
        '20-등_광배근_남_장비_0도.jpg',
        '20-등_광배근_남_맨살_45도.jpg',
        '20-등_광배근_남_장비_45도.jpg',
      ],
      imageWomanRight: [
        '20-등_광배근_여_맨살_0도.jpg',
        '20-등_광배근_여_장비_0도.jpg',
        '20-등_광배근_여_맨살_45도.jpg',
        '20-등_광배근_여_장비_45도.jpg',
      ],
      imageGuideLeft: [
        '20-등_광배근_마좌.jpg',
        '20-등_광배근_근좌.jpg',
      ],
      imageGuideRight: [
        '20-등_광배근_마우.jpg',
        '20-등_광배근_근우.jpg',
      ],
      exerciseVideo: m19LatissimusDorsiExerciseList,
    ),
    //--------------------------------------------------------------------------
    // 부착 가이드
    if (dvSetting.guideContents != EmaGuideContents.exercise)
      textNormalC('등의 가장자리에서 명치 선(A)높이로 가로방향으로 부착합니다.', padW: asWidth(18)),
    //--------------------------------------------------------------------------
    // 관련운동
    if (dvSetting.guideContents == EmaGuideContents.exercise)
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          textNormalC('저항을 주며 아래로 잡아당기는 동작', padW: asWidth(18)),
          textSub('(1) 옆으로 책상누르기: 팔을 옆으로 벌린 후 책상을 누르기', padW: asWidth(18)),
          textSub('(2) 책상 잡아당기기', padW: asWidth(18)),
          textSub('(3) 밴드 잡아당기며 내리기(랫 풀 다운)', padW: asWidth(18)),
          textSub('(4) 밴드 아래로 잡아당기기(풀 다운)', padW: asWidth(18)),
          textSub('(5) 밴드 숙여서 노젓기(벤트 오버 로우)', padW: asWidth(18)),
          textSub('(6) 밴드 노젓기(로우)', padW: asWidth(18)),
          textSub('(7) 밴드 잡아당기기(랫 풀)', padW: asWidth(18)),
          textSub('(8) 케이블 스트레이트 암 풀 다운', padW: asWidth(18)),
          textSub('(9) 덤벨 숙여서 두팔 노젓기(벤트 오버 투암 로우)', padW: asWidth(18)),
          textSub('(10) 덤벨 디클라인 풀 오버', padW: asWidth(18)),
          textSub('(11) 머신 턱걸이(어시스트 친업)', padW: asWidth(18)),
          textSub('(12) 머신 랫 풀 다운', padW: asWidth(18)),
        ],
      ),
  ]);
}

//==============================================================================
// 180 복직근
// ==============================================================================
Widget m14RectusAbdominal() {
  return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    guideSlideImage(
      isViewLeft: dvSetting.isViewLeft,
      guideContents: dvSetting.guideContents,
      imageManRight: [
        '14-가슴_복부_복직근_남_맨살_0도.jpg',
        '14-가슴_복부_복직근_남_장비_0도.jpg',
        '14-가슴_복부_복직근_남_맨살_45도.jpg',
        '14-가슴_복부_복직근_남_장비_45도.jpg',
      ],
      imageWomanRight: [
        '14-가슴_복부_복직근_여_맨살_0도.jpg',
        '14-가슴_복부_복직근_여_장비_0도.jpg',
        '14-가슴_복부_복직근_여_맨살_45도.jpg',
        '14-가슴_복부_복직근_여_장비_45도.jpg',
      ],
      imageGuideLeft: [
        '14-가슴_복부_복직근_마좌.jpg',
        '14-가슴_복부_복직근_근좌.jpg',
      ],
      imageGuideRight: [
        '14-가슴_복부_복직근_마우.jpg',
        '14-가슴_복부_복직근_근우.jpg',
      ],
      exerciseVideo: m14RectusAbdominalExerciseList,
    ),
    //--------------------------------------------------------------------------
    // 부착 가이드
    if (dvSetting.guideContents != EmaGuideContents.exercise)
      textNormalC(
          '배꼽 가로선(A)에 중심을 맞추고'
          ' 복부 중심 수직선(B)에서 장비 반개를 띄운 후 세로방향으로 부착합니다.'
          ' 옷에 걸리는 경우 근육이 있는 좀 더 위쪽부위로 부착해도 됩니다.',
          padW: asWidth(18)),
    //--------------------------------------------------------------------------
    // 관련운동
    if (dvSetting.guideContents == EmaGuideContents.exercise)
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          textNormalC('저항을 주며 몸이나 다리를 숙이는 동작', padW: asWidth(18)),
          textSub(
              '(1) 다리 굽히기: 누워서 팔로 저항을 주며 다리를 상체 쪽으로 굽힘.'
              ' 앉아서 할 경우 몸을 숙이거나 다리를 들 때 팔로 저항 주기.',
              padW: asWidth(18)),
          textSub('(2) 플랭크', padW: asWidth(18)),
          textSub('(3) 사이드 플랭크', padW: asWidth(18)),
          textSub('(4) 다리 들기', padW: asWidth(18)),
          textSub('(5) 크런치 컬 업', padW: asWidth(18)),
          textSub('(6) 핑거 투 토', padW: asWidth(18)),
          textSub('(7) 밴드 리버스 크런치', padW: asWidth(18)),
          textSub('(8) 케이블 크런치', padW: asWidth(18)),
          textSub('(9) 무릎 올리기 (니 레이즈)', padW: asWidth(18)),
        ],
      ),
  ]);
}

//==============================================================================
// 190 배 바깥빗근
// ==============================================================================
Widget m15ExternalObliqueAbdominal() {
  return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    guideSlideImage(
      isViewLeft: dvSetting.isViewLeft,
      guideContents: dvSetting.guideContents,
      imageManRight: [
        '15-가슴_복부_외복사근_남_맨살_0도.jpg',
        '15-가슴_복부_외복사근_남_장비_0도.jpg',
        '15-가슴_복부_외복사근_남_맨살_45도.jpg',
        '15-가슴_복부_외복사근_남_장비_45도.jpg',
        '15-가슴_복부_외복사근_남_맨살_90도.jpg',
        '15-가슴_복부_외복사근_남_장비_90도.jpg',
      ],
      imageWomanRight: [
        '15-가슴_복부_외복사근_여_맨살_0도.jpg',
        '15-가슴_복부_외복사근_여_장비_0도.jpg',
        '15-가슴_복부_외복사근_여_맨살_45도.jpg',
        '15-가슴_복부_외복사근_여_장비_45도.jpg',
        '15-가슴_복부_외복사근_여_맨살_90도.jpg',
        '15-가슴_복부_외복사근_여_장비_90도.jpg',
      ],
      imageGuideLeft: [
        '15-가슴_복부_외복사근_마좌.jpg',
        '15-가슴_복부_외복사근_근좌.jpg',
      ],
      imageGuideRight: [
        '15-가슴_복부_외복사근_마우.jpg',
        '15-가슴_복부_외복사근_근우.jpg',
      ],
      exerciseVideo: m15ExternalObliqueAbdominalExerciseList,
    ),
    //--------------------------------------------------------------------------
    // 부착 가이드
    if (dvSetting.guideContents != EmaGuideContents.exercise)
      textNormalC('배꼽 가로선(A) 위쪽, 겨드랑이 앞 수직선(B) 앞쪽으로 장비를 45도 기울여 부착합니다.',
          padW: asWidth(18)),
    //--------------------------------------------------------------------------
    // 관련운동
    if (dvSetting.guideContents == EmaGuideContents.exercise)
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          textNormalC('저항을 주며 몸을 옆으로 숙이는 동작', padW: asWidth(18)),
          textSub('(1) 옆으로 몸 들기: 의자에 한 발을 걸치고 몸을 들어 올림', padW: asWidth(18)),
          textSub('(2) 엎드려 무릎 올리기: 양 무릎을 번갈아 올림', padW: asWidth(18)),
          textSub('(3) 라잉 벤트 니 오블리크 트위스트', padW: asWidth(18)),
          textSub('(4) 사이드 투 사이드', padW: asWidth(18)),
          textSub('(5) 벤트 니 트위스트', padW: asWidth(18)),
          textSub('(6) 밴드 옆으로 숙이기(사이드 벤드)', padW: asWidth(18)),
          textSub('(7) 밴드 러시안 트위스트', padW: asWidth(18)),
          textSub('(8) 덤벨 옆으로 숙이기(사이드 벤드)', padW: asWidth(18)),
          textSub('(9) 바벨 러시안 트위스트', padW: asWidth(18)),
        ],
      ),
  ]);
}

//==============================================================================
// 200 척추세움근
// ==============================================================================
Widget m20ErectorSpinae() {
  return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    guideSlideImage(
      isViewLeft: dvSetting.isViewLeft,
      guideContents: dvSetting.guideContents,
      imageManRight: [
        '21-등_척추기립근_남_맨살_0도.jpg',
        '21-등_척추기립근_남_장비_0도.jpg',
        '21-등_척추기립근_남_맨살_45도.jpg',
        '21-등_척추기립근_남_장비_45도.jpg',
      ],
      imageWomanRight: [
        '21-등_척추기립근_여_맨살_0도.jpg',
        '21-등_척추기립근_여_장비_0도.jpg',
        '21-등_척추기립근_여_맨살_45도.jpg',
        '21-등_척추기립근_여_장비_45도.jpg',
      ],
      imageGuideLeft: [
        '21-등_척추기립근_마좌.jpg',
        '21-등_척추기립근_근좌.jpg',
      ],
      imageGuideRight: [
        '21-등_척추기립근_마우.jpg',
        '21-등_척추기립근_근우.jpg',
      ],
      exerciseVideo:m20ErectorSpinaeExerciseList,
    ),
    //--------------------------------------------------------------------------
    // 부착 가이드
    if (dvSetting.guideContents != EmaGuideContents.exercise)
      textNormalC('배꼽 가로선(A)에 중심을 맞추고 등의 중심선(B)에서 장비 반개 띄워서 세로방향으로 부착합니다.',
          padW: asWidth(18)),
    //--------------------------------------------------------------------------
    // 관련운동
    if (dvSetting.guideContents == EmaGuideContents.exercise)
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          textNormalC('저항을 주며 몸을 일으키거나 펴는 동작', padW: asWidth(18)),
          textSub('(1) 몸 세우기: 몸을 숙이고 팔로 다리 뒤를 잡은 상태에서 상체 세우기',
              padW: asWidth(18)),
          textSub('(2) 상체 들기', padW: asWidth(18)),
          textSub('(3) 상체 들기', padW: asWidth(18)),
          textSub('(4) 엎드려 하체 들기', padW: asWidth(18)),
          textSub('(5) 밴드 굿모닝', padW: asWidth(18)),
          textSub('(6) 밴드 리버스 크런치', padW: asWidth(18)),
          textSub('(7) 밴드 버드독', padW: asWidth(18)),
          textSub('(8) 덤벨 슈퍼맨', padW: asWidth(18)),
          textSub('(9) 바벨 굿모닝', padW: asWidth(18)),
        ],
      ),
  ]);
}

//==============================================================================
// 210 큰 볼기근
// ==============================================================================
Widget m21GluteusMaximus() {
  return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    guideSlideImage(
      isViewLeft: dvSetting.isViewLeft,
      guideContents: dvSetting.guideContents,
      imageManRight:
          gv.setting.genderIndex.value == 0 || gv.setting.genderIndex.value == 2
              ? [
                  '23-다리_힙_둔근_여_맨살_0도.jpg',
                  '23-다리_힙_둔근_여_장비_0도.jpg',
                  '23-다리_힙_둔근_여_맨살_45도.jpg',
                  '23-다리_힙_둔근_여_장비_45도.jpg',
                ]
              : [],
      imageWomanRight: gv.setting.genderIndex.value == 1
          ? [
              '23-다리_힙_둔근_여_맨살_0도.jpg',
              '23-다리_힙_둔근_여_장비_0도.jpg',
              '23-다리_힙_둔근_여_맨살_45도.jpg',
              '23-다리_힙_둔근_여_장비_45도.jpg',
            ]
          : [],
      imageGuideLeft: [
        '23-다리_힙_둔근_마좌.jpg',
        '23-다리_힙_둔근_근좌.jpg',
      ],
      imageGuideRight: [
        '23-다리_힙_둔근_마우.jpg',
        '23-다리_힙_둔근_근우.jpg',
      ],
      exerciseVideo: m21GluteusMaximusExerciseList,
    ),
    //--------------------------------------------------------------------------
    // 부착 가이드
    if (dvSetting.guideContents != EmaGuideContents.exercise)
      textNormalC(
          '치골 가로선(A) 아래, 엉덩이 중심선(B)에서 장비 한개 띄워서 45도 방향에 부착합니다.'
          ' 둔근에 부착이 어렵다면 운동에 따라 중둔근 혹은 대퇴사두근이나 햄스트링에 붙여도 좋습니다.',
          padW: asWidth(18)),
    //--------------------------------------------------------------------------
    // 관련운동
    if (dvSetting.guideContents == EmaGuideContents.exercise)
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          textNormalC('다리를 위로 들어 올리거나 스쿼트 자세', padW: asWidth(18)),
          textSub('(1) 책상 짚고 다리 뒤로 들어 올리기', padW: asWidth(18)),
          textSub('(2) 다리 뒤로 들어 올리기', padW: asWidth(18)),
          textSub('(3) 엉덩이 뒤로 빼기 스쿼트(포티 스쿼트)', padW: asWidth(18)),
          textSub('(4) 밴드 발 뒤로 차기(힙 킥 백)', padW: asWidth(18)),
          textSub('(5) 밴드 데드리프트', padW: asWidth(18)),
          textSub('(6) 밴드 브릿지', padW: asWidth(18)),
          textSub('(7) 바벨 데드리프트', padW: asWidth(18)),
          textSub('(8) 바벨 힙 트러스트', padW: asWidth(18)),
        ],
      ),
  ]);
}

//==============================================================================
// 211 중간 볼기근
// ==============================================================================
Widget m22GluteusMedius() {
  return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    guideSlideImage(
      isViewLeft: dvSetting.isViewLeft,
      guideContents: dvSetting.guideContents,
      imageManRight: [
        '24-다리_힙_중둔근_남_맨살_0도.jpg',
        '24-다리_힙_중둔근_남_장비_0도.jpg',
        '24-다리_힙_중둔근_남_맨살_45도.jpg',
        '24-다리_힙_중둔근_남_장비_45도.jpg',
      ],
      imageWomanRight: [
        '24-다리_힙_중둔근_여_맨살_0도.jpg',
        '24-다리_힙_중둔근_여_장비_0도.jpg',
        '24-다리_힙_중둔근_여_맨살_45도.jpg',
        '24-다리_힙_중둔근_여_장비_45도.jpg',
      ],
      imageGuideLeft: [
        '24-다리_힙_중둔근_마좌.jpg',
        '24-다리_힙_중둔근_근좌.jpg',
      ],
      imageGuideRight: [
        '24-다리_힙_중둔근_마우.jpg',
        '24-다리_힙_중둔근_근우.jpg',
      ],
      exerciseVideo: m22GluteusMediusExerciseList,
    ),
    //--------------------------------------------------------------------------
    // 부착 가이드
    if (dvSetting.guideContents != EmaGuideContents.exercise)
      textNormalC(
          '치골 가로선(A) 위, 한쪽 엉덩이 세로 중심선(C)에서 바깥 쪽에 45도 방향에 부착합니다.'
          ' 중둔근에 부착이 어려운 경우 대퇴사두근이나 다리 바깥 측면에 부착합니다.',
          padW: asWidth(18)),
    //--------------------------------------------------------------------------
    // 관련운동
    if (dvSetting.guideContents == EmaGuideContents.exercise)
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          textNormalC('저항을 주며 다리를 옆으로 벌리는 자세', padW: asWidth(18)),
          textSub('(1) 엎드려 다리 옆으로 벌리기', padW: asWidth(18)),
          textSub('(2) 밴드 다리 벌리기', padW: asWidth(18)),
          textSub('(3) 밴드 옆으로 누워 다리 벌리기', padW: asWidth(18)),
          textSub('(4) 밴드 엉덩이 들고 다리 벌리기', padW: asWidth(18)),
          textSub('(5) 머신 다리 벌리기(힙 업덕션)', padW: asWidth(18)),
        ],
      ),
  ]);
}

//==============================================================================
// 220 대퇴사두근
// ==============================================================================
Widget m23QuadricepsFemoris() {
  return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    guideSlideImage(
      isViewLeft: dvSetting.isViewLeft,
      guideContents: dvSetting.guideContents,
      imageManRight: [
        '26-다리_힙_대퇴사두근_남_맨살_0도.jpg',
        '26-다리_힙_대퇴사두근_남_장비_0도.jpg',
        '26-다리_힙_대퇴사두근_남_맨살_45도.jpg',
        '26-다리_힙_대퇴사두근_남_장비_45도.jpg',
      ],
      imageWomanRight: [
        '26-다리_힙_대퇴사두근_여_맨살_0도.jpg',
        '26-다리_힙_대퇴사두근_여_장비_0도.jpg',
        '26-다리_힙_대퇴사두근_여_맨살_45도.jpg',
        '26-다리_힙_대퇴사두근_여_장비_45도.jpg',
      ],
      imageGuideLeft: [
        '26-다리_힙_대퇴사두근_마좌.jpg',
        '26-다리_힙_대퇴사두근_근좌.jpg',
      ],
      imageGuideRight: [
        '26-다리_힙_대퇴사두근_마우.jpg',
        '26-다리_힙_대퇴사두근_근우.jpg',
      ],
      exerciseVideo: m23QuadricepsFemorisExerciseList,
    ),
    //--------------------------------------------------------------------------
    // 부착 가이드
    if (dvSetting.guideContents != EmaGuideContents.exercise)
      textNormalC('허벅지 가로 중심선(A)에서 장비 반개 띄우고, 허벅지 세로 중심선(B) 중앙에 세로방향으로 부착합니다.',
          padW: asWidth(18)),
    //--------------------------------------------------------------------------
    // 관련운동
    if (dvSetting.guideContents == EmaGuideContents.exercise)
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          textNormalC('저항을 주며 다리를 펴는 자세', padW: asWidth(18)),
          textSub('(1) 다리 펴기: 다른 다리로 저항을 주며 다리 펴기', padW: asWidth(18)),
          textSub('(2) 밴드 다리 펴기(레그 익스텐션)', padW: asWidth(18)),
          textSub('(3) 밴드 백 스쿼트', padW: asWidth(18)),
          textSub('(4) 밴드 스플릿 스쿼트', padW: asWidth(18)),
          textSub('(5) 덤벨 스플릿 스쿼트', padW: asWidth(18)),
          textSub('(6) 바벨 백 스쿼트', padW: asWidth(18)),
          textSub('(7) 머신 다리펴기(레그 익스텐션)', padW: asWidth(18)),
          textSub('(8) 머신 다리 누르기(레그 프레스)', padW: asWidth(18)),
        ],
      ),
  ]);
}

//==============================================================================
// 230 넙다리뒤근
// ==============================================================================
Widget m24Hamstrings() {
  return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    guideSlideImage(
      isViewLeft: dvSetting.isViewLeft,
      guideContents: dvSetting.guideContents,
      imageManRight: [
        '27-다리_힙_슬괵근_남_맨살_0도.jpg',
        '27-다리_힙_슬괵근_남_장비_0도.jpg',
        '27-다리_힙_슬괵근_남_맨살_45도.jpg',
        '27-다리_힙_슬괵근_남_장비_45도.jpg',
      ],
      imageWomanRight: [
        '27-다리_힙_슬괵근_여_맨살_0도.jpg',
        '27-다리_힙_슬괵근_여_장비_0도.jpg',
        '27-다리_힙_슬괵근_여_맨살_45도.jpg',
        '27-다리_힙_슬괵근_여_장비_45도.jpg',
      ],
      imageGuideLeft: [
        '27-다리_힙_슬괵근_마좌.jpg',
        '27-다리_힙_슬괵근_근좌.jpg',
      ],
      imageGuideRight: [
        '27-다리_힙_슬괵근_마우.jpg',
        '27-다리_힙_슬괵근_근우.jpg',
      ],
      exerciseVideo: m24HamstringsExerciseList,
    ),
    //--------------------------------------------------------------------------
    // 부착 가이드
    if (dvSetting.guideContents != EmaGuideContents.exercise)
      textNormalC('뒤 허벅지 가로 중심선(A) 위쪽으로 장비 반개 띄우고 허벅지 세로 중심선(B)에서 안쪽 세로방향으로 부착합니다.',
          padW: asWidth(18)),
    //--------------------------------------------------------------------------
    // 관련운동
    if (dvSetting.guideContents == EmaGuideContents.exercise)
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          textNormalC('저항을 주며 다리 굽히기', padW: asWidth(18)),
          textSub(
              '(1) 다리 굽히기: 다른 다리로 저항을 주며 다리 굽히기.'
              ' 과도하게 굽히면 저항을 주는 다리의 무릎이 아플 수 있으므로 주의 필요',
              padW: asWidth(18)),
          textSub('(2) 다리 굽히기: 의자에 앉자 다른 다리로 저항을 주며 다리를 굽힘', padW: asWidth(18)),
          textSub(
              '(3) 몸통 들기: 다리를 의자에 걸치고 몸통을 들어 올림.'
              ' 이때 몸이 일자가 되어도 되며, 자극이 약할 경우 한 다리로 수행',
              padW: asWidth(18)),
          textSub('(4) 노르딕 컬', padW: asWidth(18)),
          textSub('(5) 밴드 레그 컬', padW: asWidth(18)),
          textSub('(6) 밴드 스모 데드리프트', padW: asWidth(18)),
          textSub('(7) 밴드 한 다리 데드리프트', padW: asWidth(18)),
          textSub('(8) 덤벨 한 다리 데드리프트', padW: asWidth(18)),
          textSub('(9) 머신 레그 컬', padW: asWidth(18)),
        ],
      ),
  ]);
}

//==============================================================================
// 240 앞 정강근
// ==============================================================================
Widget m26TibialisAnterior() {
  return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    guideSlideImage(
      isViewLeft: dvSetting.isViewLeft,
      guideContents: dvSetting.guideContents,
      imageManRight: [
        '29-다리_힙_전경골근_남_맨살_0도.jpg',
        '29-다리_힙_전경골근_남_장비_0도.jpg',
        '29-다리_힙_전경골근_남_맨살_45도.jpg',
        '29-다리_힙_전경골근_남_장비_45도.jpg',
      ],
      imageWomanRight: [
        '29-다리_힙_전경골근_여_맨살_0도.jpg',
        '29-다리_힙_전경골근_여_장비_0도.jpg',
        '29-다리_힙_전경골근_여_맨살_45도.jpg',
        '29-다리_힙_전경골근_여_장비_45도.jpg',
      ],
      imageGuideLeft: [
        '29-다리_힙_전경골근_마좌.jpg',
        '29-다리_힙_전경골근_근좌.jpg',
      ],
      imageGuideRight: [
        '29-다리_힙_전경골근_마우.jpg',
        '29-다리_힙_전경골근_근우.jpg',
      ],
      exerciseVideo: m26TibialisAnteriorExerciseList,
    ),
    //--------------------------------------------------------------------------
    // 부착 가이드
    if (dvSetting.guideContents != EmaGuideContents.exercise)
      textNormalC('정강이 가로 중심선(A)에서 장비 반개 아래, 정강이 세로 중심선(B)에서 바깥쪽으로 세로방향으로 부착합니다.',
          padW: asWidth(18)),
    //--------------------------------------------------------------------------
    // 관련운동
    if (dvSetting.guideContents == EmaGuideContents.exercise)
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          textNormalC('저항을 주며 발등 들거나 밖으로 돌리기', padW: asWidth(18)),
          textSub('(1) 발등 들기: 다른 다리 장딴지로 저항하며 발등 들기', padW: asWidth(18)),
          textSub('(2) 발등 누르기: 다른 발로 발등 누르며 들기', padW: asWidth(18)),
          textSub('(3) 발등 옆날 누르기: 다른 발 옆날로 발등 누르며 들기', padW: asWidth(18)),
          textSub('(4) 밴드 발등 들기(도지 플렉션)', padW: asWidth(18)),
          textSub('(5) 밴드 발등 바깥 돌리기(에버젼)', padW: asWidth(18)),
          textSub('(6) 밴드 래터럴 게이트', padW: asWidth(18)),
          textSub('(7) 밴드 바깥 돌리기(에버젼)', padW: asWidth(18)),
          textSub('(8) 밴드 브릿지', padW: asWidth(18)),
        ],
      ),
  ]);
}

//==============================================================================
// 250 장딴지근
// ==============================================================================
Widget m27Gastrocnemius() {
  return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    guideSlideImage(
      isViewLeft: dvSetting.isViewLeft,
      guideContents: dvSetting.guideContents,
      imageManRight: [
        '28-다리_힙_비복근_남_맨살_0도.jpg',
        '28-다리_힙_비복근_남_장비_0도.jpg',
        '28-다리_힙_비복근_남_맨살_45도.jpg',
        '28-다리_힙_비복근_남_장비_45도.jpg',
      ],
      imageWomanRight: [
        '28-다리_힙_비복근_여_맨살_0도.jpg',
        '28-다리_힙_비복근_여_장비_0도.jpg',
        '28-다리_힙_비복근_여_맨살_45도.jpg',
        '28-다리_힙_비복근_여_장비_45도.jpg',
      ],
      imageGuideLeft: [
        '28-다리_힙_비복근_마좌.jpg',
        '28-다리_힙_비복근_근좌.jpg',
      ],
      imageGuideRight: [
        '28-다리_힙_비복근_마우.jpg',
        '28-다리_힙_비복근_근우.jpg',
      ],
      exerciseVideo: m27GastrocnemiusExerciseList,
    ),
    //--------------------------------------------------------------------------
    // 부착 가이드
    if (dvSetting.guideContents != EmaGuideContents.exercise)
      textNormalC(
          '장딴지 가로 중심선(A)에서 장비 반개 아래, 장딴지 세로 중심선(B)에서 안쪽으로 다리 세로방향으로 부착합니다.',
          padW: asWidth(18)),
    //--------------------------------------------------------------------------
    // 관련운동
    if (dvSetting.guideContents == EmaGuideContents.exercise)
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          textNormalC('저항을 주며 장딴지로 몸을 들기', padW: asWidth(18)),
          textSub('(1) 장딴지 벽 밀기: 장딴지를 몸을 들며 벽 밀기', padW: asWidth(18)),
          textSub('(2) 밴드 발바닥 굽히기(플랜터 플렉션)', padW: asWidth(18)),
          textSub('(3) 덤벨 한 다리 들기(원 레그 레이즈)', padW: asWidth(18)),
          textSub('(4) 바벨 장딴지 들기(카프 레이즈)', padW: asWidth(18)),
        ],
      ),
  ]);
}

//==============================================================================
// 270 모음근
// ==============================================================================
Widget m25Adductor() {
  return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    guideSlideImage(
      isViewLeft: dvSetting.isViewLeft,
      guideContents: dvSetting.guideContents,
      imageManRight: [
        '25-다리_힙_내전근_남_맨살_0도.jpg',
        '25-다리_힙_내전근_남_장비_0도.jpg',
        '25-다리_힙_내전근_남_맨살_45도.jpg',
        '25-다리_힙_내전근_남_장비_45도.jpg',
      ],
      imageWomanRight: [
        '25-다리_힙_내전근_여_맨살_0도.jpg',
        '25-다리_힙_내전근_여_장비_0도.jpg',
        '25-다리_힙_내전근_여_맨살_45도.jpg',
        '25-다리_힙_내전근_여_장비_45도.jpg',
      ],
      imageGuideLeft: [
        '25-다리_힙_내전근_마좌.jpg',
        '25-다리_힙_내전근_근좌.jpg',
      ],
      imageGuideRight: [
        '25-다리_힙_내전근_마우.jpg',
        '25-다리_힙_내전근_근우.jpg',
      ],
      exerciseVideo: m25AdductorExerciseList,
    ),
    //--------------------------------------------------------------------------
    // 부착 가이드
    if (dvSetting.guideContents != EmaGuideContents.exercise)
      textNormalC('허벅지 가로 중심선(A)과 허벅지 안쪽 세로 중심선(B) 교차점에 세로방향으로 부착합니다.',
          padW: asWidth(18)),
    //--------------------------------------------------------------------------
    // 관련운동
    if (dvSetting.guideContents == EmaGuideContents.exercise)
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          textNormalC('저항을 주며 다리 모으기', padW: asWidth(18)),
          textSub('(1) 다리 모으기: 쿠션을 넣고 다리를 모음', padW: asWidth(18)),
          textSub('(2) 앉아서 다리 모으기', padW: asWidth(18)),
          textSub('(3) 머신 다리 모으기(힙 어덕션)', padW: asWidth(18)),
        ],
      ),
  ]);
}
