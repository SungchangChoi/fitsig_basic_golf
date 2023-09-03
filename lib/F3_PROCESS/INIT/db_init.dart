import '/F0_BASIC/common_import.dart';

// import 'package:hive/hive.dart';
import 'dart:io';

//==============================================================================
// 근육 데이터 베이스 초기화
//==============================================================================
Future<void> dbInitMuscle({bool isDeleteDb = false}) async {
  if (kDebugMode) {
    print('근육 데이터 베이스 초기화');
  }

  //----------------------------------------------------------------------------
  // 데이터 베이스 초기화 (1개의 테이블만 사용)
  //----------------------------------------------------------------------------
  var dbm = gv.dbmMuscle;

  await dbm.initDatabase(dbName: 'muscle', isDualMode: true); //초기화
  if (isDeleteDb == true) {
    await dbm.clearDatabase(); //데이터베이스 삭제 (데이터 초기화 시 실행)
  }

  await dbm.readDataIndexes(); //dB index 전체 읽기

  //----------------------------------------------------------------------------
  // 저장된 기록이 없을 경우 4개의 근육 기본적으로 추가
  //----------------------------------------------------------------------------
  if (dbm.numberOfData == 0) {
    //---------------- index dB 초기화    
    gv.dbMuscleIndexes = []; //index 도 초기화 필요

    //---------------- 근육 1
    gv.dbMuscleIndexes.add(DbMuscleIndex());
    gv.dbMuscleContents = DbMuscleContents();
    gv.dbMuscleIndexes[0].muscleName = '이두근 좌';
    gv.dbMuscleIndexes[0].muscleTypeIndex = 3;
    gv.dbMuscleIndexes[0].isLeft = true;
    await dbm.insertData(
        indexMap: gv.dbMuscleIndexes[0].toJson(),
        contentsMap: gv.dbMuscleContents.toJson());

    //---------------- 근육 2
    gv.dbMuscleIndexes.add(DbMuscleIndex());
    gv.dbMuscleContents = DbMuscleContents();
    gv.dbMuscleIndexes[0].muscleName = '이두근 우';
    gv.dbMuscleIndexes[0].muscleTypeIndex = 3;
    gv.dbMuscleIndexes[0].isLeft = false;
    await dbm.insertData(
        indexMap: gv.dbMuscleIndexes[0].toJson(),
        contentsMap: gv.dbMuscleContents.toJson());

    //---------------- 근육 3
    gv.dbMuscleIndexes.add(DbMuscleIndex());
    gv.dbMuscleContents = DbMuscleContents();
    gv.dbMuscleIndexes[0].muscleName = '대퇴사두근 좌';
    gv.dbMuscleIndexes[0].muscleTypeIndex = 23;
    gv.dbMuscleIndexes[0].isLeft = true;
    await dbm.insertData(
        indexMap: gv.dbMuscleIndexes[0].toJson(),
        contentsMap: gv.dbMuscleContents.toJson());

    //---------------- 근육 4
    gv.dbMuscleIndexes.add(DbMuscleIndex());
    gv.dbMuscleContents = DbMuscleContents();
    gv.dbMuscleIndexes[0].muscleName = '대퇴사두근 우';
    gv.dbMuscleIndexes[0].muscleTypeIndex = 23;
    gv.dbMuscleIndexes[0].isLeft = false;
    await dbm.insertData(
        indexMap: gv.dbMuscleIndexes[0].toJson(),
        contentsMap: gv.dbMuscleContents.toJson());


    //---------------- 근육 5
    gv.dbMuscleIndexes.add(DbMuscleIndex());
    gv.dbMuscleContents = DbMuscleContents();
    gv.dbMuscleIndexes[0].muscleName = '사용자 정의';
    gv.dbMuscleIndexes[0].muscleTypeIndex = 0;
    await dbm.insertData(
        indexMap: gv.dbMuscleIndexes[0].toJson(),
        contentsMap: gv.dbMuscleContents.toJson());

    // //---------------- 근육 3
    // gv.dbMuscleIndexes.add(DbMuscleIndex());
    // gv.dbMuscleContents = DbMuscleContents();
    // gv.dbMuscleIndexes[0].muscleName = '근육3';
    // await dbm.insertData(
    //     indexMap: gv.dbMuscleIndexes[0].toJson(),
    //     contentsMap: gv.dbMuscleContents.toJson());
    //
    // //---------------- 근육 4
    // gv.dbMuscleIndexes.add(DbMuscleIndex());
    // gv.dbMuscleContents = DbMuscleContents();
    // gv.dbMuscleIndexes[0].muscleName = '근육4';
    // // print('근육4를 dbMuscleIndexes[0]에 입력함');
    // await dbm.insertData(
    //     indexMap: gv.dbMuscleIndexes[0].toJson(),
    //     contentsMap: gv.dbMuscleContents.toJson());
  }
  //----------------------------------------------------------------------------
  // class 데이터 생성하기
  // class 데이터는 DB 데이터를 처리하기 쉽게 하기 위한 용도
  // 레코드 수 만큼 생성
  //----------------------------------------------------------------------------
  else {
    gv.dbMuscleIndexes =
        List.generate(dbm.numberOfData, (index) => DbMuscleIndex());

    //--------------------------------------------------------------------------
    // 값 불러 오기 : db Map data 를 class 데이터로 변환 (근육 수 만큼)
    //--------------------------------------------------------------------------
    for (int n = 0; n < dbm.numberOfData; n++) {
      indexMapToMuscleIndexObject(n);
    }
  }
  //----------------------------------------------------------------------------
  // 현재 선택된 근육 관련 상세 데이터 읽기
  //----------------------------------------------------------------------------
  // dbm.readDataContents(index: gv.control.idxMuscle.value);
  // print('근육1 ${gv.dbMuscleIndexes[0].mvcLevel}');
  // print('근육2 ${gv.dbMuscleIndexes[1].mvcLevel}');
  // print('근육3 ${gv.dbMuscleIndexes[2].mvcLevel}');
  // print('근육4 ${gv.dbMuscleIndexes[3].mvcLevel}');


  //----------------------------------
  // 읽어서 확인
  if (kDebugMode) {
    // print(dbm.tRaw);
    // print(dbm.tData);
    // dbData = DbDataMuscle.fromJson(dbm.tData[0]);
    // print(dbData.muscleName);
    //
    // await dbm.deleteDbRecordByIndex(index: 2);
    // await dbm.deleteDbRecordById(id: 4);
    // print(dbm.tRaw);
    // print(dbm.tData);
    //
    // dbData.muscleName = '근육11111';
    // await dbm.updateDbRecordByIndex(index: 0, mapData: dbData.toJson());
    //
    // dbData.muscleName = '근육22222';
    // await dbm.updateDbRecordById(id: 2, mapData: dbData.toJson());
    //
    // print(dbm.tRaw);
    // print(dbm.tData);
  }
}

