import 'package:fitsig_basic_golf/FF_DEBUG/V03_personal_information_old.dart';
import '/F0_BASIC/common_import.dart';
import 'dart:io' show Platform;

//==============================================================================
// 설정
//==============================================================================

class SettingGeneral extends StatelessWidget {
  const SettingGeneral({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      gv.control.refreshPageWhenSettingChange.value;
      return Material(
        color: tm.white,
        child: AnnotatedRegion<SystemUiOverlayStyle>(
          value: gv.setting.skinColor.value < 2
              ? SystemUiOverlayStyle.light.copyWith(
                  statusBarColor: Colors.white,
                  statusBarIconBrightness: Brightness.dark,
                  statusBarBrightness: Brightness.light,
                )
              : SystemUiOverlayStyle.dark.copyWith(
                  statusBarColor: Colors.black,
                  statusBarIconBrightness: Brightness.light,
                  statusBarBrightness: Brightness.dark,
                ),
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //------------------------------------------------------------------
                // 상단 바
                topBarBack(context, title: '일반설정'),
                asSizedBox(height: 26),
                Expanded(
                  child: Scrollbar(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          //----------------------------------------------------
                          // 색상 변경
                          // dividerSmall(),
                          settingButtonBox(
                            onTap: (() {
                              openBottomSheetBasic(
                                  isHeadView: true,
                                  headTitle: '스킨 컬러 선택',
                                  height: asHeight(420),
                                  child: _selectSkinColor(context));
                            }),
                            iconName: 'ic_스킨색상.png',
                            title: '스킨 색상',
                            subTitle: gv.setting.skinColor.value == 0
                                ? '라이트 블루'.tr
                                : gv.setting.skinColor.value == 1
                                    ? '라이트 딥블루'.tr
                                    : gv.setting.skinColor.value == 2
                                        ? '다크 블루'.tr
                                        : '다크 딥블루'.tr,
                            subTitleColor: tm.mainBlue,
                            buttonName: '변경'.tr,
                          ),
                          dividerSmall(),
                          // //-------------------------------------------------
                          // // 고대비
                          // settingSwitchBox(
                          //     onChanged: ((check) {
                          //       gv.setting.isHighContrastMode.value = check; //!test1.value;
                          //       gv.spMemory.write('isHighContrastMode',
                          //           gv.setting.isHighContrastMode.value);
                          //     }),
                          //     title: '고대비',
                          //     switchValue: gv.setting.isHighContrastMode),
                          // dividerSmall(),
                          //----------------------------------------------------
                          // 빅 폰트
                          settingSwitchBox(
                              onChanged: ((check) {
                                gv.setting.isBigFont.value =
                                    check; //!test1.value;
                                gv.spMemory.write(
                                    'isBigFont', gv.setting.isBigFont.value);

                                //----------------------------------------------
                                // big font 인 경우
                                //----------------------------------------------
                                if (gv.setting.isBigFont.value == true) {
                                  gv.setting.bigFontAddVal = 5;
                                  tm.convertFontSize();
                                } else {
                                  gv.setting.bigFontAddVal = 0;
                                  tm.convertFontSize();
                                }
                                // 화면 갱신
                                gv.control.refreshPageWhenSettingChange.value++;
                              }),
                              iconName: 'ic_큰글씨.png',
                              title: '큰 글씨',
                              switchValue: gv.setting.isBigFont,
                              subText: '큰 글씨 모드에서는 디자인이 어색할 수 있습니다'),
                          dividerSmall(),
                          settingSliderBox(
                            title: '음량',
                            iconName: 'ic_sound.png',
                            sliderValue: gv.audioManager.volume,
                            onChanged: (double value) {
                              print('setting_general :: volume = $value');
                              if (gv.audioManager.volume.value != value) {
                                gv.audioManager.setVolume(volume: value);
                              }
                            },
                            onChangedEnd: (double value) {
                              gv.audioManager.play(type: EmaSoundType.warning);
                            },
                            icons: gv.audioManager.volume.value == 0
                                ? Icons.volume_off_rounded
                                : Icons.volume_up_rounded,
                            iconColor: gv.audioManager.volume.value == 0
                                ? tm.grey03
                                : tm.mainBlue,
                          ),

                          dividerBig(),

                          //----------------------------------------------------
                          // 블루투스 자동연결
                          // 팝업창 코드와 동일하게
                          settingSwitchBox(
                              onChanged: ((check) {
                                int d = 0;
                                //----------------------------------------------
                                // 기존 장비 기록이 없는 상태라면, 무조건 disable
                                //----------------------------------------------
                                if (gv.deviceStatus[d].btControlState.value ==
                                    EmlBtControlState.idleInit) {
                                  gv.setting.isBluetoothAutoConnect.value =
                                      false;
                                  openSnackBarBasic('장비 기록 없음',
                                      '장비를 연결한 기록이 있어야 자동 설정이 가능합니다.');
                                }
                                //----------------------------------------------
                                // 기존 장비 기록이 있다면 설정 가능
                                //----------------------------------------------
                                else {
                                  gv.setting.isBluetoothAutoConnect.value =
                                      check; //
                                  gv.spMemory
                                      .write('isBluetoothAutoConnect', check);

                                  //--------------------------------------------
                                  // 연결 대기 상태에 따라 조건부 연결 처리
                                  //--------------------------------------------
                                  if (gv.setting.isBluetoothAutoConnect.value ==
                                      true) {
                                    gv.btStateManager[d]
                                        .whenAutoConnectChangeToEnable();
                                  } else {
                                    gv.btStateManager[d]
                                        .whenAutoConnectChangeToDisable();
                                  }
                                }
                              }),
                              iconName: 'ic_블루투스 자동연결.png',
                              title: '블루투스 자동연결'.tr,
                              switchValue: gv.setting.isBluetoothAutoConnect),
                          dividerSmall(),
                          //----------------------------------------------------
                          // 언어 변경
                          // 번역 구현 후 실행
                          // Obx(() {
                          //   return settingButtonBox(
                          //     onTap: (() {
                          //       openBottomSheetBasic(
                          //         child:
                          //             LanguageSpinnerPicker(context: context),
                          //         height: asHeight(340),
                          //       );
                          //     }),
                          //     title: '언어'.tr,
                          //     subTitle: LanguageData.supportedLanguage[
                          //         gv.setting.languageIndex.value],
                          //     // subTitle: LanguageLocal.getDisplayLanguage(
                          //     //         gv.setting.locale.value.languageCode)['nativeName']
                          //     //     .toString(),
                          //     subTitleColor: tm.blue,
                          //     buttonName: '변경'.tr,
                          //   );
                          // }),
                          //
                          // dividerSmall(),
                          //----------------------------------------------------
                          // 장비 상태 보기
                          // settingMenuBox(
                          //     onTap: (() {}), title: '장비상태 보기', isViewArrowRight: true),
                          // dividerSmall(),
                          //----------------------------------------------------
                          // 장비 끄기 버튼 시간 설정
                          Obx(() => settingButtonBox(
                                onTap: (() {
                                  openBottomSheetBasic(
                                    isHeadView: true,
                                    headTitle: '버튼 감지 시간',
                                    height: asHeight(400),
                                    child: const _SelectTouchTime(),
                                    // child: _SelectTouchTime(
                                    //     deviceNumber: EmlDeviceNumber.device1),
                                  );
                                }),
                                iconName: 'ic_전원버튼 감지시간.png',
                                title: '버튼 감지 시간'.tr,
                                subTitle:
                                    '${(dvSetting.touchTime.value / 10).toStringAsFixed(1)}초',
                                subTitleColor: tm.mainBlue,
                                lowerDescription: '장비의 전원버튼 꺼짐 시간을 설정합니다.',
                                buttonName: '변경'.tr,
                              )),
                          // asSizedBox(height: 30),
                          // Container(
                          //     padding:
                          //     EdgeInsets.symmetric(horizontal: asWidth(18)),
                          //     child: Column(
                          //       children: [
                          //         Container(
                          //           alignment: Alignment.centerLeft,
                          //           child: TextN(
                          //             '장비 전원버튼 꺼짐 시간'.tr,
                          //             fontSize: tm.s20,
                          //             color: tm.grey05,
                          //           ),
                          //         ),
                          //         asSizedBox(height: 10),
                          //         Container(
                          //           alignment: Alignment.center,
                          //           margin: EdgeInsets.symmetric(horizontal: asWidth(18)),
                          //           child: Column(
                          //             children: [
                          //               TextN(('장비가 스마트폰과 연결된 경우의 꺼짐시간을 설정합니다.'
                          //                   ' 근육 부착 과정에서 버튼이 터치되어 잘 꺼지는 경우 시간을 길게 설정하세요.'), fontSize: tm.s16, color: tm.grey03),
                          //             ],
                          //           ),
                          //         ),
                          //         asSizedBox(height: 18),
                          //         selectTouchTime(
                          //             deviceNumber: EmlDeviceNumber.device1),
                          //       ],
                          //     )),
                          // asSizedBox(height: 20),
                          dividerSmall(),
                          //----------------------------------------------------
                          // 엑셀 파일 내보내기
                          settingButtonBox(
                            onTap: (() async {
                              openBottomSheetBasicButtonWithWidget(
                                  headTitle: '통계 엑셀로 내보내기',
                                  height: asHeight(350),
                                  onTap: () async {
                                    // 버튼 클릭이 1회만 되도록 flag 를 체크
                                    if (dvSetting.isExportingExcel == false) {
                                      dvSetting.isExportingExcel = true;
                                      Get.back();
                                      await exportExcel();
                                      dvSetting.isExportingExcel = false;
                                    }
                                  },
                                  buttonTitle: Platform.isIOS ||
                                          (Platform.isAndroid &&
                                              int.parse(gv.system.osVersion!) <
                                                  11)
                                      ? '내보내기'.tr
                                      : '저장할 폴더 선택'.tr,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      if (Platform.isIOS)
                                        TextN(
                                          '통계 자료를 엑셀 파일로 저장합니다.\n파일은 나의 iPhone > 핏시그 베이직에 statistics.xlsx로 저장됩니다.\n'
                                          '내보내기한 파일은 파일 관리 앱에서 확인하거나, SNS 메신저 등에서 공유하여 외부로 전송할 수 있습니다.',
                                          color: tm.grey04,
                                          fontWeight: FontWeight.bold,
                                          fontSize: tm.s14,
                                          height: 1.5,
                                        ),
                                      if (Platform.isAndroid &&
                                          int.parse(gv.system.osVersion!) < 11)
                                        TextN(
                                          '통계 자료를 엑셀 파일로 저장합니다.\n내보내기한 파일은 파일 관리 앱에서 확인하거나,'
                                          ' SNS 메신저 등에서 공유하여 외부로 전송할 수 있습니다.',
                                          color: tm.grey04,
                                          fontWeight: FontWeight.bold,
                                          fontSize: tm.s14,
                                          height: 1.5,
                                        ),
                                      if (Platform.isAndroid &&
                                          int.parse(gv.system.osVersion!) >= 11)
                                        TextN(
                                          '파일을 저장할 폴더를 선택하신 후 화면 맨 아래 \'이 폴더 사용\' 버튼을 클릭하세요.'
                                          '\n내보내기한 파일은 파일 관리 앱에서 확인하거나, SNS 메신저 등에서 공유하여 외부로 전송할 수 있습니다.',
                                          color: tm.grey04,
                                          fontWeight: FontWeight.bold,
                                          fontSize: tm.s14,
                                          height: 1.5,
                                        ),
                                      SizedBox(height: asHeight(10)),
                                      if (Platform.isAndroid &&
                                          int.parse(gv.system.osVersion!) >=
                                              11 &&
                                          dvSetting.exportExcelDirectoryString
                                                  .value !=
                                              '')
                                        TextN(
                                          '최근 저장 경로: ${dvSetting.exportExcelDirectoryString.value}',
                                          color: tm.grey04,
                                          fontWeight: FontWeight.bold,
                                          fontSize: tm.s14,
                                          height: 1.5,
                                        ),
                                    ],
                                  ));
                            }),
                            iconName: 'ic_통계 엑셀.png',
                            title: '통계 엑셀 파일 내보내기',
                            //todo : 표젼 변경하는 것 검토 (별도의 창에서 설명?)
                            lowerDescription: '운동 통계 자료를 엑셀 파일로 출력합니다',
                          ),
                          dividerSmall(),

                          //----------------------------------------------------
                          // 운동 기록 관련 작업 선택 팝업 뛰우기
                          settingButtonBox(
                            onTap: () {
                              openPopupBasicButton(
                                width: asWidth(300),
                                height: asHeight(220),
                                title: '운동기록 파일 불러오기/내보내기',
                                text: '운동기록 파일을 불러오거나 내보낼 수 있습니다. ',
                                buttonNumber: 2,
                                buttonTitleList: ['불러오기', '내보내기'],
                                buttonTitleColorList: [tm.white, tm.mainBlue],
                                buttonBackgroundColorList: [
                                  tm.mainBlue,
                                  tm.softBlue
                                ],
                                callbackList: [
                                  () async {
                                    Get.back();
                                    openBottomSheetBasicButtonWithWidget(
                                      headTitle: '운동기록 파일 불러오기',
                                      height: asHeight(350),
                                      onTap: (() async {
                                        if (dvSetting.isImportingDb == false) {
                                          dvSetting.isImportingDb = true;
                                          Get.back();
                                          await importDbAndPicture();
                                          dvSetting.isImportingDb = false;
                                        }
                                      }),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          TextN(
                                            '운동기록 파일을 볼러올 수 있습니다. 불러올 파일을 선택해주세요.',
                                            color: tm.grey04,
                                            fontWeight: FontWeight.bold,
                                            fontSize: tm.s14,
                                            height: 1.5,
                                          ),
                                          SizedBox(height: asHeight(10)),
                                          TextN(
                                            '경고! 새로운 운동기록 파일을 불러오면 현재 기기에 저장된 모든 기록이 삭제되니 주의 바랍니다',
                                            color: tm.red,
                                            fontWeight: FontWeight.bold,
                                            fontSize: tm.s14,
                                            height: 1.5,
                                          ),
                                        ],
                                      ),
                                      buttonTitle: '불러올 파일 선택',
                                    );
                                  },
                                  () async {
                                    Get.back();
                                    openBottomSheetBasicButtonWithWidget(
                                      headTitle: '운동기록 파일 내보내기',
                                      height: asHeight(350),
                                      onTap: (() async {
                                        if (dvSetting.isExportingDb == false) {
                                          dvSetting.isExportingDb = true;
                                          Get.back();
                                          await exportDbAndPicture();
                                          dvSetting.isExportingDb = false;
                                        }
                                      }),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          if (Platform.isIOS)
                                            TextN(
                                              '모든 운동기록 파일을 저장합니다.\n파일은 나의 iPhone > 핏시그 베이직에 backup_[날짜] 형식으로 저장됩니다.\n'
                                              '내보내기한 파일은 파일 관리 앱에서 확인하거나 SNS 메신저 등에서 공유하여 외부로 전송할 수 있습니다.',
                                              color: tm.grey04,
                                              fontWeight: FontWeight.bold,
                                              fontSize: tm.s14,
                                              height: 1.5,
                                            ),
                                          if (Platform.isAndroid &&
                                              int.parse(gv.system.osVersion!) <
                                                  11)
                                            TextN(
                                              '모든 운동기록 파일을 저장합니다. 파일은 backup_[날짜] 형식으로 저장됩니다.\n'
                                              '내보내기한 파일은 파일 관리 앱에서 확인하거나 SNS 메신저 등에서 공유하여 외부로 전송할 수 있습니다.',
                                              color: tm.grey04,
                                              fontWeight: FontWeight.bold,
                                              fontSize: tm.s14,
                                              height: 1.5,
                                            ),
                                          if (Platform.isAndroid &&
                                              int.parse(gv.system.osVersion!) >=
                                                  11)
                                            TextN(
                                              '운동기록 파일을 저장할 폴더를 선택하신 후 화면 맨 아래 \'이 폴더 사용\'버튼을 클릭하세요.\n'
                                              '내보내기한 파일은 파일 관리 앱에서 확인하거나 SNS 메신저 등에서 공유하여 외부로 전송할 수 있습니다.',
                                              color: tm.grey04,
                                              fontWeight: FontWeight.bold,
                                              fontSize: tm.s14,
                                              height: 1.5,
                                            ),
                                          SizedBox(height: asHeight(10)),
                                          if (Platform.isAndroid &&
                                              int.parse(gv.system.osVersion!) >=
                                                  11 &&
                                              dvSetting.exportDbDirectoryString
                                                      .value !=
                                                  '')
                                            TextN(
                                              '최근 저장 경로: ${dvSetting.exportDbDirectoryString.value}',
                                              color: tm.grey04,
                                              fontWeight: FontWeight.bold,
                                              fontSize: tm.s14,
                                              height: 1.5,
                                            ),
                                        ],
                                      ),
                                      buttonTitle: Platform.isIOS ||
                                              (Platform.isAndroid &&
                                                  int.parse(gv
                                                          .system.osVersion!) <
                                                      11)
                                          ? '내보내기'
                                          : '저장할 폴더 선택',
                                    );
                                  },
                                ],
                              );
                            },
                            iconName: 'ic_운동기록.png',
                            title: '운동기록 파일 불러오기/내보내기',
                            lowerDescription: '운동기록 파일을 불러오거나 내보냅니다.',
                          ),
                          dividerSmall(),

