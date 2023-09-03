//------------------------------------------------------------------------------
// flutter basic
//------------------------------------------------------------------------------
export 'package:flutter/material.dart';
export 'package:flutter/services.dart';
export 'package:flutter/foundation.dart';
export 'dart:async';
export "dart:typed_data";
export 'dart:math';
export 'dart:convert';
export 'package:get/get.dart'; //https://pub.dev/packages/get
export 'package:get_storage/get_storage.dart';
export 'package:hive_flutter/hive_flutter.dart';
export 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
export 'package:carousel_slider/carousel_slider.dart'; //슬라이드
//---------- json (아래 1개만 import 해야 에러가 없음)
export 'package:json_annotation/json_annotation.dart';
// export 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

//------------------------------------------------------------------------------
// 특수 공통 위젯
//------------------------------------------------------------------------------
export 'package:wakelock/wakelock.dart'; //화면 꺼짐 방지
export 'package:auto_size_text/auto_size_text.dart'; //글씨 크기 자동 조절

//------------------------------------------------------------------------------
// module
//------------------------------------------------------------------------------
export 'package:fs_lib/main.dart';
//export 'package:roem_ble/roem_ble_lib.dart'; // bleAdaptor module

//------------------------------------------------------------------------------
// F0 BASIC
//------------------------------------------------------------------------------
export '../F0_BASIC/THEME/theme_basic.dart';
export '../F0_BASIC/THEME/theme_light.dart';
export '../F0_BASIC/THEME/theme_dark.dart';

//------------------------------------------------------------------------------
// F1 DATA
//------------------------------------------------------------------------------
//--------------- database
// export '../F1_DATA/DB/db_manager_old.dart';
// export '../F1_DATA/DB/db_shared_preferences.dart';
export '../F1_DATA/DB_DATA/gv_db_muscle.dart';
export '../F1_DATA/DB_DATA/gv_db_record.dart';

//--------------- enum
export '../F1_DATA/ENUM/enum.dart';
export '../F1_DATA/ENUM/enum_setting.dart';

//--------------- language
export '../F1_DATA/LANGUAGE/translate.dart';
export '../F1_DATA/LANGUAGE/LanguageLocal.dart';

//--------------- variable
export '../F1_DATA/VARIABLE/gv.dart';
export '../F1_DATA/VARIABLE/gv_control.dart';
export '../F1_DATA/VARIABLE/gv_define.dart';
export '../F1_DATA/VARIABLE/gv_device_control.dart';
export '../F1_DATA/VARIABLE/gv_device_data.dart';
export '../F1_DATA/VARIABLE/gv_device_status.dart';
export '../F1_DATA/VARIABLE/gv_dsp.dart';
export '../F1_DATA/VARIABLE/gv_setting.dart';
export '../F1_DATA/VARIABLE/gv_system.dart';

//------------------------------------------------------------------------------
// F2 MANAGE
//------------------------------------------------------------------------------

//------------------------------------------------------------------------------
// F3 PROCESS
//------------------------------------------------------------------------------
export '../F3_PROCESS/EXCEPTION/bluetooth_disconnection.dart';
export '../F3_PROCESS/INIT/pre_init.dart';
export '../F3_PROCESS/INIT/app_init.dart';
export '../F3_PROCESS/INIT/db_init.dart';
export '../F3_PROCESS/INIT/sp_memory_init.dart';
export '../F3_PROCESS/TASK/task.dart';
export '../F3_PROCESS/TASK/bluetooth_monitoring.dart';
export '../F3_PROCESS/TASK/task_check_screen_size_change.dart';

//------------------------------------------------------------------------------
// F4 UTIL
//------------------------------------------------------------------------------
export '../F4_UTIL/API/api.dart';
export '../F4_UTIL/GENERAL/general.dart';
//------------------------------------------------------------------------------
// F5 MODULE_IF
//------------------------------------------------------------------------------
//--------------- bluetooth
export '../F5_MODULE/BLUETOOTH/ble_callback.dart';
export '../F5_MODULE/BLUETOOTH/ble_module_manager.dart';
export '../F5_MODULE/BLUETOOTH/ble_state_manager.dart';
export '../F5_MODULE/BLUETOOTH/fitsig_device_ack.dart';

//--------------- dsp
export '../F5_MODULE/EMG_DSP/dsp_control_basic.dart';
export '../F5_MODULE/EMG_DSP/dsp_module_manager.dart';
export '../F5_MODULE/EMG_DSP/dsp_callback.dart';
export 'package:fitsig_basic_golf/F5_MODULE/EMG_DSP/test_signal_generation.dart';


//------------------------------------------------------------------------------
// F6 WIDGET
//------------------------------------------------------------------------------
//--------------- animation
export '../F6_WIDGET/ANIMATION/ripple_circle.dart';
export '../F6_WIDGET/ANIMATION/ripple_circle_custom.dart';

//--------------- auto scale
export '../F6_WIDGET/AUTO_SCALE/auto_scale_basic.dart';