//==============================================================================
// 기록 데이터 베이스 초기화
//==============================================================================
Future<void> dbInitRecord({bool isDeleteDb = false}) async {
  if (kDebugMode) {
    print('기록 데이터 베이스 초기화');
  }

  //----------------------------------------------------------------------------
  // 데이터 베이스 초기화 (1개의 테이블만 사용)
  //----------------------------------------------------------------------------
  var dbm = gv.dbmRecord; // Record 저장용 DB manager instance
  
  await dbm.initDatabase(dbName: 'record', isDualMode: true); //초기화
  if (isDeleteDb == true) {
    await dbm.clearDatabase(); //데이터베이스 삭제 (데이터 초기화 시 실행)
  }

  await dbm.readDataIndexes(); //dB index 전체 읽기

  //----------------------------------------------------------------------------
  // 값 불러 오기 db Map data 를 class 데이터로 변환
  // 다량의 데이터가 존재함을 고려하여 필요한 만큼만 변환하는 것 검토
  //----------------------------------------------------------------------------
  if (dbm.numberOfData >= 0) {
    gv.dbRecordIndexes =
        List.generate(dbm.numberOfData, (index) => DbRecordIndex());

    for (int n = 0; n < dbm.numberOfData; n++) {
      indexMapToRecordIndexObject(n);
      // indexMapToRecordIndexManual(n); //map을 class로 수동 변환 (dB 변경 대응)
    }
    gvRecord.totalNumOfRecord.value = gv.dbmRecord.numberOfData;
  }

  //----------------------------------
  // 읽어서 확인
  // if (kDebugMode) {
  //   print(dbm.tRaw);
  // }

  //-------------------------------------------------
  // DB 추가 test
  // gv.dbRecordIndexes.muscleName = '근육 1';
  // String jsonString = jsonEncode(gv.dbRecordIndexes.toJson());
  // // if (kDebugMode) {
  // //   print(jsonString);
  // // }
  // await gv.dbmRecord.insertDbRecord(jsonString: jsonString);
  //
  // gv.dbRecordIndexes.muscleName = '근육 2';
  // jsonString = jsonEncode(gv.dbRecordIndexes.toJson());
  // await gv.dbmRecord.insertDbRecord(jsonString: jsonString);
  //-------------------------------------------------
  // 레코드 읽기 테스트
  // var jsonMap = gv.dbmRecord.readRecordFromMap(1);
  // print(jsonMap);
  // //Map data to class data
  // gv.dbRecordIndexes = DbDataRecord.fromJson(jsonMap);
  // print(gv.dbRecordIndexes.muscleName);
}