                          //----------------------------------------------------
                          // 운동 영상 삭제
                          settingButtonBox(
                            onTap: () {
                              openPopupBasicButton(
                                width: asWidth(300),
                                height: asHeight(210),
                                title: '운동영상 다운로드/삭제',
                                text: '운동영상을 다운로드하거나 삭제할 수 있습니다. ',
                                buttonNumber: 2,
                                buttonTitleList: ['다운로드', '삭제'],
                                buttonTitleColorList: [tm.white, tm.mainBlue],
                                buttonBackgroundColorList: [
                                  tm.mainBlue,
                                  tm.softBlue
                                ],
                                callbackList: [
                                      () async {
                                        Get.back();
                                        openBottomSheetBasic(
                                            height: asHeight(280),
                                            child:
                                            downloadAllVideosBottomSheetContent());
                                  },
                                  () async {
                                    Get.back();
                                    openBottomSheetBasic(
                                        height: asHeight(220),
                                        child:
                                            deleteAllVideosBottomSheetContent());
                                  },
                                ],
                              );
                            },
                            iconName: 'ic_youtube.png',
                            title: '운동 영상 다운로드/삭제',
                            lowerDescription: '기기에 모든 운동 영상을 다운로드 또는 삭제합니다.',
                          ),

                          dividerSmall(),

