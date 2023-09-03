import 'package:fitsig_basic_golf/F0_BASIC/common_import.dart';

//==============================================================================
// 도움말 - 근전도 신호란?
//==============================================================================
Widget helpAboutEmg() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      //-------------------------
      // 01
      //-------------------------
      textTitleSmall('01'.tr, padW: asWidth(18), padH: 0),
      asSizedBox(height: 4),
      textNormal('근전도 신호란?',
          isBold: true, padH: 0, padW: asWidth(18), fontSize: tm.s18),
      asSizedBox(height: 10),
      textNormal(
        ': 근육에 힘을 주면 전기신호가 발생하고 이것을 피부에서 측정한 것을 표면 근전도(EMG) 신호라고 합니다.'
            ' 본 장비를 이용하여 일부 속근육을 제외한 대다수 근육의 근전도 신호를 측정할 수 있습니다.',
        padW: asWidth(18),
        fontColor: tm.grey04,
      ),
      asSizedBox(height: 30),
      textSub(
        '근전도 신호는 피부 표면에서 수uV에서 수mV 정도의 크기로 나타나며 이를 증폭하여 측정을 합니다.',
        isCheck: true,
        padW: asWidth(18),
      ),
      textSub(
        '국가대표급 스포츠 선수들은 예전부터 근전도 분석 기술을 널리 사용하여 왔습니다.',
        isCheck: true,
        padW: asWidth(18),
      ),
      textSub(
        'FITSIG는 일반인을 위한 근전도 측정 장비로 근육의 활성도를 편리하게 분석할 수 있습니다.',
        isCheck: true,
        padW: asWidth(18),
      ),
      textSub(
        '근전도를 측정하면 목표하는 근육부위가 제대로 자극되는지 실시간으로 분석할 수 있어 보다 과학적이고 효과적인 근력운동을 할 수 있습니다.',
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
                    color: tm.black,
                    fontWeight: FontWeight.bold),
              ],
            ),
            textNormal(
              '근육의 크기나 힘의 세기에 비례하여 근전도 신호가 커지는 경향이 있으며,'
                  ' 근육이 피로해지면 주파수가 낮아지는 특성이 있습니다.',
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
      textNormal('근전도 바르게 활용하기',
          isBold: true, padH: 0, padW: asWidth(18), fontSize: tm.s18),
      asSizedBox(height: 20),
      textSub(
        '근육의 길이 방향으로 전극을 부착하는 것이 바람직합니다.'
            ' 같은 근육이라도 부착위치에 따라 근전도 신호의 크기는 크게 달라질 수 있습니다.',
        isCheck: true,
        padW: asWidth(18),
      ),
      textSub(
        '모든 근력운동은 주동근(가장 큰 힘을 내는 근육)이 있습니다.'
            ' 근전도 신호는 각 운동과 매칭되는 주동근에 부착하는 것이 좋습니다.'
            ' 전극 부착 위치는 별도의 도움말을 참조하시기 바랍니다.',
        isCheck: true,
        padW: asWidth(18),
      ),
      textSub(
        '신뢰성 높은 근전도 신호를  얻기 위해서는 2개의 전극이 피부에 모두 잘 붙어 있어야 합니다.'
            ' 전극이 한 개라도 떨어지거나 물리적 충격이 가해지면 잡음이 크게 유입될 수 있으니 안정적으로 부착을 유지해 주시기 바랍니다.',
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
                    color: tm.black,
                    fontWeight: FontWeight.bold),
              ],
            ),
            textNormal(
              '매번 같은 곳에 붙여야 측정 편차가 줄어들어 더 정확한 분석이 가능해집니다.'
                  ' 부착 위치가 헷갈릴 때에는 자신이 가진 신체 특장점을 최대한 활용하거나'
                  ' 제품 부착 위치를 촬영하여 기록해두어 부착 위치를 같은 곳에 붙일 수 있도록 합니다.',
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
      textNormal('심전도, 뇌파와의 차이',
          isBold: true, padH: 0, padW: asWidth(18), fontSize: tm.s18,),
      asSizedBox(height: 20),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(asWidth(18), 0, 0, 0),
            padding: EdgeInsets.symmetric(horizontal: asWidth(12), vertical: asHeight(20)),
            width: asWidth(158),
            height: asHeight(110),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(asHeight(16)),
              color: tm.mainBlue,
            ),
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '심전도(ECG)',
                  style: TextStyle(
                    fontSize: tm.s14,
                    color: tm.fixedWhite,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                asSizedBox(height: 12),
                Text(
                  '심장근육의 전기신호를 측정하는 것',
                  style: TextStyle(
                    fontSize: tm.s14,
                    color: tm.fixedWhite,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0, 0, asWidth(18), 0),
            padding: EdgeInsets.symmetric(horizontal: asWidth(12), vertical: asHeight(20)),
            width: asWidth(158),
            height: asHeight(110),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(asHeight(16)),
              color: tm.mainBlue,
            ),
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '뇌파(EEG)',
                  style: TextStyle(
                    fontSize: tm.s14,
                    color: tm.fixedWhite,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                asSizedBox(height: 12),
                Text(
                  '뇌의 전기신호를 측정 하는 것',
                  style: TextStyle(
                    fontSize: tm.s14,
                    color: tm.fixedWhite,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      asSizedBox(height: 20),
      textNormal(
        ': 근전도, 심전도, 뇌파를 측정하는 원리는 동일하지만 신호의 특성은 다릅니다.',
        padW: asWidth(18),
        fontColor: tm.grey04,
      ),
      asSizedBox(height: 50),
    ],
  );
}