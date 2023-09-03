import '/F0_BASIC/common_import.dart';

//==============================================================================
// 설정
//==============================================================================
class SettingExercise extends StatelessWidget {
  const SettingExercise({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
        color: tm.white,
        child: SafeArea(
          child: Column(
            children: [
              //----------------------------------------------------------------
              // 상단 바
              //----------------------------------------------------------------
              topBarBack(context, title: '운동설정'),
              asSizedBox(height: 26),
              Expanded(
                child: Scrollbar(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        //----------------------------------------------------------------
                        // 근육 명칭
                        //----------------------------------------------------------------
                        _muscleNameType(),
                        asSizedBox(height: 10),
                        dividerSmall(),

                        //--------------------------------------------------------------
                        // 심전도 동시 저장
                        //--------------------------------------------------------------
                        _ecgDataSave(),
                        asSizedBox(height: 10),
                        dividerSmall(),

                        //----------------------------------------------------------------
                        // 최대근력 레벨 자동 초기화
                        //----------------------------------------------------------------
                        // _mvcAuto(),
                        // asSizedBox(height: 10),
                        // dividerSmall(),

                        //--------------------------------------------------------------
                        // 충격 감지
                        //--------------------------------------------------------------
                        _noiseDetection(),
                        asSizedBox(height: 10),
                        dividerSmall(),
                        //--------------------------------------------------------------
                        // 가이드 방식
                        //--------------------------------------------------------------
                        // _setExerciseGuide(),
                        // asSizedBox(height: 10),
                        // dividerSmall(),
                        //--------------------------------------------------------------
                        // 평균과 최대최소 표시
                        //--------------------------------------------------------------
                        _setDisplayAvMax(),
                        asSizedBox(height: 10),
                        dividerSmall(),

                        //--------------------------------------------------------------
                        // 표시 단위 설정
                        //--------------------------------------------------------------
                        _setUnitKgf(),
                        asSizedBox(height: 10),
                        dividerSmall(),

                        //--------------------------------------------------------------
                        // 기타
                        // 운동 종료 조건
                        // 최대근력 자동 갱신 등 시험을 통해 결정
                        //--------------------------------------------------------------

                        //--------------------------------------------------------------
                        // 기본 값으로 재 설정
                        //--------------------------------------------------------------
                        asSizedBox(height: 20),
                        _setDefault(),

                        asSizedBox(height: 50),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}

//==============================================================================
// 근육 명칭
//==============================================================================
Widget _muscleNameType() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      settingSwitchBox(
          onChanged: ((check) {
            gv.setting.isMuscleNameKrPure.value = check;
            gv.spMemory.write('isMuscleNameKrPure', check); //공유 메모리 저장
          }),
          title: '근육명칭 순우리말 사용',
          subText:
              '근육명칭을 순 우리말로 표시합니다(예:큰 가슴근). 이 기능을 끄면 한자식으로 표현하게 됩니다.(예: 대흉근)',
          switchValue: gv.setting.isMuscleNameKrPure),
    ],
  );
}

//==============================================================================
// 심전도 데이터 저장 여부
//==============================================================================
Widget _ecgDataSave() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      settingSwitchBox(
          onChanged: ((check) {
            gv.setting.isSaveEcgData.value = check;
            gv.spMemory.write('isSaveEcgData', check); //공유 메모리 저장
          }),
          title: '심전도 데이터 함께 저장하기',
          subText:
          '측정 종료 시 심전도 데이터를 함께 저장하면 데이터 용량이 커집니다.'
              ' 심전도는 부정확할 수 있으며 심장에서 멀어지면 제대로 측정되지 않습니다.',
          switchValue: gv.setting.isSaveEcgData),
    ],
  );
}
//==============================================================================
// 최대근력 자동 계산 여부
// todo : 자동계산이 혼란을 줄 수 있어 일단 생략
//==============================================================================
Widget _mvcAuto() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      settingSwitchBox(
          onChanged: ((check) {
            gv.setting.is1RmAutoEstimate.value = check;
            gv.spMemory.write('is1RmAutoEstimate', check); //공유 메모리 저장
          }),
          title: '최대근력(1RM) 하강 자동 계산',
          subText: '장비를 근육에 새로 붙인 경우 첫번째 측정에서만 동작합니다.'
              ' 최대근력이 신규 측정 값 보다 큰 경우 값을 낮추기 위해 1회 자동계산 합니다.'
              '\n\n기능을 해제하면 최대근력 상승은 자동계산 하지만, 감소한 경우 자동계산 하지 않습니다.'
              '\n\n전극을 계속 동일한 곳에 부착할 경우 기능을 해제해도 좋습니다.'
              ' 기능이 해제된 경우 각 근육의 설정에서 수동으로 최대근력을 변경할 수 있습니다.',
          switchValue: gv.setting.is1RmAutoEstimate),
      // Obx(() {
      //   return gv.setting.is1RmAutoEstimate.value == true
      //       ? Container(
      //       padding: EdgeInsets.symmetric(horizontal: asWidth(18)),
      //       child: Column(
      //         children: [
      //           asSizedBox(height: 20),
      //           Row(
      //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //             children: [
      //               TextN(
      //                 '최대근력 시작 레벨 값 (1.0 권장)',
      //                 fontSize: tm.s20,
      //                 color: tm.grey05,
      //               ),
      //               Obx(() {
      //                 return TextN(
      //                   'Lv ${gv.setting.mvcDefaultValue.value.toStringAsFixed(1)}',
      //                   fontSize: tm.s20,
      //                   color: tm.grey05,
      //                 );
      //               })
      //             ],
      //           ),
      //           //---------------------------------------- 슬라이드
      //           const DefaultMvcSlider(),
      //           asSizedBox(height: 10),
      //           TextN(
      //             '낮은 값에서 시작하면 측정 중에 최대근력 추정 값이 실시간으로 반영됩니다.'
      //                 ' 높은 값에서 시작하면 최대근력을 제대로 측정하지 못할 수 있습니다.',
      //             fontSize: tm.s14,
      //             color: tm.grey03,
      //           ),
      //         ],
      //       ))
      //       : Container();
      // }),
    ],
  );
}

