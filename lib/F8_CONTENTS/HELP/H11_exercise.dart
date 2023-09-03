import 'package:fitsig_basic_golf/F0_BASIC/common_import.dart';

//==============================================================================
// 도움말 - 근력운동에 활용하기
//==============================================================================
Widget helpAboutExercise() {
  List<String> imageHomeTraining = const ['집에서활용하기.gif','집에서활용하기1.gif', '집에서활용하기2.gif', '집에서활용하기3.gif', '집에서활용하기4.gif' ];

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      //-------------------------
      // 01
      //-------------------------
      textTitleSmall('01'.tr, padW: asWidth(18), padH: 0),
      asSizedBox(height: 4),
      textNormal('집에서 활용하기',
          isBold: true, padH: 0, padW: asWidth(18), fontSize: tm.s18),
      asSizedBox(height: 20),
      CarouseSlideWithIndicator(
        width: asWidth(360),
        height: asHeight(240),
        durationSec: 5,
        //넓이에 맞추어 변화
        viewportFraction: 1,
        autoPlay: false,
        items: List<Widget>.generate(
            imageHomeTraining.length,
            (index) => Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color: tm.grey02,
                        ),
                      ),
                      child: Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.rotationY(0),
                        child: Image.asset(
                          'assets/images/${imageHomeTraining[index]}',
                          fit: BoxFit.fitWidth,
                          height: asHeight(240),
                          width: asWidth(360 - 2),
                        ),
                      ),
                    ),
                    // asSizedBox(width: 10),
                  ],
                )),
      ),

      asSizedBox(height: 20),
      textSub(
        '밴드 혹은 맨몸을 이용하여 근력운동을 진행할 때 활성도 피드백을 통해 힘의 세기를 조절할 수 있습니다.',
        isCheck: true,
        padW: asWidth(18),
      ),
      textSub(
        '최대 힘 대비 현재 힘의 비율을 알 수 있어 마치 헬스장에서 기구의 무게를 조절하여 운동하는 효과를 얻을 수 있습니다.',
        isCheck: true,
        padW: asWidth(18),
      ),
      textSub(
        '반복횟수를 신경쓰지 않고 게이지를 확인하며 운동량을 적절한 수준으로 조절합니다.',
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
              '초보자라면 근력 운동 목표를 50~70% 수준을 설정한 후 하루에 2~5세트 정도 운동을 진행하시기 바랍니다.'
                  ' 통상적으로 일주일에 2~5회 정도가 적절한 주간 운동 횟수입니다.',
              fontColor: tm.grey03,
              fontSize: tm.s12,
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
      textNormal('피트니스 시설에서 활용하기',
          isBold: true, padH: 0, padW: asWidth(18), fontSize: tm.s18),
      asSizedBox(height: 20),
      SizedBox(
        height: asHeight(240),
        child: Image.asset(
          'assets/images/help_img_big.jpg',
          width: asWidth(360),
          fit: BoxFit.fitWidth,
        ),
      ),
      asSizedBox(height: 20),
      textSub(
        '목표하는 근육에 자극이 제대로 들어가는지, 바른 근육을 사용하는지 실시간으로 알 수 있어 자세 교정에 도움을 줍니다.',
        isCheck: true,
        padW: asWidth(18),
      ),
      textSub(
        '장기적으로 관찰하며 근신경의 발달(=근전도의 크기 증가)을 정량적으로 확인하고 비교하세요.'
            ' 근전도 신호의 성장이 둔화된다면 근육 부피가 증가할 준비가 되었다는 의미일 수 있습니다.',
        isCheck: true,
        padW: asWidth(18),
      ),
      textSub(
        '운동량을 적절하게 조절할 수 있습니다.'
            ' 같은 1세트를 운동해도 사람마다 50~200% 운동량이 다르게 나타나기도 합니다.'
            ' 적정수준으로 1세트 운동량을 조절할 수 있습니다.',
        isCheck: true,
        padW: asWidth(18),
      ),
      asSizedBox(height: 50),
    ],
  );
}
