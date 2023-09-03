// import '/F0_BASIC/common_import.dart';
// import 'package:intl/intl.dart';
//
// class RecordDbInspector extends StatefulWidget {
//   const RecordDbInspector({Key? key}) : super(key: key);
//
//   @override
//   State<RecordDbInspector> createState() => _RecordDbInspectorState();
// }
//
// class _RecordDbInspectorState extends State<RecordDbInspector> {
//   late List<DbHiveDataRecord> records;
//
//   @override
//   void initState() {
//     super.initState();
//     records = gv.dbHiveManager.getAllRecord();
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       color: tm.white,
//       child: SafeArea(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             //----------------------------------------------------------------
//             // 상단 바
//             //----------------------------------------------------------------
//             topBarBack(context, title: 'RecordDB'),
//             asSizedBox(height: 26),
//             //상단 여유공간
//             //----------------------------------------------------------------
//             // Record 리스트
//             //----------------------------------------------------------------
//             Flexible(
//               child: ListView(
//                 children: records
//                     .map((record) => buildRecordListTile(record))
//                     .toList(),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget buildRecordListTile(DbHiveDataRecord record) {
//     var mappedRecord = record.toJson();
//     return ExpansionTile(
//       title: TextN('인덱스#: ${record.idxMuscle}  근육명: ${record.muscleName}'),
//       subtitle: TextN(
//           '운동시간: ${DateFormat('yy-MM-dd HH:mm:ss').format(record.startTime)} ~ ${DateFormat('yy-MM-dd HH:mm:ss').format(record.endTime)} (${record.exerciseTime} 초)'),
//       children: buildSubListTile(mappedRecord),
//     );
//   }
//
//   List<Widget> buildSubListTile(Map mappedRecord) {
//     return mappedRecord.entries
//         .map(
//           (entry) => Text('${entry.key} : ${entry.value}'),
//         )
//         .toList();
//   }
// }