//==============================================================================
// 충격 감지
// 심장 부근에서 오동자작 하여 기본적으로 off 처리 (230412)
//==============================================================================
Widget _noiseDetection() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      settingSwitchBox(
          onChanged: ((check) {
            gv.setting.isNoiseDetectionEnable.value = check;
            gv.spMemory.write('isNoiseDetectionEnable', check); //공유 메모리 저장

            // 가짜신호 감지 기능 끄기
            if (gv.setting.isNoiseDetectionEnable.value == false) {
              DspCommonParameter.exEnFake = false;
            }
            // 가짜신호 감지 기능 켜기
            else {
              DspCommonParameter.exEnFake = true;
            }
          }),
          title: '장비 충격 감지 기능',
          subText: '기능을 활성화 하면 측정 중 발생하는 충격잡음을 감지합니다.'
              ' 이 감지기능은 심장부근에서는 심전도 신호로 인해 오동작 할 수 있습니다.',
          switchValue: gv.setting.isNoiseDetectionEnable),
    ],
  );
}

// Widget _mvcAutoReset() {
//   return Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       settingSwitchBox(
//           onChanged: ((check) {
//             gv.setting.isMeasureStartWithDefault.value = check;
//             gv.spMemory.write('isMeasureStartWithDefault', check); //공유 메모리 저장
//           }),
//           title: '최대근력 레벨 자동 초기화',
//           subText: '매 운동을 시작할 때 설정 값으로 최대근력이 초기화 됩니다.'
//               ' 여러명이 사용하거나, 패치 부착위치가 일정하지 않은 경우에는 자동초기화가 유용할 수 있습니다.'
//               ' 가능하면 패치를 동일한 근육 동일한 위치에 붙이며, 자동 초기화 기능을 사용하지 않는 것이 좋습니다.',
//           switchValue: gv.setting.isMeasureStartWithDefault),
//       Obx(() {
//         return gv.setting.isMeasureStartWithDefault.value == true
//             ? Container(
//                 padding: EdgeInsets.symmetric(horizontal: asWidth(18)),
//                 child: Column(
//                   children: [
//                     asSizedBox(height: 20),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         TextN(
//                           '최대근력 시작 레벨 값 (1.0 권장)',
//                           fontSize: tm.s20,
//                           color: tm.grey05,
//                         ),
//                         Obx(() {
//                           return TextN(
//                             'Lv ${gv.setting.mvcDefaultValue.value.toStringAsFixed(1)}',
//                             fontSize: tm.s20,
//                             color: tm.grey05,
//                           );
//                         })
//                       ],
//                     ),
//                     //---------------------------------------- 슬라이드
//                     const DefaultMvcSlider(),
//                     asSizedBox(height: 10),
//                     TextN(
//                       '낮은 값에서 시작하면 측정 중에 최대근력 추정 값이 실시간으로 반영됩니다.'
//                       ' 높은 값에서 시작하면 최대근력을 제대로 측정하지 못할 수 있습니다.',
//                       fontSize: tm.s14,
//                       color: tm.grey03,
//                     ),
//                   ],
//                 ))
//             : Container();
//       }),
//     ],
//   );
// }