                          //----------------------------------------------------
                          // 데이터 초기화
                          settingButtonBox(
                            onTap: (() {
                              openBottomSheetBasic(
                                  // isHeadView: true,
                                  // headTitle: '데이터 초기화',
                                  height: asHeight(250),
                                  child:
                                      dataInitializationBottomSheetContent());
                            }),
                            iconName: 'ic_기록초기화.png',
                            title: '기록 초기화',
                            lowerDescription: '측정된 모든 운동기록을 삭제합니다.',
                          ),
                          dividerBig(),
                          asSizedBox(height: 20),

                          Container(
                            padding:
                                EdgeInsets.symmetric(horizontal: asWidth(18)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Container(
                                //   alignment: Alignment.centerLeft,
                                //   child: TextN('기본정보 변경'.tr,
                                //       fontSize: tm.s14, color: tm.grey04),
                                // ),
                                TextN(
                                  '기본정보 변경'.tr,
                                  fontSize: tm.s14,
                                  color: tm.grey04,
                                  fontWeight: FontWeight.bold,
                                ),
                                asSizedBox(height: 24),
                                //----------------------------------------------------
                                // 성별 선택
                                //----------------------------------------------------
                                TextN(
                                  '성별'.tr,
                                  fontSize: tm.s14,
                                  color: tm.black,
                                ),
                                asSizedBox(height: 12),
                                //--------------------------------------------------------------------
                                // 성별 드랍박스
                                //--------------------------------------------------------------------
                                wButtonSel(
                                  onTap: () {
                                    openBottomSheetBasic(
                                        height: gv.setting.isBigFont.value
                                            ? asHeight(420)
                                            : asHeight(380),
                                        child: genderPicker(
                                          initialIndex:
                                              gv.setting.genderIndex.value,
                                          callbackOnTap: (idxPresent) async {
                                            gv.setting.genderIndex.value =
                                                idxPresent;
                                            await gv.spMemory.write(
                                                'genderIndex',
                                                gv.setting.genderIndex.value);
                                            Get.back();
                                            gv
                                                .control
                                                .refreshPageWhenSettingChange
                                                .value++;
                                          },
                                        ));
                                  },
                                  height: asHeight(44),
                                  width: asWidth(324),
                                  touchRadius: asHeight(8),
                                  radius: asHeight(8),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: asHeight(15)),
                                    child: Text(
                                      gv.setting.genderList.elementAt(
                                          gv.setting.genderIndex.value),
                                      style: TextStyle(
                                        fontSize: tm.s14,
                                        fontWeight: FontWeight.normal,
                                        color: tm.black,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                                //----------------------------------------------------
                                // 출생연도
                                //----------------------------------------------------
                                asSizedBox(height: 30),
                                TextN(
                                  '출생연도 선택'.tr,
                                  fontSize: tm.s14,
                                  color: tm.black,
                                ),
                                asSizedBox(height: 12),
                                wButtonSel(
                                  onTap: () {
                                    openBottomSheetBasic(
                                      height: gv.setting.isBigFont.value
                                          ? asHeight(420)
                                          : asHeight(380),
                                      child: bornYearPicker(
                                        initialIndex:
                                            gv.setting.bornYearIndex.value,
                                        callbackOnTap: (idxPresent) async {
                                          gv.setting.bornYearIndex.value =
                                              idxPresent;
                                          await gv.spMemory.write(
                                              'bornYearIndex',
                                              gv.setting.bornYearIndex.value);
                                          Get.back();
                                          gv
                                              .control
                                              .refreshPageWhenSettingChange
                                              .value++;
                                        },
                                      ),
                                    );
                                  },
                                  height: asHeight(44),
                                  width: asWidth(324),
                                  touchRadius: asHeight(8),
                                  radius: asHeight(8),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: asHeight(15)),
                                    child: Text(
                                      gv.setting.bornYearList.elementAt(
                                          gv.setting.bornYearIndex.value),
                                      style: TextStyle(
                                        fontSize: tm.s14,
                                        fontWeight: FontWeight.normal,
                                        color: tm.black,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                                asSizedBox(height: 40),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}

//==============================================================================
// 컬러 선택
//==============================================================================
RxInt _selectNum = 0.obs;

Widget _selectSkinColor(BuildContext context) {
  _selectNum.value = gv.setting.skinColor.value;
  return Obx(() {
    gv.control.refreshPageWhenSettingChange.value;
    return Container(
      padding:
          EdgeInsets.symmetric(horizontal: asWidth(18), vertical: asHeight(20)),
      // margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: tm.white, borderRadius: BorderRadius.circular(asHeight(10))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _skinColorBox(
                      index: 0,
                      title: '라이트 블루',
                      pointBlue: SkinColorLightBlue.pointBlue,
                      mainBlue: SkinColorLightBlue.mainBlue,
                      softBlue: SkinColorLightBlue.softBlue,
                      mainGreen: SkinColorLightBlue.mainGreen,
                      textColor: SkinColorLightBlue.black,
                      backgroundColor: SkinColorLightBlue.white,
                      grey01: SkinColorLightBlue.grey01,
                      grey02: SkinColorLightBlue.grey02,
                      grey03: SkinColorLightBlue.grey03,
                      grey04: SkinColorLightBlue.grey04,
                      onTap: (() {
                        _selectNum.value = 0; //0 = light blue
                      })),
                  _skinColorBox(
                      index: 1,
                      title: '라이트 딥블루',
                      pointBlue: SkinColorLightDeepBlue.pointBlue,
                      mainBlue: SkinColorLightDeepBlue.mainBlue,
                      softBlue: SkinColorLightDeepBlue.softBlue,
                      mainGreen: SkinColorLightDeepBlue.mainGreen,
                      textColor: SkinColorLightDeepBlue.black,
                      backgroundColor: SkinColorLightDeepBlue.white,
                      grey01: SkinColorLightDeepBlue.grey01,
                      grey02: SkinColorLightDeepBlue.grey02,
                      grey03: SkinColorLightDeepBlue.grey03,
                      grey04: SkinColorLightDeepBlue.grey04,
                      onTap: (() {
                        _selectNum.value = 1; //1 = light orange
                      })),
                ],
              ),
              asSizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _skinColorBox(
                      index: 2,
                      title: '다크 블루',
                      pointBlue: SkinColorDarkBlue.pointBlue,
                      mainBlue: SkinColorDarkBlue.mainBlue,
                      softBlue: SkinColorDarkBlue.softBlue,
                      mainGreen: SkinColorDarkBlue.mainGreen,
                      textColor: SkinColorDarkBlue.black,
                      backgroundColor: SkinColorDarkBlue.white,
                      grey01: SkinColorDarkBlue.grey01,
                      grey02: SkinColorDarkBlue.grey02,
                      grey03: SkinColorDarkBlue.grey03,
                      grey04: SkinColorDarkBlue.grey04,
                      onTap: (() {
                        _selectNum.value = 2; //2 = dart blue
                      })),
                  _skinColorBox(
                      index: 3,
                      title: '다크 딥블루',
                      pointBlue: SkinColorDarkDeepBlue.pointBlue,
                      mainBlue: SkinColorDarkDeepBlue.mainBlue,
                      softBlue: SkinColorDarkDeepBlue.softBlue,
                      mainGreen: SkinColorDarkDeepBlue.mainGreen,
                      textColor: SkinColorDarkDeepBlue.black,
                      backgroundColor: SkinColorDarkDeepBlue.white,
                      grey01: SkinColorDarkDeepBlue.grey01,
                      grey02: SkinColorDarkDeepBlue.grey02,
                      grey03: SkinColorDarkDeepBlue.grey03,
                      onTap: (() {
                        _selectNum.value = 3; //3 = dart orange
                      })),
                ],
              ),
            ],
          ),
          // asSizedBox(height: 20),
          // TextN(
          //   '변경한 스킨색상을 적용하려면 앱을 재 시작 해야 합니다.',
          //   color: tm.grey04,
          //   fontSize: tm.s16,
          // ),
          asSizedBox(height: 40),
          textButtonI(
            width: asWidth(324),
            height: asHeight(52),
            radius: asHeight(8),
            backgroundColor: tm.mainBlue,
            onTap: (() {
              gv.setting.skinColor.value = _selectNum.value;
              Get.back();
              if (gv.setting.skinColor.value == 0) {
                SkinColorLightBlue().convertColor();
              } else if (gv.setting.skinColor.value == 1) {
                SkinColorLightDeepBlue().convertColor();
              } else if (gv.setting.skinColor.value == 2) {
                SkinColorDarkBlue().convertColor();
              } else if (gv.setting.skinColor.value == 3) {
                SkinColorDarkDeepBlue().convertColor();
              }
              gv.spMemory.write('skinColor', gv.setting.skinColor.value);

              // 화면 갱신 (열려있는 페이지는 모두 갱신)
              gv.control.refreshPageWhenSettingChange.value++;
              // 스킨 적용 방법
              // 모든 창을 닫고 다시 열여야 변경된 스킨이 반영 됨
              // [1] 화면을 모두 닫기 - 근육 위치 추적모듈관련 글로벌 키 중복때문에 1초 기다려야
              // 위 문제는 해결 못했으며 추후 다른 해결방법이 있는지 검토
              // [2] 대기 페이지 - 설정 - 일반설정 - 스킨 선택 창 차례로 열기
              // Get.offAll(() => const RestartSplash());
              // Future.delayed(const Duration(milliseconds: 1100), () {
              //   Get.to(() => const SettingMain());
              //   Future.delayed(const Duration(milliseconds: 10), () {
              //     Get.to(() => const SettingGeneral());
              //     Future.delayed(const Duration(milliseconds: 10), () {
              //       openBottomSheetBasic(
              //           isHeadView: true,
              //           headTitle: '스킨 컬러 선택',
              //           height: asHeight(430),
              //           child: _selectSkinColor(context));
              //     });
              //   });
              // });
            }),
            title: '적용',
            textColor: tm.fixedWhite,
            fontSize: tm.s16,
            fontWeight: FontWeight.bold,
            borderColor: Colors.transparent,
            borderLineWidth: asWidth(1),
          ),
          // asSizedBox(height: 20),
        ],
      ),
    );
  });
}

