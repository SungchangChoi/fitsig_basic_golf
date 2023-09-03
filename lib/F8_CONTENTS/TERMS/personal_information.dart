import '/F0_BASIC/common_import.dart';
// String htmlPersonalInformation = '';

// =============================================================================
// 이용약관 - 마지막까지 고민 후 깔끔하게 출시하는 것도 검토 함
// =============================================================================
Widget wordPersonalInformation() {
  return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    //------------------------------------------------------------------------
    // 1
    textTitleSmall('1. 개인정보처리방침의 의의'),

    textNormal(
        '주식회사 핏시그(이하"회사")는 본 개인정보처리방침을 정보통신망법을 기준으로 작성하되, 이용자 개인정보 처리 현황을 최대한 알기 쉽고 상세하게 설명하기 위해 노력하였습니다.'),
    textNormal('개인정보처리방침은 다음과 같은 중요한 의미를 가지고 있습니다.'),
    textSub(
        '회사가 어떤 정보를 수집하고, 수집한 정보를 어떻게 사용하며, 필요에 따라 누구와 이를 공유(‘위탁 또는 제공’)하며, 이용목적을 달성한 정보를 언제·어떻게 파기하는지 등의 정보를 투명하게 제공합니다.'),
    textSub(
        '정보주체로서 이용자는 자신의 개인정보에 대해 어떤 권리를 가지고 있으며, 이를 어떤 방법과 절차로 행사할 수 있는지를 알려드립니다.'),
    textSub(
        '개인정보 침해사고가 발생하는 경우, 추가적인 피해를 예방하고 이미 발생한 피해를 복구하기 위해 누구에게 연락하여 어떤 도움을 받을 수 있는지 알려드립니다.'),
    textSub(
        '그 무엇보다도, 개인정보와 관련하여 회사와 이용자 간의 권리 및 의무 관계를 규정하여 이용자의 ‘개인정보자기결정권’을 보장하는 수단이 됩니다.'),
    //------------------------------------------------------------------------
    // 2
    textTitleSmall('2. 수집하는 개인정보'),

    textNormal(
        'FITSIG와 연동되는 어플리케이션에 따라 개인정보가 불필요하거나, 혹은 요청하는 항목이 변경될 수 있습니다.  회원가입이 필요한 어플리케이션을 이용 할 경우, 회사는 서비스 이용을 위해 필요한 최소한의 개인정보를 수집합니다.'),
    textNormal(
        '회원가입 시점에 회사가 이용자로부터 수집하는 개인정보는 아래와 같으며 상세한 내용은 어플리케이션에 따라 달라질 수 있습니다.'),
    textSub(
        '본인 인증 : 이름, 성별, 생년월일, 휴대폰번호, 통신사업자, 내/외국인 여부, 암호화된 이용자 확인값, 중복가입확인정보'),
    textSub('신용카드 결제 시: 카드번호(일부), 카드사명 등'),
    textSub('휴대전화번호 결제 시: 휴대전화번호, 결제승인번호 등'),
    textSub('계좌이체 시: 예금주명, 계좌번호, 계좌은행, 이메일 등'),
    textSub(
        '장비 사용 및 운동 프로그램 수행 시: 사용하는 장비정보, 운동 수행 결과 (최대 근력, 운동중량, 운동 콘텐츠, 운동시간 등 운동결과 관련 정보), 선택한 운동 프로그램 정보 등'),
    textSub(
        '고객센터 : 아이디, 이름, 휴대전화번호, 이메일 주소, 집 주소(필요 시), 기타 필요한 정보가 있을 경우 동의를 구하고 수집'),
    textSub('기타 : 원활한 서비스를 위해 필요한 개인 정보가 있을 경우, 각 상세 서비스에서 동의를 구하고 개인 정보 수집'),

    textNormal('필수정보 : 해당 서비스의 본질적 기능을 수행하기 위한 정보입니다.'),
    textNormal(
        '선택정보 : 보다 특화된 서비스를 제공하기 위해 추가 수집하는 정보입니다. (선택 정보를 입력하지 않은 경우에도 서비스 이용 제한은 없습니다.)'),
    textNormal(
        '서비스 이용 과정에서 IP 주소, 쿠키, 서비스 이용 기록, 기기정보가 생성되어 수집될 수 있습니다. 또한 이미지 및 음성을 이용한 애프터 서비스 혹은 커뮤니티 서비스 등에서 이미지나 음성이 수집될 수 있습니다.'),
    textNormal(
        '구체적으로 1) 서비스 이용 과정에서 이용자에 관한 정보를 자동화된 방법으로 생성하여 이를 저장(수집)하거나, 2) 이용자 기기의 고유한 정보를 원래의 값을 확인하지 못 하도록 안전하게 변환하여 수집합니다. 이와 같이 수집된 정보는 개인정보와의 연계 여부 등에 따라 개인정보에 해당할 수 있고, 개인정보에 해당하지 않을 수도 있습니다.'),
    textNormal('회사는 아래의 방법을 통해 개인정보를 수집합니다.'),
    textSub(
        '회원가입 및 서비스 이용 과정에서 이용자가 개인정보 수집에 대해 동의를 하고 직접 정보를 입력하는 경우, 해당 개인정보를 수집합니다.'),
    textSub('고객센터를 통한 상담 과정에서 웹페이지, 메일, 팩스, 전화 등을 통해 이용자의 개인정보가 수집될 수 있습니다.'),
    textSub('오프라인에서 진행되는 이벤트, 세미나 등에서 서면을 통해 개인정보가 수집될 수 있습니다.'),
    textSub(
        '회사와 제휴한 외부 기업이나 단체로부터 개인정보를 제공받을 수 있으며, 이러한 경우에는 정보통신망법에 따라 제휴사에서 이용자에게 개인정보 제공 동의 등을 받은 후에 회사에 제공합니다.'),
    textSub('기기정보와 같은 생성정보는 PC웹, 모바일 웹/앱 이용 과정에서 자동으로 생성되어 수집될 수 있습니다.'),
    textSub(
        '회원가입을 하지 않았더라도, 고객의 운동 프로그램 이용내용, 운동 결과, 근전도 측정 등의 어플리케이션 이용 자료는 서비스 현황 파악 및 개선을 목적으로 네트워크를 통해 수집될 수 있습니다.'),
    //------------------------------------------------------------------------
    // 3
    textTitleSmall('3. 수집한 개인정보의 이용'),
    textNormal(
        '회사는 회원관리, 다양한 서비스 개발·제공 및 향상, 안전한 FITSIG 사용 환경 구축 등 아래의 목적으로만 개인정보를 이용합니다.'),
    textNormal(
        '회원 가입 의사의 확인, 연령 확인 이용자 본인 확인, 이용자 식별, 회원탈퇴 의사의 확인, 맞춤형 운동 프로그램 제공 등 회원관리를 위하여 개인정보를 이용합니다.'),
    textNormal(
        '콘텐츠 등 기존 서비스 제공(광고 포함)에 더하여, 인구통계학적 분석, 서비스 방문 및 이용기록의 분석, 개인정보 및 관심에 기반 한 이용자 간 관계의 형성, 지인 및 관심사 등에 기반 한 맞춤형 서비스 제공 등 신규 서비스 요소의 발굴 및 기존 서비스 개선 등을 위하여 개인정보를 이용합니다.'),
    textNormal(
        '법령 및 회사의 이용약관을 위반하는 회원에 대한 이용 제한 조치, 부정 이용 행위를 포함하여 서비스의 원활한 운영에 지장을 주는 행위에 대한 방지 및 제재, 계정도용 및 부정거래 방지, 약관 개정 등의 고지사항 전달, 분쟁조정을 위한 기록 보존, 민원처리 등 이용자 보호 및 서비스 운영을 위하여 개인정보를 이용합니다.'),
    textNormal(
        '유료 서비스 제공에 따르는 본인인증, 구매 및 요금 결제, 상품 및 서비스의 배송을 위하여 개인정보를 이용합니다.'),
    textNormal('이벤트 정보 및 참여기회 제공, 광고성 정보 제공 등 마케팅 및 프로모션 목적으로 개인정보를 이용합니다.'),
    textNormal(
        '서비스 이용기록과 접속 빈도 분석, 서비스 이용에 대한 통계, 서비스 분석 및 통계에 따른 맞춤 서비스 제공 및 광고 게재 등에 개인정보를 이용합니다.'),
    textNormal(
        '보안, 프라이버시, 안전 측면에서 이용자가 안심하고 이용할 수 있는 서비스 이용환경 구축을 위해 개인정보를 이용합니다.'),
    textNormal('개인 맞춤형 운동 프로그램 제공, 운동 개발 및 개선된 서비스 제공을 위해 개인 정보를 이용합니다.'),
    //------------------------------------------------------------------------
    // 4
    textTitleSmall('4. 개인정보의 제공 및 위탁'),
    textNormal('회사는 원칙적으로 이용자 동의 없이 개인정보를 외부에 제공하지 않습니다.'),
    textNormal(
        '회사는 이용자의 사전 동의 없이 개인정보를 외부에 제공하지 않습니다. 단, 이용자가 외부 제휴사의 서비스를 이용하기 위하여 개인정보 제공에 직접 동의를 한 경우, 그리고 관련 법령에 의거해 회사에 개인정보 제출 의무가 발생한 경우, 이용자의 생명이나 안전에 급박한 위험이 확인되어 이를 해소하기 위한 경우에 한하여 개인정보를 제공하고 있습니다.'),
    //------------------------------------------------------------------------
    // 5
    textTitleSmall('5. 개인정보의 파기'),
    textNormal('회사는 원칙적으로 이용자의 개인정보를 회원 탈퇴 시 지체 없이 파기합니다.'),
    textNormal(
        '단, 이용자에게 개인정보 보관기간에 대해 별도의 동의를 얻은 경우, 또는 법령에서 일정 기간 정보보관 의무를 부과하는 경우에는 해당 기간 동안 개인정보를 안전하게 보관합니다.'),
    textNormal('이용자에게 개인정보 보관기간에 대해 회원가입 시 또는 서비스 가입 시 동의를 얻은 경우는 아래와 같습니다.'),
    textSub(
        '부정 가입 및 이용 방지 : 바로 삭제가 원칙이나 부정 가입 방지 목적으로 필요에 따라 일정기관 보관. 가입인증 휴대전화번호 또는 아이디 및 닉네임 등 : 수집 시점으로부터 6개월 보관. 탈퇴한 이용자의 휴대전화번호 또는 아이디 및 닉네임 등 : 탈퇴일로부터 6개월 보관'),
    textSub(
        '운동 결과 기록의 보존 및 개인 식별 정보 삭제 : 각 개인이 수행한 운동 결과 기록은 파기되지 않습니다. 수집한 운동 결과자료, 생년월, 성별, 키, 몸무게, 국가 정보와 같은 자료는 통계적으로 처리되어 파기되지 않으며, 개인을 식별할 수 있는 정보 (아이디, 이메일 등)는 모두 삭제됩니다.'),
    textNormal(
        '전자상거래 등에서의 소비자 보호에 관한 법률, 전자금융거래법, 통신비밀보호법 등 법령에서 일정기간 정보의 보관을 규정하는 경우는 아래와 같습니다. 회사는 이 기간 동안 법령의 규정에 따라 개인정보를 보관하며, 본 정보를 다른 목적으로는 절대 이용하지 않습니다.'),
    textNormal('전자상거래 등에서 소비자 보호에 관한 법률'),
    textSub('계약 또는 청약철회 등에 관한 기록: 5년 보관'),
    textSub('대금결제 및 재화 등의 공급에 관한 기록: 5년 보관'),
    textSub('소비자의 불만 또는 분쟁처리에 관한 기록: 3년 보관'),
    textNormal('전자금융거래법'),
    textSub('전자금융에 관한 기록: 5년 보관'),
    textNormal('통신비밀보호법'),
    textSub('로그인 기록: 3개월'),
    textNormal(
        '회원탈퇴, 서비스 종료, 이용자에게 동의 받은 개인정보 보유기간의 도래와 같이 개인정보의 수집 및 이용목적이 달성된 개인정보는 파기합니다. 출력물 등은 분쇄하거나 소각하는 방식 등으로 파기합니다.'),
    textNormal(
        '참고로 회사는 ‘개인정보 유효기간제’에 따라 1년간 서비스를 이용하지 않은 회원의 개인정보를 별도로 분리 보관하여 관리합니다.'),
    //------------------------------------------------------------------------
    // 6
    textTitleSmall('6. 이용자 및 법정대리인의 권리와 행사 방법'),
    textNormal(
        '이용자는 언제든지 ‘스마트 앱에서 제공하는 회원정보’에서 자신의 개인정보를 조회하거나 수정할 수 있습니다. (어플리케이션에 따라 회원정보가 없을 수도 있습니다.)'),
    textNormal('이용자는 언제든지 ‘회원탈퇴’ 등을 통해 개인정보의 수집 및 이용 동의를 철회할 수 있습니다.'),
    textNormal(
        '이용자가 개인정보의 오류에 대한 정정을 요청한 경우, 정정을 완료하기 전까지 해당 개인정보를 이용 또는 제공하지 않습니다. 또한 잘못된 개인정보를 제3자에게 이미 제공한 경우에는 정정 처리결과를 제3자에게 지체 없이 통지하여 정정이 이루어지도록 하겠습니다.'),
    //------------------------------------------------------------------------
    // 7
    textTitleSmall('7. 개인정보 보호책임자 및 담당자 안내'),
    textNormal(
        '회사는 이용자의 개인정보 관련 문의사항 및 불만 처리 등을 위하여 아래와 같이 개인정보 보호책임자 및 담당자를 지정하고 있습니다.'),
    textSub('개인정보 보호책임자 : 황정진 (CEO)'),
    textSub('개인정보 보호담당자 : 김현수 (경영지원)'),
    textSub('전화 : 1533-0739'),
    textSub('메일 : sales@fitsig.com'),

    textNormal('기타 개인정보 침해에 대한 신고나 상담이 필요한 경우에 아래 기관에 문의 가능합니다.'),
    textSub('개인정보침해신고센터 (privacy.kisa.or.kr / 국번없이 118)'),
    textSub('대검찰청 사이버수사과 (www.spo.go.kr / 국번없이 1301)'),
    textSub('경찰청 사이버안전국 (police.go.kr / 국번없이 182)'),
    //------------------------------------------------------------------------
    // 8
    textTitleSmall('8. 본 개인정보처리방침의 적용 범위'),
    textNormal(
        '본 개인정보처리방침은 FITSIG 관련 제반 서비스(모바일 웹/앱 포함)에 적용되며, 다른 브랜드로 제공되는 서비스에 대해서는 별개의 개인정보처리방침이 적용될 수 있습니다.'),
    textNormal(
        '회사에 링크되어 있는 다른 회사의 웹사이트에서 개인정보를 수집하는 경우, 이용자 동의하에 개인정보가 제공된 이후에는 본 개인정보처리방침이 적용되지 않습니다.'),
    //------------------------------------------------------------------------
    // 9
    textTitleSmall('9. 개정 전 고지 의무'),
    textNormal(
        '본 개인정보처리방침의 내용 추가, 삭제 및 수정이 있을 경우 개정 최소 7일 전에 ‘공지사항 또는 알림메시지’ 등을 통해 사전 공지를 할 것입니다.'),
    textNormal(
        '다만, 수집하는 개인정보의 항목, 이용목적의 변경 등과 같이 이용자 권리의 중대한 변경이 발생할 때에는 최소 30일 전에 공지합니다.'),
    textSub('공고일자: 2022년 12월 1일'),
    textSub('시행일자: 2022년 12월 1일'),
  ]);

  //--------------------------------------
}
