import 'package:fitsig_basic_golf/F0_BASIC/common_import.dart';

//==============================================================================
// 도움말 - 최대 근력 레벨
//==============================================================================
Widget helpAbout1rm() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      //-------------------------
      // 01
      //-------------------------
      textTitleSmall('01'.tr, padW: asWidth(18), padH: 0),
      asSizedBox(height: 4),
      textNormal('최대근력(1RM) 값',
          isBold: true, padH: 0, padW: asWidth(18), fontSize: tm.s18),
      asSizedBox(height: 10),
      textNormal(
        ': 최대근력에서의 근전도 값은 전압(mV) 혹은 체감무게(kgf)로 나타낼 수 있습니다.',
        padW: asWidth(18),
        fontColor: tm.grey04,
      ),
      asSizedBox(height: 10),
      textNormal('*근전도 전압 1mV는 1/1000V를 뜻하며, 장비에서 측정된 근전도 신호를 평균하여 나타낸 값입니다.',
          padW: asWidth(18), fontColor: tm.mainBlue, fontSize: tm.s12),
      asSizedBox(height: 10),
      textNormal(
          '*체감무게는 측정된 근전도 전압평균의 10배 수준에 해당합니다.'
              ' 만일 전압이 1mV로 측정되었다면 체감무게는 10.0kgf으로 표시하고 있습니다.',
          padW: asWidth(18),
          fontColor: tm.mainBlue,
          fontSize: tm.s12),
      asSizedBox(height: 30),
      textSub(
        '통상적으로 1RM(1 Repeated Max)은 1회 들 수 있는 최대 무게를 뜻합니다.'
            ' 본 앱에서는 1회 낼 수 있는 최대 근전도 신호의 의미로 사용을 합니다.',
        isCheck: true,
        padW: asWidth(18),
      ),
      textSub(
        '체감무게는 위팔 두갈래근(이두근) 기준으로 설정하였습니다.'
            ' 10kg 무게의 아령을 들었다면 체감무게가 10kgf 근처로 표시됩니다.'
            ' 다만 사람마다 그리고 근육의 부위마다 체감무게는 크게 달라질 수 있으니 참조로만 활용하시기 바랍니다.',
        isCheck: true,
        padW: asWidth(18),
      ),
      asSizedBox(height: 12),
      Container(
        margin: EdgeInsets.symmetric(horizontal: asWidth(18)),
        padding: EdgeInsets.symmetric(
            horizontal: asWidth(12), vertical: asHeight(10)),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(asHeight(8)),
          color: tm.grey01,
        ),
        child: Column(
          children: [
            Row(
              children: [
                Image.asset('assets/icons/ic_notice.png',
                    height: asHeight(10), color: tm.pointOrange),
                asSizedBox(width: 4),
                TextN('유의사항',
                    fontSize: tm.s12,
                    color: tm.grey04,
                    fontWeight: FontWeight.bold),
              ],
            ),
            textSub(
              '최대근력 값은 실제 힘을 어느정도 반영하지만 완전히 비례하지는 않습니다.'
                  ' 상대적 비교를 통해 근육의 성장, 적절한 운동량 등을 확인하는 목적으로 활용하시기 바랍니다.',
              isCheck: false,
              isDot: false,
              fontSize: tm.s12,
              fontColor: tm.grey03,
            ),
          ],
        ),
      ),
      asSizedBox(height: 60),
      //-------------------------
      // 02
      //-------------------------
      textTitleSmall('02'.tr, padW: asWidth(18), padH: 0),
      asSizedBox(height: 4),
      textNormal(
        '최대근력 값 측정 방법',
        isBold: true,
        padH: 0,
        padW: asWidth(18),
        fontSize: tm.s18,
      ),
      asSizedBox(height: 10),
      textNormal(
        ': 최대근력은 근력운동을 1세트 수행하면 자동으로 측정됩니다.'
            ' 운동할 때 자세가 흐트러지지 않는 범위에서 최대 반복 가능한 수준까지 근력운동을 진행해 주세요.',
        padW: asWidth(18),
        fontColor: tm.grey04,
      ),
      asSizedBox(height: 20),
      textSub(
        '이전에 기록된 최대근력이 없다면 초기 1회는 세게 힘을 주는 것도 하나의 방법입니다.'
            ' 너무 센 힘을 주어 다치지 않도록 주의해 주세요.',
        isCheck: true,
        padW: asWidth(18),
      ),
      asSizedBox(height: 12),
      Container(
        margin: EdgeInsets.symmetric(horizontal: asWidth(18)),
        padding: EdgeInsets.symmetric(
            horizontal: asWidth(12), vertical: asHeight(10)),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(asHeight(8)),
          color: tm.grey01,
        ),
        child: Column(
          children: [
            Row(
              children: [
                Image.asset('assets/icons/ic_notice.png',
                    height: asHeight(10), color: tm.pointOrange),
                asSizedBox(width: 4),
                TextN('유의사항',
                    fontSize: tm.s12,
                    color: tm.grey04,
                    fontWeight: FontWeight.bold),
              ],
            ),
            textNormal(
              '본 앱에서는 최대근력 추정을 위해 신호의 최대 크기, 기존의 연구를 활용한 통계적 추정기법을 적용하고 있습니다.',
              fontSize: tm.s12,
              fontColor: tm.grey03,
            ),
          ],
        ),
      ),
      asSizedBox(height: 60),
      //-------------------------
      // 03
      //-------------------------
      textTitleSmall('03'.tr, padW: asWidth(18), padH: 0),
      asSizedBox(height: 4),
      textNormal(
        '최대근력 값 활용시 주의점',
        isBold: true,
        padH: 0,
        padW: asWidth(18),
        fontSize: tm.s18,
      ),
      asSizedBox(height: 10),
      textSub(
        '장비를 항상 같은 부위에 부착해야 신뢰할 수 있습니다.'
            ' 같은 근육이더라도 부착 위치가 변경되면 최대 근력 값은 크게 달라질 수 있습니다.',
        isCheck: true,
        padW: asWidth(18),
      ),
      asSizedBox(height: 20),
      Center(
        child: SizedBox(
          width: asHeight(360),
          height: asHeight(274),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                top: asHeight(84),
                left: asHeight(140),
                child: Image.asset(
                  'assets/images_help/부착위치기록3.png', // 앱화면
                  width: asHeight(190),
                  height: asHeight(190),
                ),
              ),
              Positioned(
                top: 0.0,
                left: asHeight(23),
                child: Image.asset(
                  'assets/images_help/부착위치기록1.png', // 파란 원
                  width: asHeight(203),
                  height: asHeight(203),
                ),
              ),
              Positioned(
                top: asHeight(98),
                left: asHeight(144),
                child: Container(
                  width: asHeight(51),
                  height: asHeight(51),
                  decoration: BoxDecoration(
                      color: tm.fixedWhite,
                      borderRadius: BorderRadius.circular(asHeight(26))),
                  alignment: Alignment.center,
                  child: Image.asset(
                    'assets/icons/ic_lens_blue.png',
                    width: asHeight(26),
                  ),
                ),
              ),
              Positioned(
                top: asHeight(143),
                left: asHeight(133),
                child: Image.asset(
                  'assets/images_help/부착위치기록2.png',
                  width: asHeight(209),
                  // fit: BoxFit.fitWidth,
                ),
              ),
              Positioned(
                top: asHeight(165),
                left: asHeight(147),
                child: TextN(
                  '제품의 부착위치를 기록하세요!',
                  color: tm.fixedWhite,
                  fontSize: tm.s14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Positioned(
                top: asHeight(40),
                left: asHeight(49),
                child: TextN(
                  '메인 화면 상단의\n렌즈아이콘을 눌러주세요',
                  color: tm.fixedWhite,
                  fontSize: tm.s12,
                  height: 2,
                  textAlign: TextAlign.end,
                ),
              ),
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
      asSizedBox(height: 20),
      Container(
        width: double.infinity,
        alignment: Alignment.center,
        child: TextN(
          '제품 부착 위치 기록',
          fontSize: tm.s12,
          color: tm.black,
          fontWeight: FontWeight.bold,
          height: 1,
        ),
      ),
      asSizedBox(height: 40),
      textSub(
        '전극의 접촉불량, 외부 자극 등으로 최대근력 값이 크게 설정되었다면 측정 중 혹은 설정에서 수동으로 변경할 수 있습니다.',
        isCheck: true,
        padW: asWidth(18),
      ),
      asSizedBox(height: 30),
      SizedBox(
        width: double.infinity,
        height: asHeight(240),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Image.asset(
              'assets/images_help/최대근력레벨변경1.png',
              width: asWidth(190),
              // fit: BoxFit.fitWidth,
            ),
            Positioned(
              top: asHeight(81),
              child: Image.asset(
                'assets/images_help/최대근력레벨변경2.png',
                width: asWidth(270),
                // fit: BoxFit.fitWidth,
              ),
            ),
          ],
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
      asSizedBox(height: 20),
      Container(
        width: double.infinity,
        alignment: Alignment.center,
        child: TextN(
          '최대 근력 레벨 변경',
          fontSize: tm.s12,
          color: tm.black,
          fontWeight: FontWeight.bold,
          height: 1,
        ),
      ),
      asSizedBox(height: 20),
      Container(
        margin: EdgeInsets.symmetric(horizontal: asWidth(18)),
        padding: EdgeInsets.symmetric(
            horizontal: asWidth(12), vertical: asHeight(10)),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(asHeight(8)),
          color: tm.grey01,
        ),
        child: Column(
          children: [
            Row(
              children: [
                Image.asset('assets/icons/ic_notice.png',
                    height: asHeight(10), color: tm.pointOrange),
                asSizedBox(width: 4),
                TextN('유의사항',
                    fontSize: tm.s12,
                    color: tm.grey04,
                    fontWeight: FontWeight.bold),
              ],
            ),
            textNormal(
                '근육 부위에 따라 최대근력 값은 다르게 나타납니다.'
                    ' 팔이나 어깨는 비교적 크게 나타나고 복부, 큰 근육인 허벅지는 상대적으로 작게 나타날 수 있습니다.',
                fontColor: tm.grey03,
                fontSize: tm.s12),
          ],
        ),
      ),
      asSizedBox(height: 50),
    ],
  );
}
