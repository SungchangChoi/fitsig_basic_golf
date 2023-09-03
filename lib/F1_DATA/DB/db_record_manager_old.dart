// import '/F0_BASIC/common_import.dart';
// import 'package:sqflite/sqflite.dart' as sql;
// import 'package:path/path.dart';
//
// //==============================================================================
// // DB 멤버 기본 툴
// //==============================================================================
// class DbRecordManager {
//   static late sql.Database dB; //데이터 베이스 정의
//
//   //---------------------------------------------------------------------
//   // 기록 dB 생성
//   // 데이터 베이스 생성 (테이블을 한번 만들고 나면 추가 변경 어려움)
//   // 테이블이 이미 있는 경우의 삭제 : await db.execute("DROP TABLE IF EXISTS tableName");
//   // gDbMember.delete('members'); //기존 테이블 내용 지우기 ?
//   //---------------------------------------------------------------------
//   static initDatabase() async {
//     //----------------------------------------
//     // DB 삭제 (시험용 - 기본은 주석 처리)
//     // await deleteDatabase();
//
//     //----------------------------------------
//     // DB 생성
//     dB = await SqlBasic.initDatabase(
//       dbFileName: 'record.db',
//       createTable:
//           "CREATE TABLE table (id INTEGER PRIMARY KEY, jsonString TEXT)",
//     );
//
//     //----------------------------------------
//     // DB 읽기
//     await readDatabase();
//   }
//
//   //---------------------------------------------------------------------
//   // 회원 dB 제거 (버그 시 및 초기화 시)
//   //---------------------------------------------------------------------
//   static deleteDatabase() async {
//     var databasesPath = await sql.getDatabasesPath();
//     // print(databasesPath);
//     String path = join(databasesPath, 'record.db');
//     await sql.deleteDatabase(path);
//   }
//
//   //---------------------------------------------------------------------
//   // 데이터 베이스 테이블 보기
//   //---------------------------------------------------------------------
//   static Future readTable() async {
//     return await dB.rawQuery('SELECT * FROM sqlite_master ORDER BY KEY;');
//   }
//
//   //---------------------------------------------------------------------
//   // 리포트 추가
//   //---------------------------------------------------------------------
//   static insertData() async {
//     // 마지막 회원의 id 읽기
//     int lastId = lastDataId();
//     // 현재의 레코드 데이터 내용을 jsonString 으로 변환
//     String jsonString = jsonEncode(gv.dbRecord.contents);
//
//     var dbMap = DbDataBasic(id: lastId, jsonString: jsonString).toMap();
//     await SqlBasic.insert(dB, 'table', dbMap);
//     // 다시 데이터 읽어서 전역변수 갱신 - 현재 값만 추가/빼는 방식으로 연산 절약 추후에 수행
//     await readDatabase();
//   }
//
//   //---------------------------------------------------------------------
//   // 데이터 갱신
//   //---------------------------------------------------------------------
//   static updateData({
//     required int id,
//     required String jsonString,
//   }) async {
//     var dbMap = DbDataBasic(id: id, jsonString: jsonString).toMap();
//     await SqlBasic.updateData(dB, 'table', dbMap, id);
//     // 다시 데이터 읽어서 전역변수 갱신 - 현재 값만 추가/빼는 방식으로 연산 절약 추후에 수행
//     await readDatabase();
//   }
//
//   //---------------------------------------------------------------------
//   // 리포트 삭제
//   //---------------------------------------------------------------------
//   static deleteData({required int id}) async {
//     await SqlBasic.deleteData(dB, 'table', id);
//     // 다시 데이터 읽어서 전역변수 갱신 - 현재 값만 추가/빼는 방식으로 연산 절약 추후에 수행
//     await readDatabase();
//   }
//
//   //---------------------------------------------------------------------
//   // 데이터베이스 내용 전체 읽기 (각 멤버 정보를 Map 리스트로 반환)
//   // 리포트 수가 많을 경우 오래 걸릴 수 있으므로 현재 index 범위 전후로 읽기 등 검토
//   //---------------------------------------------------------------------
//   static readDatabase() async {
//     var dbDataTotal = await SqlBasic.getData(dB, 'table');
//     int dataSize = 0;
//     List<int> dataSizeList = []; //각 데이터 별 사이즈 기록
//     int totalSize = 0;
//     //----------------------------------------------- 용량 계산(String 길이 정보)
//     if (dbDataTotal.isNotEmpty) {
//       //String 길이 정보로 용량계산
//       for (int idx = 0; idx < dbDataTotal.length; idx++) {
//         String jsonString = dbDataTotal[idx]['jsonString'];
//         dataSize = jsonString.length; //현재 index size
//         totalSize += dataSize; //모든 데이터 사이즈
//         dataSizeList.add(dataSize); //각 데이터 사이즈 항목에 추가
//       }
//       //--------------------------------------------- 전역변수에 저장
//       gv.dbRecord.dbDataTotal = dbDataTotal;
//       gv.dbRecord.dataSizeList = dataSizeList;
//       gv.dbRecord.totalSize = totalSize + 8;
//     }
//   }
//
//   //---------------------------------------------------------------------
//   // 데이터베이스 리포트 값 load
//   //---------------------------------------------------------------------
//   static loadData(int idxData) async {
//     var dbDataTotal = gv.dbRecord.dbDataTotal;
//     //--------------------------------- 데이터 베이스 전체 다시 읽기
//     // 리포트 신규 추가, 삭제, 갱신시 매번 읽으므로 로드 단계 필요 없음
//     // GvReport.dB = await DBReportUtil.readDatabase();
//
//     // 인덱스에 해당하는 리포트 값 불러오기
//     var dbDataOfIdx = dbDataTotal[idxData];
//     // 정보 읽기
//     gv.dbRecord.contents = jsonDecode(dbDataOfIdx['jsonString']);
//   }
//
//   //---------------------------------------------------------------------
//   // 마지막 index id 읽기
//   //---------------------------------------------------------------------
//   static int lastDataId() {
//     int lastIndex;
//     var dbDataTotal = gv.dbRecord.dbDataTotal;
//     if (dbDataTotal.isNotEmpty) {
//       lastIndex = dbDataTotal.length - 1;
//       return dbDataTotal[lastIndex]['id'];
//     } else {
//       return 0; //데이터가 없는 경우 0 반환
//     }
//   }
// }
//
// //==============================================================================
// // DB 멤버 테스트
// //==============================================================================
// void dbRecordTest() async {
//   // //-------------------------------------------------------------------
//   // // 데이터 베이스 삭제
//   // //-------------------------------------------------------------------
//   // await DBReportUtil.deleteDatabase();
//   // // await DBMemberUtil.deleteDatabase();
//   //
//   // //-------------------------------------------------------------------
//   // // 데이터 베이스 생성
//   // //-------------------------------------------------------------------
//   // await DBReportUtil.initDatabase();
//   //
//   // //-------------------------------------------------------------------
//   // // 데이터베이스 조회하기
//   // //-------------------------------------------------------------------
//   // var data = await DBReportUtil.readDatabase();
//   // // print(data);
//   // // print(data.length);
//   //
//   // //-------------------------------------------------------------------
//   // // json encode decode test
//   // //-------------------------------------------------------------------
//   // // double aa = 1.0 / 10002;
//   // // var tmp = [0.123456616161611616,0.2, aa];
//   // // // var tt = t
//   // // String a = jsonEncode(tmp);
//   // // // npSum(data);
//   // // print(a);
//   // //
//   // // String b = jsonEncode(reportData);
//   // // print(b);
//   // //
//   // // var z = jsonDecode(b);
//   // // // print(z);
//   // // print(z[0]);
//   // //-------------------------------------------------------------------
//   // // 리포트 추가
//   // //-------------------------------------------------------------------
//   // String deviceReport = jsonEncode(
//   //     List.generate(MAX_DEVICE_NUM, (index) => dspModule[index].g.reportData));
//   //
//   // // GvMuscle.data[gListMuscle[0]] = 10.1;
//   // await DBReportUtil.insertReport(
//   //     id: 0, generalInfo: '000', deviceReport: deviceReport);
//   //
//   // //-------------------------------------------------------------------
//   // // 데이터베이스 조회하기
//   // //-------------------------------------------------------------------
//   // data = await DBReportUtil.readDatabase();
//   // // print(data);
//   //
//   // //-------------------------------------------------------------------
//   // // 리포트 추가
//   // //-------------------------------------------------------------------
//   //
//   // await DBReportUtil.insertReport(
//   //     id: 1, generalInfo: '111', deviceReport: deviceReport);
//   // await DBReportUtil.insertReport(
//   //     id: 2, generalInfo: '222', deviceReport: deviceReport);
//   // // await DBReportUtil.insertReport(id: 1, name: '홍길동1', muscles: GvMuscle.data);
//   // // await DBReportUtil.insertReport(id: 2, name: '홍길동2', muscles: GvMuscle.data);
//   //
//   // //-------------------------------------------------------------------
//   // // 데이터베이스 조회하기
//   // //-------------------------------------------------------------------
//   // // data = await DBReportUtil.readDatabase();
//   // // print(data);
//   // // print(data.length);
//   // // print(data[1]);
//   //
//   // //-------------------------------------------------------------------
//   // // 회원 삭제
//   // //-------------------------------------------------------------------
//   // await DBReportUtil.deleteReport(id: 0);
//   // // await DBReportUtil.deleteReport(id: 2);
//   // print(GvReport.dB);
//   //
//   // //-------------------------------------------------------------------
//   // // 데이터베이스 조회하기
//   // //-------------------------------------------------------------------
//   // // data = await DBReportUtil.readDatabase();
//   // // print(data);
//   //
//   // //-------------------------------------------------------------------
//   // // 데이터 베이스 업데이트
//   // //-------------------------------------------------------------------
//   //
//   // await DBReportUtil.updateReport(
//   //     id: 1, generalInfo: 'test', deviceReports: 'aaa');
//   // await DBReportUtil.updateReport(
//   //     id: 2, generalInfo: 'test2', deviceReports: 'bbb');
//   //
//   // print(GvReport.dB);
//   // print(GvReport.dB[0]);
//   // print(GvReport.dB[0]['id']);
//   //
//   // //-------------------------------------------------------------------
//   // // 데이터베이스 조회하기
//   // //-------------------------------------------------------------------
//   // // data = await DBReportUtil.readDatabase();
//   // // print(data);
//   //
//   // //-------------------------------------------------------------------
//   // // 데이터베이스 닫기
//   // //-------------------------------------------------------------------
//   // gDbReport.close();
//   //
//   // //-------------------------------------------------------------------
//   // // 종료 시 데이터 베이스 삭제 (테스트 용이므로)
//   // //-------------------------------------------------------------------
//   // await DBReportUtil.deleteDatabase();
// }