//==============================================================================
// 운동 가이드 방식 설정
//==============================================================================
// Widget _setExerciseGuide() {
//   RxInt _refresh = 0.obs;
//   return settingSwitchBox(
//       onChanged: ((check) {
//         gv.setting.isGuideTypeTime.value = check;
//         gv.spMemory.write('isGuideTypeTime', check); //공유 메모리 저장
//       }),
//       title: '시간 가이드 방식',
//       subText: '기능이 켜진 경우 시간 방식으로 가이드를 제공하며 좀 더 실제적인 정보를 제공합니다. '
//           ' 기능이 꺼진 경우 전통적인 운동 방법인 반복횟수로 가이드를 제공합니다.',
//       switchValue: gv.setting.isGuideTypeTime);
// }

//==============================================================================
// 평균과 최대 값 표시
//==============================================================================
Widget _setDisplayAvMax() {
  RxInt _refresh = 0.obs;
  return settingSwitchBox(
      onChanged: ((check) {
        gv.setting.isViewAvMax.value = check;
        gv.spMemory.write('isViewAvMax', check); //공유 메모리 저장
      }),
      title: '근활성도 평균 및 최대 표시',
      subText: '기능이 켜지면 실시간 근활성도 바에 평균과 최대 값을 함께 표시 합니다.',
      switchValue: gv.setting.isViewAvMax);
}

//==============================================================================
// 평균과 시간 표시
//==============================================================================
Widget _setUnitKgf() {
  RxInt _refresh = 0.obs;
  return settingSwitchBox(
      onChanged: ((check) async {
        gv.setting.isViewUnitKgf.value = check;
        gv.spMemory.write('isViewUnitKgf', check); //공유 메모리 저장
        // 근육 단위 값 변경
        await gv.control.updateIdxMuscle(gv.control.idxMuscle.value);
        updateGraphData();
      }),
      title: '체감무게(kgf)로 단위 표시',
      subText: '기본 값인 전압(mV)이 아닌 체감무게(kgf) 단위를 표시합니다.'
          ' 체감 무게는 위팔 두갈래근(이두근) 기준으로 설정된 값으로, 사람마다 차이가 나며'
          ' 근육 부위에 따라서도 오차가 크게 나기도 하니 이용에 유의하시기 바랍니다.'
          ' 동일한 무게 저항에서 큰 근육일 수록 값이 작게 나오는 경향이 있습니다.',
      switchValue: gv.setting.isViewUnitKgf);
}

//==============================================================================
// 기본 설정 값으로 되돌리기
//==============================================================================
Widget _setDefault() {
  RxInt _refresh = 0.obs;
  return textButtonG(
    width: asWidth(360 - 36),
    height: asHeight(40),
    radius: asHeight(20),
    title: '운동 설정 초기화',
    textColor: tm.mainBlue,
    borderColor: tm.softBlue,
    onTap: (() {
      // 자동 1RM 설정 읽어오기
      gv.setting.is1RmAutoEstimate.value = GvSetting().is1RmAutoEstimate.value;
      gv.spMemory
          .write('is1RmAutoEstimate', gv.setting.is1RmAutoEstimate.value);

      // 디폴트 슬라이드 값 읽어오기
      gv.setting.mvcDefaultValue.value = GvSetting().mvcDefaultValue.value;
      gv.spMemory.write('mvcDefaultValue', gv.setting.mvcDefaultValue.value);

      // 데모 신호 생성여부
      gv.setting.isEnableDemo.value = GvSetting().isEnableDemo.value;
      gv.spMemory.write('isEnableDemo', gv.setting.isEnableDemo.value);

      // 운동 가이드 방식
      // gv.setting.isGuideTypeTime.value = GvSetting().isGuideTypeTime.value;
      // gv.spMemory.write('isGuideTypeTime', gv.setting.isGuideTypeTime.value);

      // 평균과 시간 표시
      gv.setting.isViewAvMax.value = GvSetting().isViewAvMax.value;
      gv.spMemory.write('isViewAvMax', gv.setting.isViewAvMax.value);
    }),
  );
}
