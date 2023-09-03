import '/F0_BASIC/common_import.dart';
import 'package:http/http.dart' as http;

//==============================================================================
// setting main
//==============================================================================

class SuggestionPage extends StatelessWidget {
  const SuggestionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var textController = TextEditingController(text: '');
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Material(
          color: tm.white,
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //----------------------------------------------------------------
                // 상단 바
                topBarBack(context, title: '고객센터'),
                asSizedBox(height: 16),
                //----------------------------------------------------------------
                // 하단 내용
                Container(
                  padding: EdgeInsets.symmetric(horizontal: asWidth(18)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //----------------------------------------------------------
                      // 개선사항 건의
                      //----------------------------------------------------------
                      textTitleBig('제품 개선 사항 건의'.tr),
                      // asSizedBox(height: 10),
                      textNormal('고객님의 의견은 더 좋은 제품 개발에 큰 도움이 됩니다.'
                          ' 본 건의사항에 대해서는 별도로 답변을 드리지 않습니다.'),
                      asSizedBox(height: 20),
                      //----------------------------------------------------------
                      // 텍스트 입력 창
                      Center(
                        child: Container(
                          width: asWidth(324),
                          height: asHeight(160),
                          padding: EdgeInsets.symmetric(
                              vertical: asHeight(12), horizontal: asWidth(14)),
                          decoration: BoxDecoration(
                              border: Border.all(color: tm.grey02),
                              borderRadius: BorderRadius.circular(10)),
                          child: TextFormField(
                            maxLines: null,
                            style: TextStyle(fontSize: tm.s14, color: tm.black),
                            // textAlignVertical: TextAlignVertical.center,
                            cursorColor: tm.mainBlue,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: tm.white,
                              hintText: '건의사항을 입력해주세요',
                              labelStyle:
                                  TextStyle(color: tm.black, fontSize: tm.s16),
                              focusedBorder: InputBorder.none,
                              //밑 줄 없애기
                              border: InputBorder.none,
                            ),
                            keyboardType: TextInputType.multiline,
                            //.emailAddress,
                            controller: textController,
                            onChanged: (text) {
                              gv.setting.textLength.value = text.length;
                            },
                          ),
                        ),
                      ),
                      asSizedBox(height: 20),
                      //----------------------------------------------------------
                      // 보내기 버튼
                      Obx(
                        () => textButtonI(
                          width: asWidth(324),
                          height: asHeight(52),
                          radius: asHeight(8),
                          backgroundColor: (gv.setting.textLength.value >= 10 &&
                                  gv.setting.cntSuggestionTransfer.value <= 10)
                              ? tm.mainBlue
                              : tm.grey03,
                          onTap: (() async {
                            //------------------------------------------------
                            // 10글자 이상이라면
                            // 하루에 10회 이하로 고객 의견을 고객 의견을 보냈다면...
                            // print(textController.text);
                            if (gv.setting.textLength.value >= 10 &&
                                gv.setting.cntSuggestionTransfer.value <= 10) {
                              //----------------------------------------------
                              // 고객 의견 API 전송
                              Map<String, String> body = {
                                'feed_age': gv.setting.bornYearApi(
                                    gv.setting.bornYearIndex.value),
                                // 연령대 : '1950' ~ '2020'
                                // 1950 : 1950 이전을 뜻함
                                // 1960 : 1951 ~ 1960
                                'feed_sex': gv.setting
                                    .genderApi(gv.setting.genderIndex.value),
                                //성별 : 'male', 'female', 'etc'
                                'feed_text': textController.text, //고객 의견
                              };
                              Map<String, String> ackMap = await apiPost(
                                  subUrl: 'insert/feedback', body: body);
                              //----------------------------------------------
                              // 성공 메시지

                              if (ackMap['response'] == 's') {
                                gv.setting.cntSuggestionTransfer.value++;
                                gv.spMemory.write('cntSuggestionTransfer',
                                    gv.setting.cntSuggestionTransfer.value);
                                openSnackBarBasic(
                                    '보내기 성공', '고객님의 의견이 전송되었습니다.');
                              } else {
                                openSnackBarBasic('보내기 실패',
                                    '메시지를 전송하지 못했습니다.\n데이터 통신이 가능한 상태인지 확인해 주시기 바랍니다.');
                              }

                              // textController.clear();
                            }
                            //------------------------------------------------
                            // 10글자 이하라면
                            else if (textController.text.length < 10) {
                              openSnackBarBasic(
                                  '보내기 실패', '최소 10자 이상의 의견을 적어주세요.');
                            }
                            //------------------------------------------------
                            // 하루에 10회 초과하여 의견을 보냈다면
                            else {
                              openSnackBarBasic(
                                  '보내기 실패', '고객의견 전송 횟수는 1일 10회로 제한됩니다.');
                            }
                          }),
                          title: '등록하기',
                          fontSize: tm.s18,
                          textColor: tm.fixedWhite,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      //   children: [
                      //     textButtonG(
                      //         width: asWidth(120),
                      //         height: asHeight(40),
                      //         title: '돌아가기',
                      //         onTap: (() {
                      //           Get.back();
                      //         })),
                      //     textButtonG(
                      //         width: asWidth(120),
                      //         height: asHeight(40),
                      //         title: '보내기',
                      //         onTap: (() async {
                      //           //------------------------------------------------
                      //           // 10글자 이상이라면
                      //           // 하루에 10회 이하로 고객 의견을 고객 의견을 보냈다면...
                      //           // print(textController.text);
                      //           if (textController.text.length >= 10 &&
                      //               gv.setting.cntSuggestionTransfer <= 10) {
                      //             //----------------------------------------------
                      //             // 고객 의견 API 전송
                      //
                      //             Map<String, String> body = {
                      //               'feed_age': gv.setting.bornYearApi(
                      //                   gv.setting.bornYearIndex.value),
                      //               // 연령대 : '1950' ~ '2020'
                      //               // 1950 : 1950 이전을 뜻함
                      //               // 1960 : 1951 ~ 1960
                      //               'feed_sex': gv.setting
                      //                   .genderApi(gv.setting.genderIndex.value),
                      //               //성별 : 'male', 'female', 'etc'
                      //               'feed_text': textController.text, //고객 의견
                      //             };
                      //             Map<String, String> ackMap = await apiPost(
                      //                 subUrl: 'insert/feedback', body: body);
                      //             //----------------------------------------------
                      //             // 성공 메시지
                      //
                      //             if (ackMap['response'] == 's') {
                      //               gv.setting.cntSuggestionTransfer++;
                      //               gv.spMemory.write('cntSuggestionTransfer',
                      //                   gv.setting.cntSuggestionTransfer);
                      //               openSnackBarBasic(
                      //                   '보내기 성공', '고객님의 의견이 전송되었습니다.');
                      //             } else {
                      //               openSnackBarBasic('보내기 실패',
                      //                   '메시지를 전송하지 못했습니다.\n데이터 통신이 가능한 상태인지 확인해 주시기 바랍니다.');
                      //             }
                      //
                      //             // textController.clear();
                      //           }
                      //           //------------------------------------------------
                      //           // 10글자 이하라면
                      //           else if (textController.text.length < 10) {
                      //             openSnackBarBasic(
                      //                 '보내기 실패', '최소 10자 이상의 의견을 적어주세요.');
                      //           }
                      //           //------------------------------------------------
                      //           // 하루에 10회 초과하여 의견을 보냈다면
                      //           else {
                      //             openSnackBarBasic(
                      //                 '보내기 실패', '고객의견 전송 횟수는 1일 10회로 제한됩니다.');
                      //           }
                      //         })),
                      //   ],
                      // ),
                      asSizedBox(height: 20),
                    ],
                  ),
                ),
                dividerBig(),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: asWidth(18)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      asSizedBox(height: 10),
                      //----------------------------------------------------------
                      // AS
                      //----------------------------------------------------------
                      textTitleBig('핏시그 고객센터'.tr),
                      textNormal('채팅상담을 이용하시면 더 빠르고 정확한 서비스를 받으실 수 있습니다.'),
                      asSizedBox(height: 15),

                      Row(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Image.asset(
                                'assets/icons/sns_naver.png',
                                fit: BoxFit.scaleDown,
                                height: asHeight(18),
                              ),
                              asSizedBox(width: 6),
                              TextN(
                                '네이버 톡톡',
                                fontSize: tm.s12,
                                color: tm.grey04,
                                fontWeight: FontWeight.bold,
                              ),
                            ],
                          ),
                          asSizedBox(width: 30),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Image.asset(
                                'assets/icons/sns_kakao.png',
                                fit: BoxFit.scaleDown,
                                height: asHeight(18),
                              ),
                              asSizedBox(width: 6),
                              TextN(
                                '카카오 채널',
                                fontSize: tm.s12,
                                color: tm.grey04,
                                fontWeight: FontWeight.bold,
                              ),
                            ],
                          ),
                        ],
                      ),
                      asSizedBox(height: 12),
                      Container(
                        width: asWidth(324),
                        height: asHeight(44),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: tm.grey02),
                        padding: EdgeInsets.symmetric(
                            horizontal: asWidth(20), vertical: asHeight(10)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextN(
                              '핏시그',
                              fontSize: tm.s16,
                              fontWeight: FontWeight.bold,
                              color: tm.black,
                            ),
                            Image.asset(
                              'assets/icons/ic_search.png',
                              fit: BoxFit.scaleDown,
                              height: asHeight(24),
                            ),
                          ],
                        ),
                      ),
                      asSizedBox(height: 10),
                      TextN(
                        '* 카카오톡 채널, 네이버 톡톡에서 [핏시그] 검색 후 채팅',
                        fontSize: tm.s12,
                        fontWeight: FontWeight.normal,
                        color: tm.black,
                      ),
                    ],
                  ),
                )
              ],
            ),
          )),
    );
  }
}
