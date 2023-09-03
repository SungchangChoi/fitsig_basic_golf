import '/F0_BASIC/common_import.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

//------------------------------------------------------------------------------
// 기본 전역변수
//------------------------------------------------------------------------------
BasicTheme tm = BasicTheme(); //테마 전역 변수

// // 장비 개수 만큼 매니저 생성 시킴
// List<BleModule> bleManager = List.generate(
//     GvDef.maxDeviceNum, (index) => BleModule(deviceIndex: index)); //불루투스 전역 변수

//==============================================================================
// 신호처리 전역변수
//==============================================================================
Gv gv = Gv()..init();

class Gv {
  //----------------------------------------------------------------------------
  // 공통 전역 변수
  //----------------------------------------------------------------------------
  GvControl control = GvControl(); //종합 공통 제어 변수
  GvSetting setting = GvSetting(); //설정
  GvSystem system = GvSystem(); //시스템
  GvDsp dsp = GvDsp();

  // GvRefreshGetX refreshGet = GvRefreshGetX(); //Get-X 활용 화면 영역갱신 관련 변수들
  // GvRefreshKey refreshKey = GvRefreshKey(); //Key 를 이용한 화면 영역갱신 변수들
  //----------------------------------------------------------------------------
  // 장비별 생성되는 전역 변수
  //----------------------------------------------------------------------------
  List<GvDeviceStatus> deviceStatus = List<GvDeviceStatus>.generate(
      GvDef.maxDeviceNum, (index) => GvDeviceStatus()); //상
  List<GvDeviceData> deviceData = List<GvDeviceData>.generate(
      GvDef.maxDeviceNum, (index) => GvDeviceData());

  List<GvDeviceControl> deviceControl = List<GvDeviceControl>.generate(
      // GvDef.maxDeviceNum, (index) => GvDeviceControl(EmlDeviceNumber.values[index]));
      GvDef.maxDeviceNum,
      (index) => GvDeviceControl(deviceIndex: index));

  // 블루투스 전역 변수 장비 개수 만큼 매니저 생성 시킴
  // List<BleModule> bleManager = List.generate(
  //     GvDef.maxDeviceNum, (index) => BleModule(deviceIndex: index));
  List<BtStateManager> btStateManager = List.generate(
      GvDef.maxDeviceNum, (index) => BtStateManager(deviceIndex: index));

  //----------------------------------------------------------------------------
  // GetX 공유메모리
  //----------------------------------------------------------------------------
  late GetStorage spMemory;

  //----------------------------------------------------------------------------
  // 기록 데이터베이스
  //----------------------------------------------------------------------------
  DbManagerHive dbmRecord = DbManagerHive(); //DbManagerSql();
  //--------------------------------
  // 기록 데이터 베이스 : 측정될 때 마다 레코드 추가
  List<DbRecordIndex> dbRecordIndexes = [];

  //--------------------------------
  // 기록 데이터 베이스 상세 - 1개만 존재
  DbRecordContents dbRecordContents = DbRecordContents();

  //----------------------------------------------------------------------------
  // 근육 데이터베이스
  //----------------------------------------------------------------------------
  DbManagerHive dbmMuscle = DbManagerHive(); //DbManagerSql();
  //--------------------------------
  // 근육 데이터 베이스 : 근육이 추가될 때 마다 레코드 추가
  List<DbMuscleIndex> dbMuscleIndexes = [];

  //--------------------------------
  // 근육데이터 베이스 상세 = 통계 (장비별 구분 없이 1개만 생성)
  DbMuscleContents dbMuscleContents = DbMuscleContents();

  //----------------------------------------------------------------------------
  // 기능 제어
  //----------------------------------------------------------------------------
  AudioManager audioManager = AudioManager(); // 오디오플레이어 전역 변수

  //----------------------------------------------------------------------------
  // 유튜브 메니저
  //----------------------------------------------------------------------------
  YoutubeManager youtubeManager = YoutubeManager()..init(); // 유튜브 매니저 전역 변수

  //----------------------------------------------------------------------------
  // 초기화 메서드
  //----------------------------------------------------------------------------
  void init() async {
    Directory getStorageDir = await getApplicationSupportDirectory();
    spMemory = Platform.isIOS ? GetStorage('FitsigStorage', getStorageDir.path) : GetStorage();
  }
}
