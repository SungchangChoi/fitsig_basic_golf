import 'package:fitsig_basic_golf/F0_BASIC/common_import.dart';

//==============================================================================
// 도움말 - FITSIG-BASIC 소개
//==============================================================================
Widget helpAboutFitsigBasic() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      //------------------------------------------------------------------------
      // 시작 이미지
      Stack(
        alignment: Alignment.topCenter,
        children: [
          Image.asset(
            'assets/images/help_img_big.jpg',
            width: asWidth(360),
          ),
          Container(
            width: asWidth(360),
            padding: EdgeInsets.symmetric(horizontal: asWidth(18)),
            alignment: Alignment.centerLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                asSizedBox(height: 34),
                TextN('심플한 기본 앱, 근력운동 솔루션',
                    fontSize: tm.s20,
                    color: tm.black,
                    fontWeight: FontWeight.bold),
                asSizedBox(height: 14),
                TextN('FITSIG-BASIC',
                    fontSize: tm.s20,
                    color: tm.mainBlue,
                    fontWeight: FontWeight.bold),
              ],
            ),
          )
        ],
      ),
      asSizedBox(height: 20),
      textNormal('FISIG-BASIC은 일반인을 위한 간단하고 사용이 쉬운 근전도(EMG)근력운동 솔루션 입니다.',
          padW: asWidth(18), fontColor: tm.grey04),
      textNormal('FISIG-BASIC 앱을 이용하기 위해서는 FITSIG 근전도 측정 디바이스가 필요합니다.',
          padW: asWidth(18), fontColor: tm.grey04),
      //------------------------------------------------------------------------
      // step1
      textTitleSmall('STEP. 1'.tr, padW: asWidth(18), padH: 0),
      textNormal('목표 근육에 제품을 부착한 후 근력 운동을 시작 하세요.',
          padW: asWidth(18), isBold: true),
      asSizedBox(height: 10),
      Center(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: asHeight(tm.s12)),
              child: Image.asset(
                'assets/images/device_three_type_3_512_1.png',
                height: asHeight(101),
              ),
            ),
            Container(
                padding: EdgeInsets.only(bottom: asHeight(tm.s12)),
                width: asWidth(180),
                alignment: Alignment.centerLeft,
                child: Image.asset(
                  'assets/icons/ic_arrow_curve1.png',
                  height: asHeight(40),
                )),
            SizedBox(
              width: asWidth(260),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextN('FITSIG', fontSize: tm.s12, color: tm.mainBlue),
                  asSizedBox(height: 4),
                  TextN('근전도 측정장비', fontSize: tm.s12, color: tm.mainBlue),
                ],
              ),
            ),
          ],
        ),
      ),
      asSizedBox(height: 20),
      textNormal(
          ': 앱에서 자동으로 최대근력(1RM) 값과  세트 운동량을 추정 계산합니다.'
              ' 1세트 운동이 끝나면 종료 후 결과를 확인하세요.',
          padW: asWidth(18),
          fontColor: tm.grey04),

      asSizedBox(height: 10),
      Container(
        margin: EdgeInsets.symmetric(horizontal: asWidth(18)),
        padding: EdgeInsets.symmetric(
            horizontal: asWidth(12), vertical: asHeight(10)),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(asHeight(8)), color: tm.grey01),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset('assets/icons/ic_notice.png',
                    height: asHeight(10), color: tm.pointOrange),
                asSizedBox(width: 4),
                TextN('유의사항', fontSize: tm.s12, color: tm.black),
              ],
            ),
            asSizedBox(height: 10),
            TextN(
              '1세트 운동량은 추정 값이며, 최대근력 값 정확도, 운동 반복 속도 등에 따라 달라질 수 있습니다.',
              fontSize: tm.s12,
              color: tm.grey03,
              height: 1.5,
            ),
          ],
        ),
      ),
      asSizedBox(height: 60),
      //------------------------------------------------------------------------
      // step2
      textTitleSmall('STEP. 2'.tr, padW: asWidth(18), padH: 0),
      textNormal(
          'FITSIG-BASIC 앱을 활용하여 근육 활성도를 실시간으로 확인하고'
              ' 힘을 적정 수준으로 조절하며 근력운동을 할 수 있습니다.',
          padW: asWidth(18),
          isBold: true),
      asSizedBox(height: 20),
      Center(
          child: Image.asset(
            'assets/images/group_1302.png',
            height: asHeight(130),
          )),
      asSizedBox(height: 20),
      textNormal(': 피트니스 시설이 아닌 집에서도 밴드나 맨몸으로 효과적인 근력 운동이 가능합니다.',
          padW: asWidth(18), fontColor: tm.grey04),
      asSizedBox(height: 60),
      //------------------------------------------------------------------------
      // step3
      textTitleSmall('STEP. 3'.tr, padW: asWidth(18), padH: 0),
      textNormal('적절한 양의 운동이 되도록 표준적인 1세트 운동량을 가이드하는 기능은 본 앱의 큰 장점입니다.',
          padW: asWidth(18), isBold: true),
      asSizedBox(height: 20),
      Center(
          child: Image.asset(
            'assets/images/group_1329.png',
            height: asHeight(130),
          )),
      asSizedBox(height: 20),

      textNormal(
          ': 반복횟수를 목표 힘으로 변환하여 가이드를 하므로'
              ' 밴드나 맨몸으로 운동할 때 마치 중량운동기구처럼 자극 강도를 조절할 수 있습니다.'
              ' 가령 12회 반복이라면 목표 힘 70%로 변환하여 그래프 상에서 목표 영역으로 표시합니다.',
          padW: asWidth(18),
          fontColor: tm.grey04),
      textNormal('FITSIG-BASIC 앱과 함께 재미있고 효율적인 근력운동을 시작해 보세요.',
          padW: asWidth(18), fontColor: tm.grey04),
      asSizedBox(height: 70),

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
            textSub('본 제품은 의료기기가 아닙니다.', isDot: true),
            textSub('본 제품은 저주파 자극기(EMS)가 아닙니다.', isDot: true),
            textSub(
                '본 제품은 운동에 따른 부상을 책임지지 않습니다. 반드시 운동 방법에 대해 전문가와 상의 후 안전하게 사용하세요.',
                isDot: true),
            textSub(
                '전극부착 위치를 매번 동일하게 해야 기존에 측정한 근육별 최대근력 값을 신뢰할 수 있습니다.'
                    ' 최대근력(1RM) 값은 목표 힘 영역 가이드 및 운동량이 계산에 사용되는 중요한 값입니다.'
                    ' 최대근력 값의 변동을 최소화 하려면 전극을 이전과 같은 위치에 붙여야 합니다.'
                    ' 표준적인 근육부착 위치는 별도의 가이드를 참조하시기 바랍니다.',
                isDot: true),
            asSizedBox(height: 30),
          ],
        ),
      ),
      // asSizedBox(height: 50),
    ],
  );
}