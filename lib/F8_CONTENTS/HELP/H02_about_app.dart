import 'package:fitsig_basic_golf/F0_BASIC/common_import.dart';

//==============================================================================
// 도움말 - 사용법 요약
//==============================================================================
RxBool _isViewTransverse = false.obs;

Widget helpInstructionsBrief() {
  double transverseWidth = asWidth(360) * 16 / 9;
  // transverseWidth = min(transverseWidth, asHeight(720));

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      textTitleSmall('기본 사용법 동영상', padW: asWidth(18)),

      asSizedBox(height: 20),

      //--------------------------------------------------------
      // 비디오 요약
      Obx(() {
        return Column(
          children: [
            RotatedBox(
              quarterTurns: !_isViewTransverse.value ? 0 : 1,
              child: Container(
                color: tm.white,
                width:
                    !_isViewTransverse.value ? asWidth(360) : transverseWidth,
                // height: isViewTransverse ? transverseWidth * 9/16 : asWidth(360) * 9/16,
                //---------------------------------------------
                // [1] 기본 비디오 플레이 : 유투브는 안되는 것으로 보임
                // child: VideoNetwork(
                //   callbackReplay: ((){}),
                //   videoID: 'kt9KJtsddc4',
                // ),

                //---------------------------------------------
                // [2] VideoYoutube
                // 중지했을 때 자막을 가리는 문제
                // child: VideoYoutube(
                //   // hideControls: true,
                //   callbackReplay: (() {
                //     // setState(() {});
                //     // print('click');
                //   }),
                //   videoId: 'kt9KJtsddc4',
                // ),

                //---------------------------------------------
                // [3] VideoYoutubeIframe
                // 종료 시 이상한 에러들 뜸
                child: const VideoYoutubeIframe(
                  videoId: 'kt9KJtsddc4',
                  autoPlay: false,
                ),
              ),
            ),
            if (!_isViewTransverse.value) asSizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                wButtonAwGeneral(
                  height: asHeight(34),
                  touchHeight: asHeight(54),
                  padWidth: asWidth(10),
                  backgroundColor: tm.white,
                  borderColor: tm.mainBlue,
                  onTap: () {
                    _isViewTransverse.value = !_isViewTransverse.value;
                  },
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/icons/ic_가로보기.png',
                        height: asHeight(14),
                        color: tm.mainBlue,
                      ),
                      asSizedBox(width: 8),
                      TextN(
                        !_isViewTransverse.value ? '가로보기' : '세로보기',
                        fontSize: tm.s14,
                        color: tm.mainBlue,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        );
      }),
      asSizedBox(height: 20),
      //------------------------------------------------------------------------
      // [1] 근전도 부착
      //------------------------------------------------------------------------
      textTitleSmall('STEP. 1', padW: asWidth(18)),
      textNormal('장비를 근육에 부착해 주세요.',
          isBold: true, padH: 0, padW: asWidth(18), fontSize: tm.s18),
      asSizedBox(height: 30),
      Container(
        margin: EdgeInsets.symmetric(horizontal: asWidth(18)),
        padding: EdgeInsets.symmetric(
            horizontal: asWidth(12), vertical: asHeight(20)),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(asHeight(16)),
          color: tm.softBlue,
        ),
        child: textNormal(
            '장비에 전극패치 (일회용 또는 재사용 전극)를 장착한 후에 신체의 근육에 부착하세요.'
            ' 근육부착 위치는 별도의 도움말 자료를 참고해 주세요.',
            fontColor: tm.mainBlue),
      ),
      asSizedBox(height: 18),
      //------------------------------------------------------------------------
      // 근전도 부착 예시 사진
      Container(
        padding: EdgeInsets.symmetric(
            horizontal: asWidth(18), vertical: asHeight(20)),
        color: tm.grey01,
        child: Column(
          children: [
            Row(
              children: [
                Image.asset('assets/icons/ic_notice.png',
                    height: asHeight(10), color: tm.pointOrange),
                asSizedBox(width: 4),
                TextN('근전도 부착 예시 사진',
                    fontSize: tm.s12,
                    color: tm.grey04,
                    fontWeight: FontWeight.bold),
              ],
            ),
            textNormal(
                '근육 가이드를 참고하여 부착하실 때, 기억하기 쉬운 각 개인의 신체 특징점을 이용하면'
                ' 다음에 다시 붙일 때 도움이 됩니다.',
                fontColor: tm.grey03,
                fontSize: tm.s12),
            asSizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(asHeight(8)),
                  child: Image.asset(
                    'assets/images/장비부착1.jpg',
                    width: asWidth(158),
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(asHeight(8)),
                  child: Image.asset(
                    'assets/images/장비부착2.jpg',
                    width: asWidth(158),
                  ),
                ),
              ],
            ),
            asSizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(asHeight(8)),
                  child: Image.asset('assets/images/장비부착3.jpg',
                      width: asWidth(158)),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(asHeight(8)),
                  child: Image.asset(
                    'assets/images/장비부착4.jpg',
                    width: asWidth(158),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
      asSizedBox(height: 40),
      // textNormal(' 근육에 제품을 부착할 때에는 매번 같은 위치에 부착하는 것이 중요합니다.'
      //     ' 위치가 바뀌면 최대근력 레벨도 달라져서 운동 가이드 오차가 커지거나 통계의 정확성이 떨어질 수 있습니다.'),

      // textImage('assets/images_help/근전도 부착 예.png',
      //     text: '근전도 부착 사진 예', height: asHeight(150), fit: BoxFit.fitHeight),
      //------------------------------------------------------------------------
      // [2] 장비연결
      //------------------------------------------------------------------------
      textTitleSmall('STEP. 2', padW: asWidth(18)),
      textNormal('장비와 디바이스를 연결해 주세요.',
          isBold: true, padH: 0, padW: asWidth(18), fontSize: tm.s18),
      textNormal(
          'FITSIG 장비 전원을 켠 뒤 앱 대기화면 상단의 상단의  장비모양 버튼을 클릭'
          '하여 장비 검색을 통해 스마트기기와 연결해 주세요.',
          fontColor: tm.grey04,
          padW: asWidth(18)),
      asSizedBox(height: 10),
      //------------------------------------------------------------------------
      // image
      Center(
        child: SizedBox(
          width: asHeight(360),
          height: asHeight(274),
          child: Stack(
            alignment: Alignment.topLeft,
            children: [
              //-----------------------------------------------------
              // 대기화면
              Positioned(
                top: asHeight(83),
                left: asHeight(30),
                child: Image.asset(
                  'assets/images/앱 대기화면.png',
                  width: asHeight(190),
                ),
              ),
              //-----------------------------------------------------
              // 파란색 원
              Positioned(
                top: 0,
                right: 0,
                child: Container(
                  width: asHeight(216),
                  height: asHeight(216),
                  decoration: BoxDecoration(
                      color: tm.mainBlue,
                      borderRadius: BorderRadius.circular(asHeight(108))),
                ),
              ),
              Positioned(
                top: asHeight(98),
                left: asHeight(170),
                child: Container(
                  height: asHeight(51),
                  width: asHeight(51),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: tm.white,
                      borderRadius: BorderRadius.circular(asHeight(26))),
                  child: Image.asset(
                    'assets/icons/ic_device_idle.png',
                    width: asHeight(31),
                  ),
                ),
              ),

              //-----------------------------------------------------
              // 글씨
              Positioned(
                top: asHeight(40),
                left: asHeight(189),
                child: TextN(
                  '장비 전원을 켜고\n상단 아이콘을 눌러주세요',
                  fontSize: tm.s12,
                  color: tm.white,
                  height: 1.5,
                ),
              ),

              //-----------------------------------------------------
              // 말풍선
              Positioned(
                top: asHeight(132),
                left: asHeight(105),
                child: SizedBox(
                  width: asHeight(108),
                  height: asHeight(48),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(asHeight(64), 0, 0, 0),
                        child: Image.asset(
                          'assets/icons/말풍선 꼭지.png',
                          color: tm.pointOrange,
                          width: asHeight(12),
                        ),
                      ),
                      Container(
                        height: asHeight(38),
                        width: asHeight(108),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: tm.pointOrange,
                            borderRadius: BorderRadius.circular(asHeight(23))),
                        child: TextN(
                          '장비 연결하기',
                          fontSize: tm.s14,
                          color: tm.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      Align(
        alignment: Alignment.center,
        child: Container(
          width: asWidth(324),
          height: asHeight(1),
          color: tm.grey02,
        ),
      ),
      asSizedBox(height: 18),
      Container(
        padding: EdgeInsets.symmetric(
            horizontal: asWidth(18), vertical: asHeight(20)),
        margin: EdgeInsets.symmetric(horizontal: asWidth(18)),
        decoration: BoxDecoration(
          color: tm.grey01,
          borderRadius: BorderRadius.circular(asHeight(8)),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Image.asset('assets/icons/ic_notice.png',
                    height: asHeight(10), color: tm.pointOrange),
                asSizedBox(width: 4),
                TextN('자동연결 기능',
                    fontSize: tm.s12,
                    color: tm.grey04,
                    fontWeight: FontWeight.bold),
              ],
            ),
            asSizedBox(height: 10),
            textNormal('자동연결 기능을 활성화 하면 별도의 검색과정 없이 마지막 연결된 장비와 자동으로 연결됩니다.'),
          ],
        ),
      ),

      asSizedBox(height: 40),
      //------------------------------------------------------------------------
      // [3] 측정 시작
      //------------------------------------------------------------------------
      textTitleSmall('STEP. 3', padW: asWidth(18)),
      textNormal('근력운동하며 측정을 시작해요',
          isBold: true, padH: 0, fontSize: tm.s18, padW: asWidth(18)),

      textSub('목표까지 힘을 주며 근력운동을 수행해 주세요. 1세트 근력운동을 진행하면 최대근력과 운동량을 자동으로 계산합니다.',
          isCheck: true, padW: asWidth(18)),
      textSub('목표한 반복횟수를 달성했거나 스스로 중단을 판단하였다면 하단의 정지버튼을 통해 운동을 종료합니다.',
          isCheck: true, padW: asWidth(18)),

      asSizedBox(height: 25),
      //--------------------------------------------
      // 슬라이드
      Stack(
        alignment: Alignment.topCenter,
        children: [
          slideBasic(
              durationSec: 7,
              enlargeCenterPage: false,
              width: asWidth(360),
              height: asHeight(400),
              //큰글씨 고려
              viewportFraction: 1,
              items: [
                //--------------------------------------------
                // 디바이스 연결 및 운동 시작
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: asWidth(18)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/측정_대기상태.png',
                        height: asHeight(264),
                      ),
                      asSizedBox(height: 20),
                      TextN(
                        '1. 디바이스 연결 및 운동 시작',
                        fontSize: tm.s12,
                        color: tm.black,
                        fontWeight: FontWeight.bold,
                        height: 1,
                      ),
                      asSizedBox(height: 10),
                      TextN(
                        '디바이스가 연결되면 하단의 버튼이 활성화됩니다. 셋팅을 마친 뒤 준비가 완료되면'
                        ' 운동 시작버튼을 클릭하여 측정을 시작합니다.',
                        fontSize: tm.s12,
                        color: tm.grey03,
                        height: 1.5,
                      ),
                    ],
                  ),
                ),
                //--------------------------------------------
                // 운동 수행 및 측정
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: asWidth(18)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/측정_진행 중.png',
                        height: asHeight(264),
                      ),
                      asSizedBox(height: 20),
                      TextN(
                        '2. 운동 수행 및 측정',
                        fontSize: tm.s12,
                        color: tm.black,
                        fontWeight: FontWeight.bold,
                        height: 1,
                      ),
                      asSizedBox(height: 10),
                      TextN(
                        '목표 영역을 확인하며 목표까지 힘을주어 근력운동을 수행하면 최대근력과 운동량을 측정하게 됩니다.',
                        fontSize: tm.s12,
                        color: tm.grey03,
                        height: 1.5,
                      ),
                    ],
                  ),
                ),
                //--------------------------------------------
                // 운동종료 및 결과저장
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: asWidth(18)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/측정_종료.png',
                        height: asHeight(264),
                      ),
                      asSizedBox(height: 20),
                      TextN(
                        '3. 운동종료 및 결과저장',
                        fontSize: tm.s12,
                        color: tm.black,
                        fontWeight: FontWeight.bold,
                        height: 1,
                      ),
                      asSizedBox(height: 10),
                      TextN(
                        '운동 종료 후 결과를 확인하고 저장버튼을 누르면 운동을 기록하게 됩니다.'
                        ' 저장된 기록은 [운동 기록 확인]에서 확인할 수 있습니다.',
                        fontSize: tm.s12,
                        color: tm.grey03,
                        height: 1.5,
                      ),
                    ],
                  ),
                ),
              ]),
          //--------------------------------------------
          // 좌우 버튼
          Padding(
            padding: EdgeInsets.only(
                left: asWidth(28), right: asWidth(28), top: asHeight(132)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset('assets/icons/ic_banner_arrow_l.png',
                    height: asHeight(20), color: tm.grey03),
                Image.asset('assets/icons/ic_banner_arrow_r.png',
                    height: asHeight(20), color: tm.grey03),
              ],
            ),
          ),
        ],
      ),
      asSizedBox(height: 30),

      //------------------------------------------------------------------------
      // 주의사항
      Container(
        color: tm.grey01,
        padding: EdgeInsets.symmetric(horizontal: asWidth(18)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            asSizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: asHeight(26),
                  padding: EdgeInsets.symmetric(horizontal: asWidth(10)),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(asHeight(13)),
                      color: tm.pointOrange.withOpacity(0.2),
                      border: Border.all(color: tm.pointOrange, width: 1)),
                  child: TextN(
                    '주의사항!',
                    fontSize: tm.s14,
                    color: tm.pointOrange,
                  ),
                ),
              ],
            ),
            textSub('1세트 운동량은 사람마다 다를 수 있으므로 무리하게 100%를 채울 필요는 없습니다.',
                isDot: true),
            textSub('안전하고 적절한 운동량이 되도록 스스로 판단하여 중단하는 것이 바람직합니다.', isDot: true),
            textSub('운동량이 100%를 넘었음에도 힘에 여유가 있다면 운동을 지속하셔도 좋습니다.', isDot: true),
            asSizedBox(height: 15),
          ],
        ),
      ),
      asSizedBox(height: 40),
      //------------------------------------------------------------------------
      // [4] 운동 결과 확인
      //------------------------------------------------------------------------
      textTitleSmall('STEP. 4', padW: asWidth(18)),
      textNormal('운동 결과를 확인해요.',
          isBold: true, padH: 0, fontSize: tm.s18, padW: asWidth(18)),
      textNormal('[운동기록확인] 페이지에서 저장된 근력운동 결과를 확인할 수 있습니다.',
          fontColor: tm.grey04, padW: asWidth(18)),

      textImage('assets/images/운동결과보고.png',
          text: '운동결과 보고서', height: asHeight(264), fit: BoxFit.fitHeight),
      textNormal('기록목록에서 개별 운동 결과 보고서를 확인할 수 있습니다.',
          fontColor: tm.grey03, padW: asWidth(18)),

      asSizedBox(height: 40),

      //------------------------------------------------------------------------
      // [5] 근력 성장 분석
      //------------------------------------------------------------------------
      textTitleSmall('STEP. 5', padW: asWidth(18)),
      textNormal('근력 성장 분석하기',
          isBold: true, padH: 0, fontSize: tm.s18, padW: asWidth(18)),
      asSizedBox(height: 5),
      textSub('통계 그래프에서 최대근력 근전도 값의 성장(= 근 신경의 성장)을 확인할 수 있습니다.',
          isCheck: true, padW: asWidth(18)),
      textSub('초보자라면 1~2개월 정도의 꾸준한 근력운동으로 20~30% 이상의 근전도 발달을 기대할 수 있습니다.',
          isCheck: true, padW: asWidth(18)),
      textSub(
          '근력운동을 하면 근신경과 힘이 우선 발달하며,'
          ' 근육 부피 증가를 보기 위해서는 통상적으로 3~6개월 이상의 좀 더 긴 시간이 필요합니다.',
          isCheck: true,
          padW: asWidth(18)),
      asSizedBox(height: 25),
      Center(
        child: Image.asset(
          'assets/images/통계그래프.png',
          width: asWidth(287),
        ),
      ),
      asSizedBox(height: 30),
      //------------------------------------------------------------------------
      // 주의사항
      Container(
        color: tm.grey01,
        padding: EdgeInsets.symmetric(horizontal: asWidth(18)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            asSizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: asHeight(26),
                  padding: EdgeInsets.symmetric(horizontal: asWidth(10)),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(asHeight(13)),
                      color: tm.pointOrange.withOpacity(0.2),
                      border: Border.all(color: tm.pointOrange, width: 1)),
                  child: TextN(
                    '주의사항!',
                    fontSize: tm.s14,
                    color: tm.pointOrange,
                  ),
                ),
              ],
            ),
            textSub(
                '근력 발달을 제대로 보기 위해서는 전극을 매번 동일한 위치에 붙여 최대근력 값의 신뢰성을 확보해야 합니다.',
                isDot: true),
            textSub('사람에 따라, 근육 부위에 따라, 운동 경력에 따라 근전도 성장률은 달라질 수 있습니다.',
                isDot: true),
            asSizedBox(height: 80),
          ],
        ),
      ),
    ],
  );
}