//==============================================================================
// 컬러 선택
//==============================================================================
Widget _skinColorBox({
  int index = 0,
  String title = '컬러 제목',
  Color textColor = Colors.black,
  Color pointBlue = Colors.blueAccent,
  Color mainBlue = Colors.blue,
  Color softBlue = const Color.fromARGB(255, 0xdc, 0xea, 0xff),
  Color mainGreen = const Color.fromARGB(255, 0x5f, 0xdc, 0x8c),
  Color backgroundColor = Colors.white,
  Color grey04 = Colors.grey,
  Color grey03 = Colors.grey,
  Color grey02 = Colors.grey,
  Color grey01 = Colors.grey,
  Function()? onTap,
}) {
  double opacity = 0;
  if (_selectNum.value == index) {
    opacity = 1;
  } else {
    opacity = 0.5;
  }
  return Stack(
    children: [
      //------------------------------------------------------------------------
      // 박스
      InkWell(
        onTap: onTap,
        child: Container(
          width: asWidth(140),
          height: asHeight(85),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: backgroundColor.withOpacity(opacity),
            border: _selectNum.value == index
                ? Border.all(color: tm.mainBlue.withOpacity(opacity), width: 1)
                : Border.all(color: tm.grey03.withOpacity(opacity), width: 1),
            borderRadius: BorderRadius.circular(asHeight(5)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  alignment: Alignment.center,
                  child: Center(
                      child: TextN(
                    title,
                    color: textColor,
                    fontSize: tm.s16,
                    fontWeight: FontWeight.w400,
                  )),
                ),
              ),
              Expanded(
                flex: 1,
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        color: pointBlue.withOpacity(opacity),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        color: mainBlue.withOpacity(opacity),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        color: softBlue.withOpacity(opacity),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        color: mainGreen.withOpacity(opacity),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        color: grey04.withOpacity(opacity),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        color: grey03.withOpacity(opacity),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        color: grey02.withOpacity(opacity),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        color: grey01.withOpacity(opacity),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      //------------------------------------------------------------------------
      // 선택
      Positioned(
        top: asHeight(10),
        right: asWidth(10),
        child: _selectNum.value == index
            ? Icon(
                Icons.check,
                size: asHeight(30),
                color: tm.mainBlue,
              )
            : Container(),
      ),
    ],
  );
}

//==============================================================================
// 저장된 모든 운동영상 삭제 바텀시트의 child 위젯
//==============================================================================
Widget deleteAllVideosBottomSheetContent() {
  return Container(
    padding:
        EdgeInsets.symmetric(horizontal: asWidth(18), vertical: asHeight(20)),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        asSizedBox(height: 20),
        Center(
            child: TextN(
          '운동 영상 삭제',
          color: tm.black,
          fontSize: tm.s20,
          fontWeight: FontWeight.w600,
        )),
        asSizedBox(height: 20),
        TextN(
          '기기에 저장된 운동 영상을 모두 삭제 하시겠습니까?',
          color: tm.grey04,
          fontSize: tm.s16,
        ),
        asSizedBox(height: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            textButtonI(
              width: asWidth(155),
              height: asHeight(52),
              radius: asHeight(8),
              textColor: tm.fixedWhite,
              backgroundColor: tm.mainBlue,
              onTap: () async {
                await gv.youtubeManager.deleteAllVideos();
                Get.back();
                openSnackBarBasic('운동 영상 삭제 완료', '모든 운동 영상이 삭제 되었습니다.');
              },
              title: '확인'.tr,
              fontSize: tm.s18,
              fontWeight: FontWeight.bold,
            ),
            textButtonI(
              width: asWidth(155),
              height: asHeight(52),
              radius: asHeight(8),
              textColor: tm.mainBlue,
              backgroundColor: tm.softBlue,
              onTap: () {
                Get.back();
              },
              title: '취소'.tr,
              fontSize: tm.s18,
              fontWeight: FontWeight.bold,
            ),
          ],
        ),
      ],
    ),
  );
}


