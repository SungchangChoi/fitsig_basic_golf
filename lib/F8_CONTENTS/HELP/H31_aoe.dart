import 'package:fitsig_basic_golf/F0_BASIC/common_import.dart';

//==============================================================================
// 도움말 - 운동량 이해하기
//==============================================================================
Widget helpAboutAoe() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      //-------------------------
      // 01
      //-------------------------
      textTitleSmall('01'.tr, padW: asWidth(18), padH: 0),
      asSizedBox(height: 4),
      textNormal('세트 운동량 확인하기',
          isBold: true, padH: 0, padW: asWidth(18), fontSize: tm.s18),
      asSizedBox(height: 10),
      textNormal(
          ': 세트 운동량을 게이지로 확인할 수 있습니다. 초록색 게이지가 차면 1세트 운동량을 완료하였음을 의미합니다.',
          padW: asWidth(18),
          fontColor: tm.grey04),
      asSizedBox(height: 30),
      textSub(
        '힘을 최대근력에 가깝게 줄 수록 운동량 게이지가 빠르게 차오릅니다.'
            ' 가령 최대 무게로 운동하는 경우 1회만 반복해도 1세트가 종료되는 것과 같은 원리입니다.',
        isCheck: true,
        padW: asWidth(18),
      ),
      asSizedBox(height: 20),
      Align(
        alignment: Alignment.center,
        child: Image.asset(
          'assets/images_help/운동량 게이지.png',
          width: asWidth(240),
          // fit: BoxFit.fitWidth,
        ),
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
                TextN('초보자를 위한 Tip',
                    fontSize: tm.s12,
                    color: tm.grey04,
                    fontWeight: FontWeight.bold),
              ],
            ),
            textNormal(
                '초보자의 경우 최대함의 50~70% 범위 정도로 힘을 주면서 운동량을 채우는 것이 안전합니다.'
                    ' 최근 연구에 따르면 힘을 강하게 주지 않아도 운동량이 비슷하다면 근력운동 효과가 유사하게 나타난다는 견해도 있습니다.',
                fontColor: tm.grey03,
                fontSize: tm.s12),
          ],
        ),
      ),
      asSizedBox(height: 30),
      textSub(
        '운동량을 100% 채우면 헬스장에서의 평균적인 1세트 운동량과 유사한 효과를 얻을 수 있습니다.',
        isCheck: true,
        padW: asWidth(18),
      ),
      asSizedBox(height: 20),
      Container(
        margin: EdgeInsets.symmetric(horizontal: asWidth(18)),
        width: asWidth(324),
        height: asHeight(54),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(asHeight(16)),
          color: tm.softBlue,
        ),
        alignment: Alignment.center,
        child: Text(
          '운동량 100% = 헬스장 평균 1세트',
          style: TextStyle(
            fontSize: tm.s14,
            color: tm.mainBlue,
            fontWeight: FontWeight.w900,
          ),
        ),
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
                '근력 운동을 하는 사람을 대상으로 분석한 결과 1세트 운동량은 제시한 표준 값 대비 50~200% 정도의 분포를 가지고 있습니다.'
                    ' 즉, 사람마다 1세트 운동량이 크게 차이가 나기도 한다는 것을 의미합니다.',
                fontColor: tm.grey03,
                fontSize: tm.s12),
          ],
        ),
      ),
      asSizedBox(height: 30),
      textSub(
        '운동할 때 1회 반복 시간이 길 수록 운동량이 커지는 경향이 있습니다.'
            ' 한 예로 빠르게 10회 반복한 것과 약 15초 정도로 느리게 1회 반복한 것은 운동량이 같을 수 있습니다.'
            ' 본 제품은 반복횟수와 무관하게 운동량을 측정하므로 매우 느리게 운동하는 슈퍼슬로우 운동법과도 궁합이 잘 맞습니다.',
        isCheck: true,
        padW: asWidth(18),
      ),
      asSizedBox(height: 60),

      //-------------------------
      // 02
      //-------------------------
      textTitleSmall('02'.tr, padW: asWidth(18), padH: 0),
      asSizedBox(height: 4),
      textNormal('바람직한 운동량의 활용 방법',
          isBold: true, padH: 0, padW: asWidth(18), fontSize: tm.s18),
      asSizedBox(height: 10),
      textNormal(
          ': 매 운동시 운동량 게이지를 50% 이상을 채워주세요.'
              ' 힘에 여유가 있다면 100% 혹은 그 이상 운동을 진행해 주시면 됩니다.'
              ' 최대근력 값이 너무 높게 설정되어 운동량을 채울 수 없다면 측정 중에 최대근력을 재설정해 주시기 바랍니다.',
          padW: asWidth(18),
          fontColor: tm.grey04,),
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
              '1세트에 힘을 과도하게 사용한 경우 2세트에서는 운동량을 채우는데 어려움을 겪을 수 있습니다.',
              isDot: false,
                fontColor: tm.grey03,
                fontSize: tm.s12
            ),
            textSub(
                '근육이 피로해진 2세트 이상에서는 운동량을 다 못채우는 경향이 있으니 무리하지 않도록 합니다.'
                    ' 1세트는 90%이상, 힘이 빠진 2세트 이후로는 70% 정도만 채우셔도 됩니다.',
                isDot: false,
                fontColor: tm.grey03,
                fontSize: tm.s12
            ),
          ],
        ),
      ),
      asSizedBox(height: 30),
      textSub(
        '초보자라면 힘을 강하게 주기보다는 최대 힘 대비 50~75% 범위로 안전하게 운동을 진행하시기 바랍니다.',
        isCheck: true,
        padW: asWidth(18),
      ),
      textSub(
        '동일 근육에 대해 하루 2~5세트 정도의 범위로 운동을 수행해 주시기 바랍니다.',
        isCheck: true,
        padW: asWidth(18),
      ),
      asSizedBox(height: 20),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(asWidth(18), 0, 0, 0),
            padding: EdgeInsets.symmetric(horizontal: asWidth(12), vertical: asHeight(20)),
            width: asWidth(158),
            height: asHeight(88),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(asHeight(16)),
              color: tm.mainBlue,
            ),
            alignment: Alignment.topLeft,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '초보자 근활성도 세기',
                  style: TextStyle(
                    fontSize: tm.s14,
                    color: tm.fixedWhite,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                SizedBox(height: asHeight(12)),
                Text(
                  '50~75%',
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
            height: asHeight(88),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(asHeight(16)),
              color: tm.mainBlue,
            ),
            alignment: Alignment.topLeft,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '적정 세트 수',
                  style: TextStyle(
                    fontSize: tm.s14,
                    color: tm.fixedWhite,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                SizedBox(height: asHeight(12)),
                Text(
                  '2~5 세트',
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
      asSizedBox(height: 30),
      textSub(
        '세트 사이 휴식 시간은 운동 강도에 따라 20초~5분 정도가 됩니다. 운동 종료시 표시되는 권장 휴식시간을 참고해주시기 바랍니다.',
        isCheck: true,
        padW: asWidth(18),
      ),
      textSub(
        '휴식 없이 길게 운동을 진행한 경우 운동량이 계속 증가하기 때문에 가령 운동량이 1000%라면 10세트 정도의 운동을 한 것으로 추정할 수 있습니다.',
        isCheck: true,
        padW: asWidth(18),
      ),
      textSub(
        '운동량을 채우기 위해 무리하게 운동하는 것보다는 적절한 수준으로 스스로 중단하여 강도를 조절하는 것이 안전합니다.',
        isCheck: true,
        padW: asWidth(18),
      ),
      asSizedBox(height: 50),
    ],
  );
}
