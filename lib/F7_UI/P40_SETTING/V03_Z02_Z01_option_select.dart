import 'package:fitsig_basic_golf/F0_BASIC/common_import.dart';

//==============================================================================
// 옵션 선택 창
//==============================================================================

class GuideOptionSelect extends StatefulWidget {
  final Function() callbackOption;

  const GuideOptionSelect({
    required this.callbackOption,
    Key? key,
  }) : super(key: key);

  @override
  State<GuideOptionSelect> createState() => _GuideOptionSelectState();
}

class _GuideOptionSelectState extends State<GuideOptionSelect> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        asSizedBox(height: 10),
        modeSelect(),
        asSizedBox(height: 20),
        optionSelect(callbackOption: widget.callbackOption),
      ],
    );
  }

  ///---------------------------------------------------------------------------
  /// 모드 선택
  ///---------------------------------------------------------------------------
  Widget modeSelect() {
    return Container(
      height: asHeight(50),
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: asWidth(15)),
      child: Container(
        height: asHeight(30),
        alignment: Alignment.center,
        child: TextN(
          '좌/우',
          fontSize: tm.s14,
          color: tm.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  ///---------------------------------------------------------------------------
  /// 옵션 선택
  ///---------------------------------------------------------------------------
  Widget optionSelect({
    required Function() callbackOption,
  }) {
    List<String> itemDirection = const ['좌', '우'];
    List<String> itemGuide = const ['부착위치 가이드', '부착사진', '관련 운동'];
    double width = asWidth(360);
    double height = asHeight(140);

    return SizedBox(
      width: width,
      height: height,
      child: Column(
        children: [
          //----------------------------------------------------------------------
          // ListView
          //----------------------------------------------------------------------
          Expanded(
            child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: itemDirection.length,
                itemBuilder: (BuildContext context, int index) {
                  return Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: (() {
                        // 좌우 옵션
                        if (index == 0) {
                          dvSetting.isViewLeft = true;
                        } else {
                          dvSetting.isViewLeft = false;
                        }
                        callbackOption(); //화면 갱신을 위한 callback
                        setState(() {});
                        // 아래와 같이 하면 기존에 생성한 모든 instance 가 갱신되는 것인가?
                        // 동작은 하는데 조금 혼동스러움
                        MuscleGuideSlide()
                            .refreshCarouseSlideWithIndicator(); // 슬라이드 화면 갱신
                        Get.back(); //선택 후 창 닫기
                      }),
                      child: Container(
                        width: width,
                        height: asHeight(54),
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(horizontal: asWidth(18)),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom:
                                    BorderSide(color: tm.grey01, width: 1))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            //--------------------------------------------------
                            // 글씨
                            //--------------------------------------------------
                            TextN(
                              itemDirection[index],
                              fontSize: tm.s16,
                              color: _color(index),
                            ),
                            //--------------------------------------------------
                            // 체크 표시 (선택된 경우에만)
                            //--------------------------------------------------
                            if (_color(index) == tm.mainBlue)
                              Image.asset(
                                'assets/icons/ic_check.png',
                                height: asHeight(12),
                                color: tm.mainBlue,
                              ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }

  ///---------------------------------------------------------------------------
  /// color
  ///---------------------------------------------------------------------------
  Color _color(int index) {
    Color color = Colors.black;
    //--------------------------------------------------------------------------
    // 좌우 선택
    //--------------------------------------------------------------------------
    color = (dvSetting.isViewLeft == true && index == 0) ||
        (dvSetting.isViewLeft == false && index == 1)
        ? tm.mainBlue
        : tm.grey03;
    return color;
  }
}