//--------------- bottom sheet
export '../F6_WIDGET/BOTTOM_SHEET/bottom_sheet_basic.dart';
export '../F6_WIDGET/BOTTOM_SHEET/bottom_sheet_help.dart';
export '../F6_WIDGET/BOTTOM_SHEET/bottom_sheet_basic_button.dart';

//--------------- button
export '../F6_WIDGET/BUTTON/general_button.dart';
export '../F6_WIDGET/BUTTON/text_button.dart';
export '../F6_WIDGET/BUTTON/icon_button.dart';

//--------------- chart live
export '../F6_WIDGET/CHART_LIVE/live_emg_bar.dart';
export '../F6_WIDGET/CHART_LIVE/live_aoe_bar.dart';
export '../F6_WIDGET/CHART_LIVE/live_emg_time_chart.dart';
export '../F6_WIDGET/CHART_LIVE/live_emg_time_chart_only_line.dart';

//--------------- chart static
export '../F6_WIDGET/CHART_STATIC/record_chart.dart';
export '../F6_WIDGET/CHART_STATIC/record_hilo_chart.dart';
export '../F6_WIDGET/CHART_STATIC/electrode_contact_quality_chart.dart';
export '../F6_WIDGET/CHART_STATIC/time_chart.dart';
export '../F6_WIDGET/CHART_STATIC/time_chart_simple.dart';

//--------------- icon
export '../F6_WIDGET/ICON/device_icon.dart';
export '../F6_WIDGET/ICON/help_icon.dart';

//--------------- indicator
export '../F6_WIDGET/INDICATOR/contact_status.dart';
export '../F6_WIDGET/INDICATOR/indicator_basic.dart';
export '../F6_WIDGET/INDICATOR/progress_bar.dart';

//--------------- layout
export '../F6_WIDGET/LAYOUT/divider.dart';
export '../F6_WIDGET/LAYOUT/slide.dart';

//--------------- popup
export '../F6_WIDGET/POPUP/popup_basic.dart';
export '../F6_WIDGET/POPUP/popup_basic_button.dart';
export '../F6_WIDGET/POPUP/popup_basic_vertical_button.dart';

//--------------- sound
export '../F6_WIDGET/SOUND/audio_manager.dart';

//--------------- spinner picker
export '../F6_WIDGET/SPINNER_PICKER/date_spinner_picker.dart';
export '../F6_WIDGET/SPINNER_PICKER/general_spinner_picker.dart';
export '../F6_WIDGET/SPINNER_PICKER/spinner_basic.dart';
export '../F6_WIDGET/SPINNER_PICKER/gender_spinner_picker.dart';
export '../F6_WIDGET/SPINNER_PICKER/born_year_spinner_picker.dart';

//--------------- text
export '../F6_WIDGET/TEXT/help_text_basic.dart';
export '../F6_WIDGET/TEXT/text_general.dart';
//--------------- video
export '../F6_WIDGET/VIDEO/video_basic.dart';
export '../F6_WIDGET/VIDEO/video_youtube.dart';
export '../F6_WIDGET/VIDEO/video_youtube_iframe.dart';
export '../F6_WIDGET/VIDEO/video_youtube_explode.dart';

//------------------------------------------------------------------------------
// F7 UI
//------------------------------------------------------------------------------
export '../F7_UI/P00_FRAME/top_bar.dart';
export '../F7_UI/P00_FRAME/bottom_button.dart';

//--------------- intro
export 'package:fitsig_basic_golf/F7_UI/P10_INTRO/dv_intro.dart';
export '../F7_UI/P10_INTRO/V00_intro_main.dart';
export '../F7_UI/P10_INTRO/V01_first_user.dart';
export '../F7_UI/P10_INTRO/V01_Z01_welcome.dart';
export '../F7_UI/P10_INTRO/V01_Z02_personal_information.dart';
// export '../F7_UI/P10_INTRO/V01_Z03_intro_video.dart';
export '../F7_UI/P10_INTRO/V02_intro_video.dart';
export '../F7_UI/P10_INTRO/V03_tutorial.dart';