//==============================================================================
// 모든 운동영상 다운로드 바텀시트의 child 위젯
//==============================================================================
Widget downloadAllVideosBottomSheetContent() {
  return Container(
    padding:
    EdgeInsets.symmetric(horizontal: asWidth(18), vertical: asHeight(20)),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        asSizedBox(height: 20),
        Center(
            child: TextN(
              '운동영상 다운로드',
              color: tm.black,
              fontSize: tm.s20,
              fontWeight: FontWeight.w600,
            )),
        asSizedBox(height: 20),
        TextN(
          '모든 운동 영상을 기기로 다운로드합니다. 파일 용량은 116MB입니다. 다운로드 하시겠습니까?\n(다운로드는 백그라운드에서 진행됩니다)',
          color: tm.grey04,
          fontSize: tm.s16,
        ),
        asSizedBox(height: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            textButtonI(
              width: asWidth(155),
              height: asHeight(52),
              radius: asHeight(8),
              textColor: tm.fixedWhite,
              backgroundColor: tm.mainBlue,
              onTap: () async {
                dvSetting.isVideoDownloading = true;
                Get.back(); //창 닫기
                for (int index = 0;
                index <
                    gv
                        .youtubeManager
                        .muscleTypeToExerciseList
                        .length;
                index++) {
                  await gv.youtubeManager.download(
                    muscleTypeIndex: index + 1,
                    onDone: () {},
                  );
                }
                dvSetting.isVideoDownloading = false;
                // gv.youtubeManager.download 메서드의 마지막 부분에 다운 받은 파일을 파악해서 downloadedVideoIds 변수를
                // 업데이트 하는 부분이 오래 걸리는지 downloadedVideoIds.length 값에 마지막에 다운로드한 파일 숫자가 포함이 안되있어서
                // delay를 추가하니 제대로 동작함
                await Future.delayed(
                    const Duration(milliseconds: 1000));
                openSnackBarBasic('운동영상 다운로드 완료', '모든 운동 영상을 다운로드 하였습니다.');
              },
              title: '확인'.tr,
              fontSize: tm.s18,
              fontWeight: FontWeight.bold,
            ),
            textButtonI(
              width: asWidth(155),
              height: asHeight(52),
              radius: asHeight(8),
              textColor: tm.mainBlue,
              backgroundColor: tm.softBlue,
              onTap: () {
                Get.back();
              },
              title: '취소'.tr,
              fontSize: tm.s18,
              fontWeight: FontWeight.bold,
            ),
          ],
        ),
      ],
    ),
  );
}

