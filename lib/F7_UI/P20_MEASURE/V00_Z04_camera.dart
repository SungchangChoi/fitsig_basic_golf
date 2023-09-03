import 'package:fitsig_basic_golf/F0_BASIC/common_import.dart';
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({Key? key, required this.cameras}) : super(key: key);

  final List<CameraDescription>? cameras;

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  late CameraController _cameraController;
  bool _isRearCameraSelected = true;

  @override
  void dispose() {
    _cameraController.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    initCamera(widget.cameras![0]);
  }

  Future initCamera(CameraDescription cameraDescription) async {
    _cameraController = CameraController(
      cameraDescription,
      ResolutionPreset.veryHigh,
      enableAudio: false,
      imageFormatGroup: ImageFormatGroup.jpeg,
    );
    try {
      await _cameraController.initialize().then((_) {
        if (!mounted) return;
        setState(() {});
      });
    } on CameraException catch (e) {
      debugPrint("camera error $e");
    }
  }

  Future takePicture() async {
    if (!_cameraController.value.isInitialized) {
      return null;
    }
    if (_cameraController.value.isTakingPicture) {
      return null;
    }
    try {
      await _cameraController.setFlashMode(FlashMode.off);
      XFile picture = await _cameraController.takePicture();
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PreviewPage(
            pictureFile: picture,
            mode: ViewMode.modify,
          ),
        ),
      );
    } on CameraException catch (e) {
      debugPrint('Error occurred while taking picture: $e');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    // print(
    //     'V05_camera :: MediaQuery ratio=${MediaQuery.of(context).size.height / MediaQuery.of(context).size.width}');
    // print('V05_camera :: full 사진 ratio=${4208 / 2632}');
    // print('V05_camera :: 16:9 사진 ratio=${4208 / 2368}');
    // print('V05_camera :: 4:3 사진 ratio=${4208 / 3120}'); // 카메라 모듈에서 찍는건 4:3 인듯.
    // print('V05_camera :: 1:1 사진 ratio=${3120 / 3120}');

    return Scaffold(
        // appBar: AppBar(title: const Text('Camera Page'), backgroundColor: tm.blue,),
        body: SafeArea(
      child: Stack(children: [
        (_cameraController.value.isInitialized)
            ? Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                color: Colors.black,
                alignment: Alignment.center,
                child: CameraPreview(_cameraController),
                // ),
              )
            : Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                color: Colors.black,
                child: Center(
                  child:
                      // CircularProgressIndicator()
                      FittedBoxN(
                    fit: BoxFit.scaleDown,
                    child: Image.asset(
                      'assets/icons/spin_loading.gif',
                    ),
                  ),
                )),
        Align(
          alignment: Alignment.topCenter,
          child: Container(
            height: MediaQuery.of(context).size.height * 0.19,
            decoration: BoxDecoration(
                // borderRadius:
                //  const BorderRadius.vertical(top: Radius.circular(24)),
                color: Colors.black.withOpacity(0.4)),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: MediaQuery.of(context).size.height * 0.19,
            decoration: BoxDecoration(
                // borderRadius:
                //      const BorderRadius.vertical(top: Radius.circular(24)),
                color: Colors.black.withOpacity(0.4)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  padding: EdgeInsets.zero,
                  iconSize: 30,
                  icon: Icon(
                      _isRearCameraSelected
                          ? CupertinoIcons.switch_camera
                          : CupertinoIcons.switch_camera_solid,
                      color: tm.fixedWhite),
                  onPressed: () {
                    setState(
                        () => _isRearCameraSelected = !_isRearCameraSelected);
                    initCamera(widget.cameras![_isRearCameraSelected ? 0 : 1]);
                  },
                ),
                IconButton(
                  onPressed: takePicture,
                  iconSize: tm.s67,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  icon: Icon(Icons.circle, color: tm.fixedWhite),
                ),
                TextButton(
                  child: TextN(
                    '닫기',
                    color: tm.white,
                    fontSize: tm.s20,
                    fontWeight: FontWeight.bold,
                  ),
                  onPressed: () {
                    Get.back();
                  },
                ),
              ],
            ),
          ),
        ),
      ]),
    ));
  }
}
