import '/F0_BASIC/common_import.dart';

/// 업데이트 진행바
class UpdateProgressBar extends StatelessWidget {
  final double value;
  const UpdateProgressBar({Key? key, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(4.0),
        child: Stack(
          children: [
            SizedBox(
              width: double.infinity,
              height: tm.s18,
              child: LinearProgressIndicator(
                value: value,
                backgroundColor: tm.grey01,
              ),
            ),
            SizedBox(
              height: tm.s18,
              child: Center(
                child: Text(
                  '${(value * 100).floor()} %',
                  style: TextStyle(color: tm.white, fontSize: tm.s14),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
