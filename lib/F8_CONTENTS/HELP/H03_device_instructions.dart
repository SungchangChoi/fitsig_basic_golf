import 'package:fitsig_basic_golf/F0_BASIC/common_import.dart';

//==============================================================================
// 도움말 - 장비 사용법
//==============================================================================
Widget helpDeviceInstructions() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      //-------------------------
      // 01
      //-------------------------
      textTitleSmall('01'.tr, padW: asWidth(18), padH: 0),
      asSizedBox(height: 4),
      textNormal('장비에 전극 체결하기',
          isBold: true, padH: 0, padW: asWidth(18), fontSize: tm.s18),
      asSizedBox(height: 20),
      Image.asset(
        'assets/images/장비에 전극 체결하기.gif',
        width: asWidth(360),
        fit: BoxFit.fitWidth,
      ),
      asSizedBox(height: 20),
      textSub(
        '일회용 또는 재사용 전극을 장비의 하부에 체결합니다.'
            ' 접착력이 약화된 경우 새 것으로 교체하여 사용해주시면 됩니다.'
            ' 재사용 전극의 플라스틱 필름은 전극을 보관할 때 사용해 주시기 바랍니다.',
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
                TextN('접착력이 약해진 경우 Tip',
                    fontSize: tm.s12,
                    color: tm.black,
                    fontWeight: FontWeight.bold),
              ],
            ),
            textNormal(
              '재사용 전극의 접착력이 약해진 경우 물 세척을 통해 접착력을 어느정도 복구할 수 있습니다.',
              fontColor: tm.grey03,
              fontSize: tm.s12,
            ),
          ],
        ),
      ),
      asSizedBox(height: 40),
      Image.asset(
        'assets/images/반창고 활용.gif',
        width: asWidth(360),
        fit: BoxFit.fitWidth,
      ),
      asSizedBox(height: 20),
      textSub(
        '더욱 강한 접착력이 필요한 경우 반창고를 활용하여 접착력을 한층 더 높일 수 있습니다.',
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
              '여러명이 사용하는 환경이라면 일회용 전극을, 개인이 사용하는 경우 재사용 전극 사용을 권장합니다.',
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
      textNormal('근육에 장비 부착하기',
          isBold: true, padH: 0, padW: asWidth(18), fontSize: tm.s18),
      asSizedBox(height: 15),
      //------------------------------------------------------------------------
      // 근전도 부착 예시 사진
      Container(
        padding: EdgeInsets.symmetric(horizontal: asWidth(18)),
        child: Column(
          children: [
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
      asSizedBox(height: 15),
      textSub(
        '전극 패치가 장착된 장비를 운동할 목표 근육에 부착합니다. 근육 부착 위치는 별도의 도움말 자료를 참조해 주시기 바랍니다.',
        isCheck: true,
        padW: asWidth(18),
      ),
      textSub(
        '근육에 제품을 부착할 때에는 매번 같은 위치에 부착하는 것이 중요합니다. 위치가 바뀌게 되면 최대근력이 변화하여 비교 정확도가 떨어질 수 있습니다.',
        isCheck: true,
        padW: asWidth(18),
      ),
      asSizedBox(height: 60),

      //-------------------------
      // 03
      //-------------------------
      textTitleSmall('03'.tr, padW: asWidth(18), padH: 0),
      asSizedBox(height: 4),
      textNormal(
        '장비의 전원 켜기/끄기',
        isBold: true,
        padH: 0,
        padW: asWidth(18),
        fontSize: tm.s18,
      ),
      asSizedBox(height: 20),
      Image.asset(
        'assets/images/장비의 전원 켜기.gif',
        width: asWidth(360),
        fit: BoxFit.fitWidth,
      ),
      asSizedBox(height: 20),
      textSub(
        '전원 버튼을 1.5초 이상 눌러서 장비의 전원을 켭니다. 다시 끄려면 1.5초 이상 눌러 전원을 끌 수 있습니다.(무선 연결된 상황에서의 끄기 시간은 설정을 통해 조절이 가능합니다)',
        isCheck: true,
        padW: asWidth(18),
      ),
      textSub(
        '스마트앱에서 상단의 장비모양 아이콘 클릭으로도 전원을 종료할 수 있습니다.(측정 중에는 장비의 전원을 종료할 수 없습니다)',
        isCheck: true,
        padW: asWidth(18),
      ),
      asSizedBox(height: 60),

      //-------------------------
      // 04
      //-------------------------
      textTitleSmall('04'.tr, padW: asWidth(18), padH: 0),
      asSizedBox(height: 4),
      textNormal(
        '장비 상태 확인하기',
        isBold: true,
        padH: 0,
        padW: asWidth(18),
        fontSize: tm.s18,
      ),
      asSizedBox(height: 20),
      Center(
        child: SizedBox(
          width: asWidth(360),
          height: asHeight(195),
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Center(
                child: Image.asset(
                  'assets/images_help/illust_fitsig.png',
                  width: asWidth(360),
                  // height: asHeight(195),
                  fit: BoxFit.fitWidth,
                ),
              ),
              Positioned(
                left: asWidth(33),
                child: Row(
                  children: [
                    Container(
                      width: asWidth(20),
                      height: asWidth(20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(asWidth(10)),
                        color: tm.grey04,
                      ),
                      alignment: Alignment.center,
                      child: TextN(
                        'A',
                        fontSize: tm.s14,
                        color: tm.fixedWhite,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: asWidth(5)),
                    TextN(
                      '원형 LED',
                      fontSize: tm.s14,
                      color: tm.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ],
                ),
              ),
              Positioned(
                right: asWidth(33),
                child: Row(
                  children: [
                    TextN(
                      '배터리 LED',
                      fontSize: tm.s14,
                      color: tm.black,
                      fontWeight: FontWeight.bold,
                    ),
                    SizedBox(width: asWidth(5)),
                    Container(
                      width: asWidth(20),
                      height: asWidth(20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(asWidth(10)),
                        color: tm.grey04,
                      ),
                      alignment: Alignment.center,
                      child: TextN(
                        'B',
                        fontSize: tm.s14,
                        color: tm.fixedWhite,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                right: asWidth(33),
                // top: asHeight(166),
                bottom: asHeight(0),
                child: Row(
                  children: [
                    TextN(
                      '링크 LED',
                      fontSize: tm.s14,
                      color: tm.black,
                      fontWeight: FontWeight.bold,
                    ),
                    SizedBox(width: asWidth(5)),
                    Container(
                      width: asWidth(20),
                      height: asWidth(20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(asWidth(10)),
                        color: tm.grey04,
                      ),
                      alignment: Alignment.center,
                      child: TextN(
                        'C',
                        fontSize: tm.s14,
                        color: tm.fixedWhite,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      asSizedBox(height: 30),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: asWidth(18)),
        child: Row(
          children: [
            Container(
              width: asHeight(20),
              height: asHeight(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(asWidth(10)),
                color: tm.mainBlue,
              ),
              alignment: Alignment.center,
              child: TextN(
                'A',
                fontSize: tm.s14,
                color: tm.fixedWhite,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(width: asWidth(5)),
            TextN(
              '원형 LED',
              fontSize: tm.s14,
              color: tm.black,
              fontWeight: FontWeight.bold,
            ),
          ],
        ),
      ),
      asSizedBox(height: 10),
      textNormal(
        '스마트앱과 연결 전에는 회전하며, 연결된 후 설정된 장비의 번호만큼 깜박입니다.'
            ' (베이직 앱에서는 1개만 깜박입니다)',
        padW: asWidth(18),
        fontSize: tm.s14,
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
                TextN('장비의 오류 LED 신호',
                    fontSize: tm.s12,
                    color: tm.grey04,
                    fontWeight: FontWeight.bold),
              ],
            ),
            textSub(
              'LED 2개가 켜진 상태: 회로 에러로 수리가 필요합니다.',
              fontColor: tm.grey03,
              fontSize: tm.s12,
            ),
            textSub(
              'LED 3개가 켜진 상태: 장비의 온도가 45도 이상 고온인 경우의 오류입니다.'
                  ' 전원을 종료한 뒤 장비의 온도를 낮추어 주시기 바랍니다.',
              fontColor: tm.grey03,
              fontSize: tm.s12,
            ),
            textSub(
              'LED 4개가 켜진 상태: USB 포트에 물기가 감지된 상황의 오류 입니다.'
                  ' 장비를 건조시킨 뒤 충전해주시기 바랍니다.',
              fontColor: tm.grey03,
              fontSize: tm.s12,
            ),
          ],
        ),
      ),
      asSizedBox(height: 20),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: asWidth(18)),
        child: Row(
          children: [
            Container(
              width: asHeight(20),
              height: asHeight(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(asWidth(10)),
                color: tm.mainBlue,
              ),
              alignment: Alignment.center,
              child: TextN(
                'B',
                fontSize: tm.s14,
                color: tm.fixedWhite,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(width: asWidth(5)),
            TextN(
              '배터리 LED 신호',
              fontSize: tm.s14,
              color: tm.black,
              fontWeight: FontWeight.bold,
            ),
          ],
        ),
      ),
      asSizedBox(height: 10),
      textNormal(
        '3단계의 색상으로 배터리 잔량을 확인할 수 있습니다. (초록:잔량이 많은 상태, 노랑: 보통, 빨강: 배터리 부족)',
        padW: asWidth(18),
        fontSize: tm.s14,
      ),
      asSizedBox(height: 20),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: asWidth(18)),
        child: Row(
          children: [
            Container(
              width: asHeight(20),
              height: asHeight(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(asWidth(10)),
                color: tm.mainBlue,
              ),
              alignment: Alignment.center,
              child: TextN(
                'C',
                fontSize: tm.s14,
                color: tm.fixedWhite,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(width: asWidth(5)),
            TextN(
              '링크 LED 신호',
              fontSize: tm.s14,
              color: tm.black,
              fontWeight: FontWeight.bold,
            ),
          ],
        ),
      ),
      asSizedBox(height: 10),
      textNormal(
        '무선 연결 및 전극의 접촉 상태를 확인할 수 있습니다.'
            ' 블루투스 연결이 된 후 파란색 LED가 켜지면 전극-피부접촉이 양호한 상태이며,'
            ' 주황색의 경우 전극-피부접촉이 불안정함을 의미합니다.',
        padW: asWidth(18),
        fontSize: tm.s14,
      ),
      asSizedBox(height: 50),
    ],
  );
}
