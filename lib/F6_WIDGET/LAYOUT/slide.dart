import '/F0_BASIC/common_import.dart';

//==============================================================================
// slide basic
//==============================================================================
Widget slideBasic(
    {double width = 200,
    double height = 400,
    bool autoPlay = true,
    int durationSec = 5,
    bool enlargeCenterPage = false,
    double enlargeFactor = 0,
    double viewportFraction = 1,
    List<Widget> items = const []}) {
  return SizedBox(
    width: width,
    child: CarouselSlider(
        // carouselController: CarouselController,
        options: CarouselOptions(
          height: height,
          autoPlay: autoPlay,
          autoPlayInterval: Duration(seconds: durationSec),
          enlargeCenterPage: enlargeCenterPage,
          enlargeFactor: enlargeFactor,
          viewportFraction: viewportFraction,
          //0.5 * GvDef.widthMax / width,
          //0.9
          // aspectRatio: 16 / 9,
          //10.0,
          initialPage: 1,
          scrollDirection: Axis.horizontal,
        ),
        items: items
        // [
        //   _imageBox('제품 3개 1.jpg'),
        //   _imageBox('제품 3개 2.jpg'),
        //   _imageBox('제품 3개 3.jpg'),
        //   _imageBox('제품 3개 4.jpg'),
        //   _imageBox('제품 3개 5.jpg'),
        // ],
        ),
  );
}

//==============================================================================
// 갱신을 위한 위젯
// 갱신 함수를 실행할 때 매번 클래스를 생성해서 갱신해도 전체가 갱신 되는 듯....
// 코드가 깔끔하지 않으므로 체크 필요
//==============================================================================
class MuscleGuideSlide {
  final GlobalKey<_CarouseSlideWithIndicatorState>
      _keyCarouseSlideWithIndicatorState = GlobalKey();

  Widget carouseSlideWithIndicator(
      {double width = 200,
      double height = 400,
      bool autoPlay = true,
      int durationSec = 5,
      bool enlargeCenterPage = false,
      double enlargeFactor = 0,
      double viewportFraction = 1,
      List<Widget> items = const []}) {
    return CarouseSlideWithIndicator(
      key: _keyCarouseSlideWithIndicatorState,
      width: width,
      height: height,
      durationSec: durationSec,
      enlargeCenterPage: enlargeCenterPage,
      enlargeFactor: enlargeFactor,
      //넓이에 맞추어 변화
      viewportFraction: viewportFraction,
      autoPlay: autoPlay,
      items: items,
    );
  }

  //---------------------------------------------------------------------------
  // 화면 갱신용 함수
  //---------------------------------------------------------------------------
  void refreshCarouseSlideWithIndicator() {
    _keyCarouseSlideWithIndicatorState.currentState?.refresh();
  }
}

//==============================================================================
// slide basic
//==============================================================================
class CarouseSlideWithIndicator extends StatefulWidget {
  final double width; // = 200;
  final double height;
  final bool autoPlay;
  final int durationSec;
  final bool enlargeCenterPage;

  final double enlargeFactor;

  final double viewportFraction;
  final List<Widget> items; // = const [];

  const CarouseSlideWithIndicator(
      {this.width = 300,
      this.height = 300,
      this.autoPlay = false,
      this.durationSec = 5,
      this.enlargeCenterPage = false,
      this.enlargeFactor = 1,
      this.viewportFraction = 1,
      this.items = const [],
      Key? key})
      : super(key: key);

  @override
  State<CarouseSlideWithIndicator> createState() =>
      _CarouseSlideWithIndicatorState();
}

class _CarouseSlideWithIndicatorState extends State<CarouseSlideWithIndicator> {
  int _current = 0;
  final CarouselController _controller = CarouselController();

  @override
  void initState() {
    _current = 0;
    //
    // _controller.onReady == true ?
    // _controller.jumpToPage(0);
    setState(() {});
    super.initState();
  }

  @override
  void dispose() {
    // _controller..dispose();
    super.dispose();
  }

  refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        //----------------------------------------------------------------------
        // slide
        //----------------------------------------------------------------------
        CarouselSlider(
            carouselController: _controller,
            options: CarouselOptions(
                height: widget.height,
                autoPlay: widget.autoPlay,
                autoPlayInterval: Duration(seconds: widget.durationSec),
                enlargeCenterPage: widget.enlargeCenterPage,
                enlargeFactor: widget.enlargeFactor,
                viewportFraction: widget.viewportFraction,
                initialPage: 0,
                scrollDirection: Axis.horizontal,
                enableInfiniteScroll: false,
                onPageChanged: (index, reason) {
                  setState(() {
                    _current = index;
                  });
                }),
            items: widget.items),
        //----------------------------------------------------------------------
        // 현재위치 및 점 표시
        //----------------------------------------------------------------------
        SizedBox(
            width: widget.width,
            height: widget.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //--------------------------------------------------------------
                // 현재 위치
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                        height: asHeight(28),
                        padding: EdgeInsets.symmetric(horizontal: asWidth(9)),
                        margin: EdgeInsets.only(
                            top: asHeight(18), right: asWidth(18)),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(asHeight(10)),
                            color: tm.fixedBlack.withOpacity(0.3)),
                        child: TextN(
                          '${_current + 1}/${widget.items.length}',
                          fontSize: tm.s12,
                          color: tm.fixedWhite,
                        )),
                  ],
                ),
                //--------------------------------------------------------------
                // 점 표시
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: widget.items.asMap().entries.map((entry) {
                    return GestureDetector(
                      onTap: () => _controller.animateToPage(entry.key),
                      child: Container(
                        width: asHeight(8),
                        height: asHeight(8),
                        margin: EdgeInsets.symmetric(
                            vertical: asHeight(12), horizontal: asWidth(3)),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: tm.fixedBlack.withOpacity(
                                _current == entry.key ? 0.9 : 0.2)),
                      ),
                    );
                  }).toList(),
                ),
              ],
            )),
      ],
    );
  }
}
