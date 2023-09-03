import 'package:fitsig_basic_golf/F0_BASIC/common_import.dart';

//==============================================================================
// National Language Support (NLS) code로 언어 설정
//==============================================================================

class LanguageData {

  // 지원되는 언어 (아래 locale 과 일치시켜야 함)
  static List<String> supportedLanguage = ['한국어', 'English'];

  // 지원되는 Locale 언어
  static List<Locale> supportedLocales = [
    const Locale('ko', 'KR'),
    const Locale('en', 'US'),
  ];
}

class LanguageTranslation extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        //----------------------------------------------------------------------
        // 한국어 (모두 기입 필요 - 기본이 영어로 설정되어 있기 때문에...)
        // 한국어가 키 값
        // 가나다라 순으로 정리
        //----------------------------------------------------------------------
        'ko_KR': {
          '안녕': '안녕',
          '기록': '기록',
          '언어': '언어',
          '블루투스 자동연결' : '블루투스 자동연결',
        },
        //----------------------------------------------------------------------
        // 미국 영어 (키가 없는 경우 모두 영어로 표시)
        //----------------------------------------------------------------------
        'en_US': {
          '안녕': 'Hello',
          '기록': 'record',
          '언어': 'language',
          '블루투스 자동연결' : 'bluetooth auto connection',
        },
        //----------------------------------------------------------------------
        // 영국 영어
        //----------------------------------------------------------------------
        'en_GB': {
          '안녕': 'Hello',
        },
        //----------------------------------------------------------------------
        // 중국어
        //----------------------------------------------------------------------
        'zh_CN': {
          '안녕': 'Hallo',
        },
        //----------------------------------------------------------------------
        // 일본어
        //----------------------------------------------------------------------
        'ja_JP': {
          '안녕': 'Hallo',
        },
      };
}