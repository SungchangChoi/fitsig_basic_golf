
//==============================================================================
// dsp 관련 변수들 (주로 제어 변수)
//==============================================================================
import 'package:fitsig_basic_golf/F0_BASIC/common_import.dart';
class GvDsp {
  //----------------------------------------------------------------------------
  // 초기 값 관련
  //----------------------------------------------------------------------------
  // double default1RmRtInit = 1.0; // 실시간 1RM 측정 시작 값 (낮게 시작해야)

  //----------------------------------------------------------------------------
  // 필터 설정 관련
  //----------------------------------------------------------------------------
  List<EmlMlIirLpf> mlLpfFc = [
    EmlMlIirLpf.fc0_5,
    EmlMlIirLpf.fc0_7,
    EmlMlIirLpf.fc1,
    EmlMlIirLpf.fc2,
    EmlMlIirLpf.fc3,
    EmlMlIirLpf.fc4,
    EmlMlIirLpf.fc5
  ];

  List<EmlDcIirHpf> dcIirFc = [
    EmlDcIirHpf.fc0_1,
    EmlDcIirHpf.fc1,
    EmlDcIirHpf.fc3,
    EmlDcIirHpf.fc5,
    EmlDcIirHpf.fc10,
    EmlDcIirHpf.fc15,
    EmlDcIirHpf.fc20,
    EmlDcIirHpf.fc25,
    EmlDcIirHpf.fc30,
    EmlDcIirHpf.fc35,
    EmlDcIirHpf.fc40,
  ];

  //----------------------------------------------------------------------------
  // 블록 사이즈 관련
  //----------------------------------------------------------------------------
  // const List<int> mlWinSize = [250, 250, 500, 500];


}