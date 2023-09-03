// import '/F0_BASIC/common_import.dart';
// import 'package:hive_flutter/hive_flutter.dart';

// //---------------------------------
// // Hive 형식의 모든 DB를 관리
// //---------------------------------
// class DbHiveManager {
//   late Box<DbHiveDataMuscle> _muscleBox;
//   late Box<DbHiveDataRecord> _recordBox;
//
//   //---------------
//   // hive DB 초기화  - 앱 시작할때 Splash 클래스(V00_intro_main.dart)의 initState() 안에서 실행
//   //---------------
//   Future<void> initHiveDb() async {
//     if (gv.system.isMobile) {
//       // Mobile 의 경우 OS로 부터 DB를 위한 path 를 받아옴
//       await Hive.initFlutter();
//     } else {
//       // Mobile 이 아닐 경우 DB를 위한 path 가 필요
//       //Hive.init(path);
//     }
//
//     // Hive DB에 사용되는 data type 을 등록
//     Hive.registerAdapter(DbHiveDataMuscleAdapter());
//     Hive.registerAdapter(DbHiveDataRecordAdapter());
//
//     // basic 앱에서 사용하는 2가지 DB Box에 대한 참조 변수에 입력
//     _muscleBox = await Hive.openBox<DbHiveDataMuscle>(
//         'muscleBox'); // 'muscle' 박스 생성. 이미 있으면?
//     _recordBox = await Hive.openBox<DbHiveDataRecord>(
//         'recordBox'); // 'record' 박스 생성. 이미 있으면?
//
//     // print('db_hive_manager.dart :: _muscleBox ${_muscleBox}');
//     // print('db_hive_manager.dart :: _recordBox ${_recordBox}');
//
//     // Hive DB 에서 Muscle 데이터, Record 데이터를 가져와서 메모리의 변수에 넣기
//     gv.hiveDataMuscle = gv.dbHiveManager.getAllMuscle();
//     gv.hiveDataRecord = gv.dbHiveManager.getAllRecord();
//   }
//
//   void closeABox(String boxName) {
//     Hive.box(boxName).close().then((_){
//       print('db_hive_manager.dart ::  gv.dbMuscleIndexes ${gv.dbMuscleIndexes}');
//       print('db_hive_manager.dart :: gv.hiveDataMuscle ${gv.hiveDataMuscle}');
//     });
//   }
//
//   void insert<T>({required T data}) {
//     if (data is DbHiveDataMuscle) {
//       _muscleBox.add(data); // add 메소드를 사용할 경우 key 는 자동으로 생성됨
//
//     } else if (data is DbHiveDataRecord) {
//       _recordBox.add(data); // add 메소드를 사용할 경우 key 는 자동으로 생성됨
//     } else {
//       if (kDebugMode) {
//         print('DBHiveManager :: Error : not available box.');
//       }
//     }
//   }
//
//   void insertWithKey<T>({required T data, required String key}) {
//     if (data is DbHiveDataMuscle) {
//       _muscleBox.put(key, data);
//     } else if (data is DbHiveDataRecord) {
//       _recordBox.put(key, data);
//     } else {
//       if (kDebugMode) {
//         print('DBHiveManager :: Error : not available box.');
//       }
//     }
//   }
//
//   void update<T>(T data, T newData) {
//     if (data is DbHiveDataMuscle) {
//       _muscleBox.put(data.key, newData as DbHiveDataMuscle);
//     } else if (data is DbHiveDataRecord) {
//       _recordBox.put(data.key, newData as DbHiveDataRecord);
//     } else {
//       if (kDebugMode) {
//         print('DBHiveManager :: Error : not available box.');
//       }
//     }
//   }
//
//   void delete<T>(T data) {
//     // HiveObject mixin 에서 구현된 method
//     // data.delete();
//     if (data is DbHiveDataMuscle) {
//       _muscleBox.delete(data.key);
//     } else if (data is DbHiveDataRecord) {
//       _recordBox.delete(data.key);
//     } else {
//       if (kDebugMode) {
//         print('DBHiveManager :: Error : not available box.');
//       }
//     }
//   }
//
//   // muscle 와 record 박스의 entry를 모두 제거
//   void clearBox() async {
//     var muscleBoxResult = await _muscleBox.clear();
//     var recordBoxResult = await _recordBox.clear();
//     print('db_hive_manager.dart :: muscleBox $muscleBoxResult cleared, recordBox $recordBoxResult cleared');
//   }
//
//   List<DbHiveDataRecord> getAllRecord() {
//     return _recordBox.values.toList();
//   }
//
//   List<DbHiveDataMuscle> getAllMuscle() {
//     return _muscleBox.values.toList();
//   }
//
//   void dispose() {
//     Hive.close();
//   }
// }
