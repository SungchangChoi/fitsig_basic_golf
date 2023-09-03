import 'package:shared_storage/saf.dart';

import '/F0_BASIC/common_import.dart';
import 'package:http/http.dart' as http;

String _authkey = '';

//==============================================================================
// API - authkey 값 얻기 (시리얼 번호에 따라 다름)
//==============================================================================
Future<Map<String, String>> apiGetAuthKey({
  required String serial,
}) async {
  //--------------------------------------------------------------------------
  // 전송 할 URL
  String url = 'https://roem.fitsig.com/apibasic/get_auth';
  //--------------------------------------------------------------------------
  // http post
  late http.Response response;
  String authKey = 'AUTH_KEY_ERROR';
  //--------------------------------------------------------------------------
  // 응답 받을 map
  Map<String, String> ackMap = {};
  //-------------------------------------------------------------------------
  // timeout 1초로 API 통신 수행
  try {
    response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: <String, String>{'serial': serial},
    );

    //-------------------------------------------------------------------------
    // 정상적 응답인 경우
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      // print('API ack success');
      // print(response.body);
      // var ackMap = jsonDecode(response.body);

      // decode : string dynamic -> string, string 으로 변환
      // ackMap =
      // Map<String, String>.from(jsonDecode(utf8.decode(response.bodyBytes)));

      // 이렇게 해야 에뮬레이터에서 에러 안남. 갤럭시 폰에서는 bodyBytes로 해도 에러 없음
      ackMap = Map<String, String>.from(jsonDecode(response.body));

      authKey = ackMap['authkey']!;
      _authkey = authKey;

      gv.system.isServerConnected = true; //서버 연결 됨

      if (kDebugMode) {
        print('Get authkey success : $_authkey');
      }
      ackMap['response'] = 's';

      if (kDebugMode) {
        // print(ackMap.runtimeType);
        // print(ackMap);
        print('정상적으로 서버에서 키 값 획득');
      }

      return ackMap;
    }
    //-------------------------------------------------------------------------
    // 응답이 비정상인 경우
    else {
      if (kDebugMode) {
        print('API가 응답했지만, 인식할 수 없는 명령');
      }
      ackMap['response'] = 'f';
      return ackMap;
    }
  }
  //-------------------------------------------------------------------------
  // time out 으로 실패 한 경우
  catch (e) {
    if (kDebugMode) {
      print(e);
      print('키 값 획득 실패 : 통신이 불가능한 상태로 추정!');
    }
    ackMap['response'] = 'f';
    return ackMap;
  }
}

//==============================================================================
// API function
//==============================================================================
Future<Map<String, String>> apiPost({
  required String subUrl,
  required Map<String, String> body,
  String contentsType = 'application/x-www-form-urlencoded',
}) async {
  //--------------------------------------------------------------------------
  // key 값 다시 얻기
  if (gv.system.isServerConnected == false) {}
  //--------------------------------------------------------------------------
  // 전송 할 URL
  String urlFull = 'https://roem.fitsig.com/apibasic/' + subUrl;
  //--------------------------------------------------------------------------
  // 전송 할 파라미터
  // 권한 키 추가(각 장비 시러얼 번호로 생성. 항상 필요)
  Map<String, String> bodyFull = body;
  bodyFull['authkey'] = _authkey;

  //--------------------------------------------------------------------------
  // 응답 받을 map
  Map<String, String> ackMap = {};
  //--------------------------------------------------------------------------
  // http post
  try {
    http.Response response = await http.post(
      Uri.parse(urlFull),
      headers: <String, String>{
        'Content-Type': contentsType,
      },
      body: bodyFull,
    );

    //-------------------------------------------------------------------------
    // 정상적 응답인 경우
    if (response.statusCode == 200) {
      // 한굴이 utf-8 포맷으로 되어 있음
      // dart string 형태로 변경
      // decode : string dynamic -> string, string 으로 변환
      ackMap =
          Map<String, String>.from(jsonDecode(utf8.decode(response.bodyBytes)));

      if (kDebugMode) {
        print(ackMap);
        print('API 정상적으로 응답');
      }

      ackMap['response'] = 's';
      return ackMap;
    }
    //-------------------------------------------------------------------------
    // 응답이 비정상인 경우
    else {
      if (kDebugMode) {
        print('API 가 응답했지만, 인식할 수 없는 명령');
      }
      ackMap['response'] = 'f';
      return ackMap;
    }
  }
  //-------------------------------------------------------------------------
  // time out 으로 실패 한 경우
  catch (e) {
    if (kDebugMode) {
      print(e);
      print('데이터 전송 실패 : 통신이 불가능한 상태로 추정!');
    }
    ackMap['response'] = 'f';
    return ackMap;
  }
}

//==============================================================================
// contents type
//==============================================================================
// 1) Multipart Related MIME 타입
// - Content-Type: Multipart/related <-- 기본형태
// - Content-Type: Application/X-FixedRecord
//
// 2) XML Media의 타입
// - Content-Type: text/xml
// - Content-Type: Application/xml
// - Content-Type: Application/xml-external-parsed-entity
// - Content-Type: Application/xml-dtd
// - Content-Type: Application/mathtml+xml
// - Content-Type: Application/xslt+xml
//
// 3) Application의 타입
// - Content-Type: Application/EDI-X12 <--  Defined in RFC 1767
// - Content-Type: Application/EDIFACT <--  Defined in RFC 1767
// - Content-Type: Application/javascript <-- Defined in RFC 4329
// - Content-Type: Application/octet-stream  : <-- 디폴트 미디어 타입은 운영체제 종종 실행파일, 다운로드를 의미
// - Content-Type: Application/ogg <-- Defined in RFC 3534
// - Content-Type: Application/x-shockwave-flash <-- Adobe Flash files
// - Content-Type: Application/json <-- JavaScript Object Notation JSON; Defined in RFC 4627
// - Content-Type: Application/x-www-form-urlencode <-- HTML Form 형태
// * x-www-form-urlencode와 multipart/form-data은 둘다 폼 형태이지만 x-www-form-urlencode은 대용량 바이너리 테이터를 전송하기에 비능률적이기 때문에 대부분 첨부파일은 multipart/form-data를 사용하게 된다.
//
// 4) 오디오 타입
// - Content-Type: audio/mpeg <-- MP3 or other MPEG audio
// - Content-Type: audio/x-ms-wma <-- Windows Media Audio;
// - Content-Type: audio/vnd.rn-realaudio <--  RealAudio;  등등
//
// 5) Multipart 타입
// - Content-Type: multipart/mixed: MIME E-mail;
// - Content-Type: multipart/alternative: MIME E-mail;
// - Content-Type: multipart/related: MIME E-mail <-- Defined in RFC 2387 and used by MHTML(HTML mail)
// - Content-Type: multipart/formed-data  <-- 파일 첨부
//
// 6) TEXT 타입
// - Content-Type: text/css
// - Content-Type: text/html
// - Content-Type: text/javascript
// - Content-Type: text/plain
// - Content-Type: text/xml
//
// 7) file 타입
// - Content-Type: application/msword <-- doc
// - Content-Type: application/pdf <-- pdf
// - Content-Type: application/vnd.ms-excel <-- xls
// - Content-Type: application/x-javascript <-- js
// - Content-Type: application/zip <-- zip
// - Content-Type: image/jpeg <-- jpeg, jpg, jpe
// - Content-Type: text/css <-- css
// - Content-Type: text/html <-- html, htm
// - Content-Type: text/plain <-- txt
// - Content-Type: text/xml <-- xml
// - Content-Type: text/xsl <-- xsl
