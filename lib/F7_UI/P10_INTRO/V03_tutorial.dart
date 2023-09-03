import '/F0_BASIC/common_import.dart';

//==============================================================================
// 접촉상태
//==============================================================================

// if (gvIntro.isViewTutorialContactQuality.value == true ||
// gvIntro.isViewTutorialBtConnect.value == true ||
// gvIntro.isViewTutorialCamera.value == true)

Widget tutorialMessage() {
  return Material(
    color: tm.black.withOpacity(0.1),
    child: InkWell(
      onTap: (() {
        dvIntro.cntIsViewTutorial--;
      }),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              //------------------------------------
              // top bar 영역
              SizedBox(height: asHeight(40)),
              //----------------------------------------------------------------
              // 장비 연결
              //----------------------------------------------------------------
              if (dvIntro.cntIsViewTutorial.value == 4)
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Image.asset(
                              'assets/icons/말풍선 꼭지.png',
                              color: tm.pointOrange,
                              height: asHeight(12),
                            ),
                            asSizedBox(width: 20),
                          ],
                        ),
                        Container(
                          height: asHeight(36),
                          padding:
                              EdgeInsets.symmetric(horizontal: asWidth(10)),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(asHeight(18)),
                            color: tm.pointOrange,
                          ),
                          child: TextN(
                            '장비 연결하기',
                            color: tm.white,
                            fontSize: tm.s14,
                          ),
                        ),
                      ],
                    ),
                    asSizedBox(width: 10),
                  ],
                ),
              //----------------------------------------------------------------
              // 전극 접촉 품질
              //----------------------------------------------------------------
              if (dvIntro.cntIsViewTutorial.value == 3)
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Image.asset(
                              'assets/icons/말풍선 꼭지.png',
                              color: tm.grey04,
                              height: asHeight(12),
                            ),
                            asSizedBox(width: 30),
                          ],
                        ),
                        Container(
                          height: asHeight(36),
                          padding:
                              EdgeInsets.symmetric(horizontal: asWidth(10)),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(asHeight(18)),
                            color: tm.grey04,
                          ),
                          child: TextN(
                            '전극-피부 접촉 상태를 알려줍니다!',
                            color: tm.white,
                            fontSize: tm.s14,
                          ),
                        ),
                      ],
                    ),
                    asSizedBox(width: 30),
                  ],
                ),
              //----------------------------------------------------------------
              // 전극 접촉 품질
              //----------------------------------------------------------------
              if (dvIntro.cntIsViewTutorial.value == 2)
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    asSizedBox(width: 30),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            asSizedBox(width: 56),
                            Transform(
                              alignment: Alignment.center,
                              transform: Matrix4.rotationY(pi),
                              child: Image.asset(
                                'assets/icons/말풍선 꼭지.png',
                                color: tm.grey04,
                                height: asHeight(12),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          height: asHeight(36),
                          padding:
                              EdgeInsets.symmetric(horizontal: asWidth(10)),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(asHeight(18)),
                            color: tm.grey04,
                          ),
                          child: TextN(
                            '전극 부착 위치를 기록하세요!',
                            color: tm.white,
                            fontSize: tm.s14,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              //----------------------------------------------------------------
              // 전극 접촉 품질
              //----------------------------------------------------------------
              if (dvIntro.cntIsViewTutorial.value == 1)
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    asSizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            asSizedBox(width: 26),
                            Transform(
                              alignment: Alignment.center,
                              transform: Matrix4.rotationY(pi),
                              child: Image.asset(
                                'assets/icons/말풍선 꼭지.png',
                                color: tm.grey04,
                                height: asHeight(12),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          height: asHeight(36),
                          padding:
                          EdgeInsets.symmetric(horizontal: asWidth(10)),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(asHeight(18)),
                            color: tm.grey04,
                          ),
                          child: TextN(
                            '설정-도움말에서 자세한 사용법을 확인하세요.',
                            color: tm.white,
                            fontSize: tm.s14,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
            ],
          ),
          Expanded(
            child: Container(
              width: asWidth(360),
              height: asHeight(700),
              color: tm.black.withOpacity(0.95),
              alignment: Alignment.center,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: asWidth(20), vertical: asHeight(5)),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(asHeight(50)),
                  border: Border.all(
                    color: tm.white.withOpacity(0.3),
                    width: 3,
                  )
                ),
                child: RichText(
                  text: TextSpan(
                      text: 'TIP ${5 - dvIntro.cntIsViewTutorial.value}',
                      style: TextStyle(
                        fontSize: tm.s40,
                        fontWeight: FontWeight.bold,
                        color: tm.white.withOpacity(0.8),
                      ),
                      children: [
                        TextSpan(
                            text: ' / 4',
                            style: TextStyle(
                              fontSize: tm.s20,
                              color: tm.white.withOpacity(0.4),
                            ))
                      ]),
                ),
              ),
            ),
          )
        ],
      ),
    ),
  );
}


Widget showConnectionButtonBubble() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.end,
    children: [
      //------------------------------------
      // top bar 영역
      SizedBox(height: asHeight(40)),
      //----------------------------------------------------------------
      // 장비 연결
      //----------------------------------------------------------------
        Padding(
          padding: EdgeInsets.symmetric(horizontal: asWidth(10)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Image.asset(
                    'assets/icons/말풍선 꼭지.png',
                    color: tm.pointOrange,
                    height: asHeight(12),
                  ),
                  asSizedBox(width: 20),
                ],
              ),
              Container(
                height: asHeight(50),
                width: asWidth(190),
                padding:
                EdgeInsets.symmetric(horizontal: asWidth(10)),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(asHeight(18)),
                  color: tm.pointOrange,
                ),
                child: TextN(
                  '장비와 무선 연결 또는 해제를 하려면 이 아이콘을 클릭하세요',
                  color: tm.white,
                  fontSize: tm.s14,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
        asSizedBox(width: 10),
    ],
  );
}