//==============================================================================
// 데이터 초기화
//==============================================================================
Widget dataInitializationBottomSheetContent() {
  return Container(
    padding:
        EdgeInsets.symmetric(horizontal: asWidth(18), vertical: asHeight(20)),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        asSizedBox(height: 20),
        Center(
            child: TextN(
          '데이터 초기화',
          color: tm.black,
          fontSize: tm.s20,
          fontWeight: FontWeight.w600,
        )),
        asSizedBox(height: 20),
        TextN(
          '정말 모든 데이터를 초기화 하시겠습니까?'
          ' 초기화를 하면 근육과 통계 기록이 모두 삭제되며 복구할 수 없습니다.',
          color: tm.grey04,
          fontSize: tm.s16,
        ),
        asSizedBox(height: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            textButtonI(
              width: asWidth(155),
              height: asHeight(52),
              radius: asHeight(8),
              textColor: tm.fixedWhite,
              backgroundColor: tm.mainBlue,
              onTap: () async {
                await systemDataInitialize();
                await removeImageFiles();
                await gv.control.updateIdxMuscle(
                    gv.control.idxMuscle.value); //0번 index 로 초기화
                await gv.control
                    .updateIdxRecord(gv.control.idxRecord.value); //관련 종속변수 갱신
                gvRecord.trendLinePointList =
                    <List<double>>[]; // 트랜드 라인 관련 변수 초기화
                await updateGraphData(
                    timePeriod: gvRecord.graphTimePeriod
                        .value); // 근육 데이터가 초기화 되었으므로 통계 그래프 데이터도 초기화
                Get.back(); //창 닫기
                // 화면 갱신 (열려있는 페이지는 모두 갱신)
                gv.control.refreshPageWhenSettingChange.value++;
                RefreshSetMuscle.all();
                openSnackBarBasic('데이터 초기화 완료', '모든 데이터가 초기화 되었습니다.');
              },
              title: '확인'.tr,
              fontSize: tm.s18,
              fontWeight: FontWeight.bold,
            ),
            textButtonI(
              width: asWidth(155),
              height: asHeight(52),
              radius: asHeight(8),
              textColor: tm.mainBlue,
              backgroundColor: tm.softBlue,
              onTap: () {
                Get.back();
              },
              title: '취소'.tr,
              fontSize: tm.s18,
              fontWeight: FontWeight.bold,
            ),
          ],
        ),
      ],
    ),
  );
}

