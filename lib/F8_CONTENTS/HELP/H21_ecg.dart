import 'package:fitsig_basic_golf/F0_BASIC/common_import.dart';

//==============================================================================
// 도움말 - 근전도 신호란?
//==============================================================================
Widget helpAboutEcg() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      //-------------------------
      // 01
      //-------------------------
      textTitleSmall('01'.tr, padW: asWidth(18), padH: 0),
      asSizedBox(height: 4),
      textNormal('심전도 동시 측정기능',
          isBold: true, padH: 0, padW: asWidth(18), fontSize: tm.s18),
      asSizedBox(height: 10),
      textNormal(
        ': 근력운동을 할 때 심전도(ECG) 신호를 동시에 측정할 수 있습니다.',
        padW: asWidth(18),
        fontColor: tm.grey04,
      ),
      asSizedBox(height: 30),
      textSub(
        '심장에 가까이 갈 수록 심전도 신호가 크게 나타나며, 멀어지면 측정되지 않습니다.'
            ' (양 손가락으로도 심전도 신호를 크게 볼 수 있습니다.)',
        isCheck: true,
        padW: asWidth(18),
      ),
      textSub(
        '장비 부착 방향에 따라 심전도 신호가 뒤집혀 보일 수 있습니다.',
        isCheck: true,
        padW: asWidth(18),
      ),
      textSub(
        '심전도는 그래프 상에서 ±0.5mV 크기로 표시가 됩니다.',
        isCheck: true,
        padW: asWidth(18),
      ),
      textSub(
        '심전도 데이터를 함께 저장하면 저장용량이 커집니다. 기본옵션은 저장하지 않는 것입니다.'
            ' 운동설정에서 저장 여부를 변경할 수 있습니다.',
        isCheck: true,
        padW: asWidth(18),
      ),
      textSub(
        '심전도 기록이 저장된 경우 보고서 그래프 상단에 하트 버튼을 클릭하면 심전도 파형을 다시볼 수 있습니다.',
        isCheck: true,
        padW: asWidth(18),
      ),
      textSub(
        '심전도가 기록되지 않은 경우 보고서 다시보기 그래프 상단에 하트가 표시되지 않습니다.',
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
              '본 제품에서 계산하는 심박수는 근력운동 간섭 등으로 오차가 크게날 수 있습니다.'
                  ' 또한 심장에서 먼 곳에 부착한 경우 심박 수 계산은 완전히 잘못된 값으로 나타날 수 있습니다.'
                  ' 본 제품은 의료기기가 아닙니다. 심박수 등의 정보를 의료용으로 사용해서는 안됩니다.',
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
      textNormal('심전도 활용하기',
          isBold: true, padH: 0, padW: asWidth(18), fontSize: tm.s18),
      asSizedBox(height: 20),
      textSub(
        '심장부근 근육(대흉근) 운동 시 심전도 정보를 함께 볼 수 있습니다.'
            ' 광배근이나 전거근 같이 심장에서 멀지 않은 근육에 부착하면 심전도가 함께 측정됩니다.',
        isCheck: true,
        padW: asWidth(18),
      ),
      textSub(
        '근력 운동에 따른 심박수의 변화를 관찰할 수 있습니다. 운동 과정에서 심박수가 높은 경우 휴식을 취하시기 바랍니다.',
        isCheck: true,
        padW: asWidth(18),
      ),
      textSub(
        '운동에 따른 적정 심박수는 ''220-연령(최대심박수)''의 80% 이하가 바람직합니다.'
            ' 적정 심박수는 개인별로 차이가 날 수 있습니다.'
            '\n20세: 160회 이하'
            '\n30세: 152회 이하'
            '\n40세: 144회 이하'
            '\n50세: 136회 이하'
            '\n60세: 128회 이하'
            '\n70살: 120회 이하',
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
              '근력운동을 하거나 터치가 발생하면 심전도 신호가 크게 간섭받을 수 있습니다.'
                  ' 측정 오차가 발생한 경우 잘못된 심박수가 표시될 수 있으니 활용에 유의 바랍니다.',
              fontColor: tm.grey03,
            ),
          ],
        ),
      ),
      asSizedBox(height: 60),
    ],
  );
}