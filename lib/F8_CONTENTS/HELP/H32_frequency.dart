import 'package:fitsig_basic_golf/F0_BASIC/common_import.dart';

//==============================================================================
// 도움말 - 근전도 주파수
//==============================================================================
Widget helpAboutFrequency() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      //-------------------------
      // 01
      //-------------------------
      textTitleSmall('01'.tr, padW: asWidth(18), padH: 0),
      asSizedBox(height: 4),
      textNormal('근전도 주파수(=순간 피로도)',
          isBold: true, padH: 0, padW: asWidth(18), fontSize: tm.s18),
      asSizedBox(height: 10),
      textNormal(
          ': 근육이 반복운동으로 피로해지면 주파수가 낮아지는 경향이 있습니다. 운동 속도가 빨라지면 주파수가 올라가며, 느려지면 낮아지는 특성이 있습니다.',
          padW: asWidth(18),
          fontColor: tm.grey04),
      asSizedBox(height: 30),
      textSub(
        '앱에서 제공하는 주파수로 근육의 순간적 피로 상태를 추정할 수 있습니다. 다만 주파수의 변화는 일정하지 않아 정확도를 보장하지 않습니다. 참조용으로 활용하시는 것이 바랍직합니다.',
        isCheck: true,
        padW: asWidth(18),
      ),
      asSizedBox(height: 30),
      SizedBox(
        width: double.infinity,
        height: asHeight(300),
        child: Stack(alignment: Alignment.center, children: [
          Image.asset(
            'assets/images_help/주파수 변화1.png',
            width: asWidth(190),
            // fit: BoxFit.fitWidth,
          ),
          Positioned(
            top: asHeight(228),
            child: Image.asset(
              'assets/images_help/주파수 변화2.png',
              width: asWidth(250),
              // fit: BoxFit.fitWidth,
            ),
          ),
        ]),
      ),
      asSizedBox(height: 20),
      Container(
        width: double.infinity,
        alignment: Alignment.center,
        child: TextN(
          '운동중 주파수 변화 그래프',
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
                TextN('주파수 감소의 의미',
                    fontSize: tm.s12,
                    color: tm.grey04,
                    fontWeight: FontWeight.bold),
              ],
            ),
            textNormal(
                '일반적으로 동일한 속도로 1세트 운동을 수행하면 시작 시점 대비 종료 시점에서 주파수가 낮아져 있습니다. 따라서 주파수 감소가 크다는 것은 1세트 운동을 충분히 했음을 의미할 수도 있습니다.',
                fontColor: tm.grey03,
                fontSize: tm.s12),
          ],
        ),
      ),
      asSizedBox(height: 60),
      //-------------------------
      // 02
      //-------------------------
      textTitleSmall('02'.tr, padW: asWidth(18), padH: 0),
      asSizedBox(height: 4),
      textNormal('주파수를 효과적으로 활용하기',
          isBold: true, padH: 0, padW: asWidth(18), fontSize: tm.s18),
      asSizedBox(height: 20),
      textSub(
        '세트 시작과 종료 단계에서 운동하는 힘과 속도의 차이가 크지 않을수록 주파수의 정확도가 올라가게 됩니다.',
        isCheck: true,
        padW: asWidth(18),
      ),
      textSub(
        '운동 중 주파수가 8~10Hz 이상 크게 떨어진다면 근육이 매우 피로할 수 있기 때문에 휴식을 고려해 주시기 바랍니다.',
        isCheck: true,
        padW: asWidth(18),
      ),
      textSub(
        '다음 세트 시작 단계에서 주파수 값이 이전 대비 낮게 나온다면 휴식시간을 좀 더 늘리는 것을 권장합니다.',
        isCheck: true,
        padW: asWidth(18),
      ),
      asSizedBox(height: 80),
      //-------------------------
      // 주의사항
      //-------------------------
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
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
            textNormal(
              '주파수는 단순 참조용으로 어떠한 판단의 기준으로 활용해서는 안됩니다.',
              fontColor: tm.pointOrange,
            ),
            textSub('개개인의 근육 부위마다 세트 시작 및 종료 주파수는 차이가 날 수 있습니다', isDot: true),
            textSub('주파수가 항상 감소하는 것은 아닙니다. 힘의 강도 및 운동 속도와 같은 다양한 이유로 상승하기도 합니다',
                isDot: true),
            textSub('주파수는 단순 참조용으로, 특히 의료목적 혹은 안전기준 등으로 사용해서는 안됩니다',
                isDot: true),
            asSizedBox(height: 30),
          ],
        ),
      ),
    ],
  );
}