//==============================================================================
// 시간 선택
//==============================================================================
class _SelectTouchTime extends StatefulWidget {
  const _SelectTouchTime({Key? key}) : super(key: key);

  @override
  State<_SelectTouchTime> createState() => _SelectTouchTimeState();
}

class _SelectTouchTimeState extends State<_SelectTouchTime> {
  // EmlDeviceNumber deviceNumber = EmlDeviceNumber.device1;

  int d = 0;
  late int selectedBtnIndex;

  @override
  void initState() {
    if (gv.deviceControl[d].touchTime == 15) {
      selectedBtnIndex = 0;
    }
    if (gv.deviceControl[d].touchTime == 30) {
      selectedBtnIndex = 1;
    }
    if (gv.deviceControl[d].touchTime == 50) {
      selectedBtnIndex = 2;
    }
    if (gv.deviceControl[d].touchTime == 101) {
      selectedBtnIndex = 3;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // return Container();
//   }
// }

// Widget selectTouchTime({required deviceNumber}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: asWidth(16)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          //---------------------------------------------------------
          // 설명 글
          asSizedBox(height: 20),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextN(
                  ('장비가 스마트폰과 무선 연결된 경우의 전원 버튼 꺼짐시간을 설정합니다.'
                      ' 기본 설정 값은 1.5초 입니다.'
                      ' 장비 부착 등 사용 과정에서 실수로 인한 전원꺼짐이 자주 발생하는 경우 시간을 길게 설정하세요.'),
                  fontSize: tm.s16,
                  color: tm.grey04),
              asSizedBox(height: 20),
              TextN(
                  ('(주의) 스마트폰과 무선 연결되지 않은 상황에서의 켜짐/꺼짐 시간은 항상 1.5초입니다.'
                      ' 측정 중에는 버튼을 눌러도 장비의 전원이 꺼지지 않습니다.'),
                  fontSize: tm.s16,
                  color: tm.grey04),
            ],
          ),
          asSizedBox(height: 40),
          //---------------------------------------------------------
          // 선택버튼
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // 1.5초
              textButtonSel(
                fontSize: tm.s16,
                title: '1.5 초',
                onTap: (() async {
                  if (selectedBtnIndex != 0) {
                    BleManager.setTouchTime(touchTime: 15);
                    await gv.spMemory
                        .write('touchTime', gv.deviceControl[d].touchTime);
                    setState(() {
                      selectedBtnIndex = 0;
                    });
                  }
                }),
                width: asWidth(78),
                height: asHeight(36),
                isSelected: selectedBtnIndex == 0,
              ),
              // 3초
              textButtonSel(
                fontSize: tm.s16,
                title: '3 초',
                onTap: (() async {
                  if (selectedBtnIndex != 1) {
                    BleManager.setTouchTime(touchTime: 30);
                    await gv.spMemory
                        .write('touchTime', gv.deviceControl[d].touchTime);
                    setState(() {
                      selectedBtnIndex = 1;
                    });
                  }
                }),
                width: asWidth(78),
                height: asHeight(36),
                isSelected: selectedBtnIndex == 1,
              ),
              // 5초
              textButtonSel(
                fontSize: tm.s16,
                title: '5 초',
                onTap: (() async {
                  if (selectedBtnIndex != 2) {
                    BleManager.setTouchTime(touchTime: 50);
                    await gv.spMemory
                        .write('touchTime', gv.deviceControl[d].touchTime);
                    setState(() {
                      selectedBtnIndex = 2;
                    });
                  }
                }),
                width: asWidth(78),
                height: asHeight(36),
                isSelected: selectedBtnIndex == 2,
              ),
              // Infinity
              textButtonSel(
                fontSize: tm.s16,
                title: '종료 안됨',
                onTap: (() async {
                  if (selectedBtnIndex != 3) {
                    BleManager.setTouchTime(touchTime: 101);
                    await gv.spMemory
                        .write('touchTime', gv.deviceControl[d].touchTime);
                    setState(() {
                      selectedBtnIndex = 3;
                    });
                  }
                }),
                width: asWidth(78),
                height: asHeight(36),
                isSelected: selectedBtnIndex == 3,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Widget _importDbFileConfirm(BuildContext context) {
//   return Container(
//     padding:
//         EdgeInsets.symmetric(horizontal: asWidth(18), vertical: asHeight(20)),
//     margin: const EdgeInsets.all(10),
//     decoration: BoxDecoration(
//         color: tm.white, borderRadius: BorderRadius.circular(asHeight(10))),
//     child: Column(
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         TextN(
//           '운동기록 데이터베이스 압축 파일을 불러올 수 있습니다.'
//           ' 불러오기를 실행하면 기존에 저장된 모든 데이터는 사라지니 주의하시기 바랍니다.',
//           color: tm.grey04,
//           fontSize: tm.s16,
//         ),
//         asSizedBox(height: 30),
//         textButtonBasic(
//           title: '불러올 파일 선택',
//           width: asWidth(300),
//           height: asHeight(40),
//           textColor: tm.blue,
//           borderColor: tm.blue.withOpacity(0.3),
//           onTap: (() async {
//             await importHiveFile();
//             Get.back();
//           }),
//         ),
//         // asSizedBox(height: 20),
//       ],
//     ),
//   );
// }