//--------------- measure
export '../F7_UI/P20_MEASURE/dv_measure.dart';
export '../F7_UI/P20_MEASURE/df_measure.dart';
export '../F7_UI/P20_MEASURE/dw_measure.dart';
export '../F7_UI/P20_MEASURE/V00_measure_idle.dart';
export '../F7_UI/P20_MEASURE/V00_Z01_position_track.dart';
export '../F7_UI/P20_MEASURE/V00_Z02_status_icon.dart';
export '../F7_UI/P20_MEASURE/V00_Z03_muscle_guide.dart';
export '../F7_UI/P20_MEASURE/V01_measure_simple.dart';
export '../F7_UI/P20_MEASURE/V02_measure_detail.dart';
export '../F7_UI/P20_MEASURE/V02_Z01_heart_rate_display.dart';
export '../F7_UI/P20_MEASURE/V03_set_muscle.dart';
export '../F7_UI/P20_MEASURE/V03_Z01_muscle_name_text_field.dart';
export '../F7_UI/P20_MEASURE/V03_Z02_target_slider.dart';
export '../F7_UI/P20_MEASURE/V03_Z03_mvc_slider.dart';
export '../F7_UI/P20_MEASURE/V03_Z04_add_muscle.dart';
export '../F7_UI/P20_MEASURE/V04_measure_end.dart';
export '../F7_UI/P20_MEASURE/V00_Z04_camera.dart';
export '../F7_UI/P20_MEASURE/V00_Z04_Z01_camera_preview.dart';
export '../F7_UI/P20_MEASURE/V04_Z01_measure_quality.dart';
export '../F7_UI/P20_MEASURE/V04_Z02_measure_debug.dart';
export '../F7_UI/P20_MEASURE/V05_reorder_muscle.dart';

//--------------- record list/stats
export '../F7_UI/P30_RECORD/dw_record.dart';
export '../F7_UI/P30_RECORD/dv_record.dart';
export '../F7_UI/P30_RECORD/df_record.dart';
export '../F7_UI/P30_RECORD/V00_record_main.dart';
export '../F7_UI/P30_RECORD/V00_Z01_muscle_spinner_picker.dart';
export '../F7_UI/P30_RECORD/V01_record_list.dart';
export '../F7_UI/P30_RECORD/V01_Z01_record_delete.dart';
export '../F7_UI/P30_RECORD/V01_Z01_Z01_delete_advanced.dart';
export '../F7_UI/P30_RECORD/V01_Z02_report.dart';
export '../F7_UI/P30_RECORD/V01_Z03_list_scroll.dart';
export '../F7_UI/P30_RECORD/V02_record_stats.dart';
export '../F7_UI/P30_RECORD/V02_Z01_stats_graph.dart';

//--------------- setting
export '../F7_UI/P40_SETTING/dw_setting.dart';
export '../F7_UI/P40_SETTING/df_setting.dart';
export '../F7_UI/P40_SETTING/dv_setting.dart';
export '../F7_UI/P40_SETTING/V00_setting_main.dart';
export '../F7_UI/P40_SETTING/V01_setting_general.dart';
export '../F7_UI/P40_SETTING/V01_Z01_language_spinner_picker.dart';
export '../F7_UI/P40_SETTING/V01_Z02_progress_indicator_dialog.dart';
export '../F7_UI/P40_SETTING/V02_setting_exercise.dart';
export '../F7_UI/P40_SETTING/V02_Z01_start_mvc_slider.dart';
export '../F7_UI/P40_SETTING/V03_help_main.dart';
export '../F7_UI/P40_SETTING/V03_Z01_help_form.dart';
export '../F7_UI/P40_SETTING/V03_Z02_muscle_guide.dart';
export '../F7_UI/P40_SETTING/V03_Z02_Z02_contents.dart';
export '../F7_UI/P40_SETTING/V03_Z02_Z02_Z01_contents_muscles.dart';
export '../F7_UI/P40_SETTING/V03_Z02_Z02_Z02_guide_slide_image.dart';
export '../F7_UI/P40_SETTING/V03_Z02_Z01_option_select.dart';
export '../F7_UI/P40_SETTING/V04_terms_menu.dart';
export '../F7_UI/P40_SETTING/V04_Z01_terms_form.dart';
export '../F7_UI/P40_SETTING/V05_device_status.dart';
export '../F7_UI/P40_SETTING/V05_Z02_license.dart';
export '../F7_UI/P40_SETTING/V05_Z03_battery_test.dart';
export '../F7_UI/P40_SETTING/V06_suggestions.dart';
export '../F7_UI/P40_SETTING/V07_supervisor.dart';

//------------------------------------------------------------------------------
// F8 CONTENTS
//------------------------------------------------------------------------------
export '../F8_CONTENTS/HELP/H01_about_basic.dart';
export '../F8_CONTENTS/HELP/H02_about_app.dart';
export '../F8_CONTENTS/HELP/H03_device_instructions.dart';
export '../F8_CONTENTS/HELP/H10_program.dart';
export '../F8_CONTENTS/HELP/H11_exercise.dart';
export '../F8_CONTENTS/HELP/H20_emg.dart';
export '../F8_CONTENTS/HELP/H21_ecg.dart';
export '../F8_CONTENTS/HELP/H32_frequency.dart';
export '../F8_CONTENTS/HELP/H30_1rm.dart';
export '../F8_CONTENTS/HELP/H31_aoe.dart';
export '../F8_CONTENTS/HELP/H40_patch_electrode.dart';
export '../F8_CONTENTS/TERMS/terms.dart';
export '../F8_CONTENTS/TERMS/personal_information.dart';
export '../F8_CONTENTS/TERMS/policy.dart';

//------------------------------------------------------------------------------
// FF DEBUG
//------------------------------------------------------------------------------
