import 'package:fitsig_basic_golf/F0_BASIC/common_import.dart';
import 'package:url_launcher/url_launcher.dart';

const _url = 'https://smartstore.naver.com/fitsig';

/// Put your custom url here.

//==============================================================================
// 도움말 - 패치전극
//==============================================================================
Widget helpAboutElectrode() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      //--------------------------
      // 01 재사용 전극
      //--------------------------
      textTitleSmall('01'.tr, padW: asWidth(18), padH: 0),
      asSizedBox(height: 4),
      textNormal('재사용 전극',
          isBold: true, padH: 0, padW: asWidth(18), fontSize: tm.s18),
      asSizedBox(height: 10),
      textNormal(': FITSIG 장비 전용의 재사용 전극을 이용하면 전극의 교체없이 오랜 시간 사용이 가능합니다.',
          padW: asWidth(18), fontColor: tm.grey04),
      asSizedBox(height: 30),
      Image.asset(
        'assets/images/재사용 전극 접착력 회복.gif',
        width: asWidth(360),
        fit: BoxFit.fitWidth,
      ),
      asSizedBox(height: 20),
      textSub(
        '피부 각질 등으로 인해 접착력이 떨어진 경우 접착부를 물로 살짝 씻거나 물티슈로 닦아내면 접착력이 어느정도 회복됩니다.'
        ' 물로 씻을 때 장비 본체에 물이 들어가지 않도록 주의하세요.',
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
                TextN(
                  '유의사항',
                  fontSize: tm.s12,
                  color: tm.grey04,
                  fontWeight: FontWeight.bold,
                ),
              ],
            ),
            textNormal(
                '물로 씻어도 접착력이 복구되지 않는 경우에는 새 것으로 교체하시기 바랍니다.'
                ' 재사용 전극은 소모품으로 네이버 FITSIG 스토어 등에서 판매를 하고 있습니다.',
                fontColor: tm.grey03,
                fontSize: tm.s12),
          ],
        ),
      ),
      asSizedBox(height: 18),
      InkWell(
        // Todo 네이버 FITSIG 스토어 링크 연결
        onTap: () => launchUrl(
          Uri.parse(_url),
          mode: LaunchMode.externalApplication,
        ),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: asWidth(18)),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(asHeight(8)),
            color: const Color.fromARGB(0xff, 0x00, 0xc7, 0x3c),
          ),
          width: double.infinity,
          height: asHeight(44),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/icons/sns_naver.png',
                fit: BoxFit.scaleDown,
                height: asHeight(30),
              ),
              Text(
                '네이버 FITSIG스토어 바로가기',
                style: TextStyle(
                  color: tm.fixedWhite,
                  fontSize: tm.s14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
      asSizedBox(height: 30),
      textSub(
        '재사용 전극을 장비에 연결한 후 가급적 분리하지 마세요.'
        ' 분리하는 과정에서 전극 심이 손상될 수 있습니다.'
        ' 불가피하게 분리를 자주 해야 할 경우 별도로 제공하는 보호 스티커를 재사용 전극 상부에 부착한 후에 사용하세요.',
        isCheck: true,
        padW: asWidth(18),
      ),
      asSizedBox(height: 44),
      Image.asset(
        'assets/images/반창고 활용.gif',
        width: asWidth(360),
        fit: BoxFit.fitWidth,
      ),
      asSizedBox(height: 20),
      textSub(
        '땀이 많이 나는 경우, 움직임이 큰 경우, 더욱 강한 접착력이 필요한 경우 반창고를 활용하여 접착력을 한층 더 높일 수 있습니다.',
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
            textNormal('여러명이 사용하는 환경이라면 일회용 전극을, 개인이 사용하는 경우 재사용 전극을 권장합니다.',
                fontColor: tm.grey03, fontSize: tm.s12),
          ],
        ),
      ),
      asSizedBox(height: 40),
      Image.asset(
        'assets/images/전극보관방법.gif',
        width: asWidth(360),
        fit: BoxFit.fitWidth,
      ),
      asSizedBox(height: 20),
      textSub(
        '재사용 전극을 보관 할 때에는 겔이 건조되지 않도록 전극부를 플라스틱 필름 등의 표면에 붙여서 보관해주세요',
        isCheck: true,
        padW: asWidth(18),
      ),
      asSizedBox(height: 60),

      //--------------------------
      // 02 일회용 전극
      //--------------------------
      textTitleSmall('02'.tr, padW: asWidth(18), padH: 0),
      asSizedBox(height: 4),
      textNormal('일회용 전극',
          isBold: true, padH: 0, padW: asWidth(18), fontSize: tm.s18),
      asSizedBox(height: 10),
      textNormal(
          ': 시중에 판매되는 다양한 일회용 심전도(ECG, EKG) 전극 혹은 근전도(EMG) 전극을 대부분 사용할 수 있으나 일부 전극은 문제가 발생할 수 있습니다.'
          ' 2022년 3월 이후 생산된 휴레브에서 제조한 2223H(3M), HR-OP 시리즈의 전극봉과 장비에 적용된 전극홀의 사이즈가 약간 맞지 않습니다.'
          ' 체결 전극 형상에 대한 관련업계 표준화가 완전하게 되어 있지 않아 발생한 문제입니다.'
          ' 이로 인해 휴레브 제조 전극은 측정중에 잡음이 크게 발생 할 수 있습니다.',
          padW: asWidth(18),
          fontColor: tm.grey04),
      asSizedBox(height: 10),
      textSub(
        '일회용 전극 구매시 반드시 전극 접착력이 좋은 아래의 전극을 구매하세요.',
        isCheck: true,
        padW: asWidth(18),
      ),
      asSizedBox(height: 10),
      textSub(
        '사이즈가 약간 맞지 않는 휴레브 제조 전극을 이용하려면 반드시 전도성 겔을 전극부에 사용해야 합니다.',
        isCheck: true,
        padW: asWidth(18),
      ),
      asSizedBox(height: 10),
      asSizedBox(height: 24),

      Container(
        padding: EdgeInsets.symmetric(horizontal: asWidth(18)),
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Image.asset(
            //   'assets/images_help/1회용 전극.png',
            //   width: asWidth(150),
            //   // fit: BoxFit.fitWidth,
            // ),
            // asSizedBox(height: 12),
            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: asWidth(12), vertical: asHeight(10)),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(asHeight(16)),
                color: tm.grey01,
              ),
              width: double.infinity,
              child: textNormal('바이오프로텍 T716 (권장)',
                  fontColor: tm.black, fontSize: tm.s14),
            ),
            asSizedBox(height: 8),
            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: asWidth(12), vertical: asHeight(10)),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(asHeight(16)),
                color: tm.grey01,
              ),
              width: double.infinity,
              child:
                  textNormal('스킨텍 F-50', fontColor: tm.black, fontSize: tm.s14),
            ),
            asSizedBox(height: 8),
            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: asWidth(12), vertical: asHeight(10)),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(asHeight(16)),
                color: tm.grey01,
              ),
              width: double.infinity,
              child: textNormal(
                  '기타 휴레브 제조 제품(3M 2223H, HR-OP 시리즈)을 제외한 대다수의 ECG/EKG 패치 전극',
                  fontColor: tm.black,
                  fontSize: tm.s14),
            ),
            asSizedBox(height: 12),
            TextN(
              '사용 가능한 일회용 전극 제품',
              fontSize: tm.s12,
              color: tm.black,
              fontWeight: FontWeight.bold,
              height: 1,
            ),
          ],
        ),
      ),
      asSizedBox(height: 40),
      textSub(
        '특수 목적의 일부 전극과는 체결할 수 없기 때문에 구입 전 형태를 확인해 주시기 바랍니다.'
            ' (본 제품에는 표준 4mm 홀 사이즈 전극을 사용합니다.)',

        isCheck: true,
        padW: asWidth(18),
      ),
      asSizedBox(height: 10),
      textSub(
        '일회용 전극도 상황에 따라 2~3회 이상 재사용 할 수 있습니다. 접착력이 약화된 경우 새것으로 교체해 주세요',
        isCheck: true,
        padW: asWidth(18),
      ),
      asSizedBox(height: 60),

      //--------------------------
      // 03 바람직한 전극의 사용방법
      //--------------------------
      textTitleSmall('03'.tr, padW: asWidth(18), padH: 0),
      asSizedBox(height: 4),
      textNormal('바람직한 전극의 사용방법',
          isBold: true, padH: 0, padW: asWidth(18), fontSize: tm.s18),
      asSizedBox(height: 10),
      textSub(
        '달리기와 같이 땀이 나는 운동 전에 먼저 근력운동을 하면 접착이 잘 되어 좀 더 편리한 이용이 가능합니다.',
        isCheck: true,
        padW: asWidth(18),
      ),
      asSizedBox(height: 10),
      textSub(
        '땀 등으로 장비가 떨어질 우려가 있을 경우 반창고 등을 활용하여 접착력을 보강해 주세요',
        isCheck: true,
        padW: asWidth(18),
      ),
      asSizedBox(height: 10),
      textSub(
        '가급적 체모가 없는 부위에 전극을 부착해 주세요',
        isCheck: true,
        padW: asWidth(18),
      ),
      asSizedBox(height: 10),
      textSub(
        '피부 발진 등 문제가 발생한 경우 사용을 중단하고 의사와 상의해 주세요',
        isCheck: true,
        padW: asWidth(18),
      ),
      asSizedBox(height: 50),
    ],
  );
}
