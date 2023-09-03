import '/F0_BASIC/common_import.dart';

//==============================================================================
// dbManagerSql 기본 테스트
// 기본적 동작 확인 : 2022.8.2
//==============================================================================
Future dbSqlTest() async {
  //-------------------------------------------------------------------
  // [1] 데이터 베이스 생성
  // table 명 변경 가능
  //-------------------------------------------------------------------
  // await hiveInitialize();

  var dbm = DbManagerSql();
  await dbm.deleteDatabaseFile();
  await dbm.initDatabase(dbName: 'test', isDualMode: true); //박스 열기
  // await dbm.clearDatabase(); //내용 비우기

  if (kDebugMode) {
    print('---------------------------------------');
    print('SQL dB test');
    print('---------------------------------------');
  }

  //-------------------------------------------------------------------
  // [2] 데이터 추가하기
  //-------------------------------------------------------------------
  var iData = DbRecordIndex();
  var cData = DbRecordContents();

  iData.muscleName = '근육 1';
  cData.freqBegin = 1;
  await dbm.insertData(indexMap: iData.toJson(), contentsMap: cData.toJson());

  iData.muscleName = '근육 2';
  cData.freqBegin = 2;
  await dbm.insertData(indexMap: iData.toJson(), contentsMap: cData.toJson());

  iData.muscleName = '근육 3';
  cData.freqBegin = 3;
  await dbm.insertData(indexMap: iData.toJson(), contentsMap: cData.toJson());

  if (kDebugMode) {
    print('데이터 추가 후에...map 파일 개수 : ${dbm.indexData.length}');
  }
  //-------------------------------------------------------------------
  // 데이터 베이스 index 읽기
  //-------------------------------------------------------------------
  await dbm.readDataIndexes();
  if (kDebugMode) {
    print('인덱스 데이터 : ${dbm.indexData}');
    print('---------------------------------------');
  }

  //-------------------------------------------------------------------
  // 상세 데이터 읽기
  //-------------------------------------------------------------------
  await dbm.readDataContents(index: 0);
  if (kDebugMode) {
    print('상세 데이터 0 : ${dbm.contentsData}');
    print('---------------------------------------');
  }
  await dbm.readDataContents(index: 1);
  if (kDebugMode) {
    print('상세 데이터 1 : ${dbm.contentsData}');
    print('---------------------------------------');
  }
  await dbm.readDataContents(index: 2);
  if (kDebugMode) {
    print('상세 데이터 2 : ${dbm.contentsData}');
    print('---------------------------------------');
  }

  //-------------------------------------------------------------------
  // 데이터 삭제하기
  //-------------------------------------------------------------------
  await dbm.deleteData(index: 1);
  if (kDebugMode) {
    print('---------------------------------------');
    print('상세 데이터 1 삭제');
    print('---------------------------------------');
  }

  //-------------------------------------------------------------------
  // 데이터 베이스 index 읽기
  //-------------------------------------------------------------------
  await dbm.readDataIndexes();
  if (kDebugMode) {
    print('인덱스 데이터 : ${dbm.indexData}');
    print('---------------------------------------');
  }

  //-------------------------------------------------------------------
  // 상세 데이터 읽기
  //-------------------------------------------------------------------
  await dbm.readDataContents(index: 0);
  if (kDebugMode) {
    print('상세 데이터 0 : ${dbm.contentsData}');
    print('---------------------------------------');
  }
  await dbm.readDataContents(index: 1);
  if (kDebugMode) {
    print('상세 데이터 1 : ${dbm.contentsData}');
    print('---------------------------------------');
  }

  //-------------------------------------------------------------------
  // 테스트 데이터 베이스 삭제
  //-------------------------------------------------------------------
  await dbm.deleteDatabaseFile();
}
