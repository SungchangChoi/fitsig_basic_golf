import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import '/F0_BASIC/common_import.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'dart:math';

//==============================================================================
// 유튜브 메니저 (youtube_explode_dart 패키지를 이용해서 유튜브 영상 다운로드 및 관리하는 클래스)
//==============================================================================
class YoutubeManager {
  YoutubeExplode yt = YoutubeExplode();
  late Future<StreamManifest> manifest;
  late String videoDirectoryPath;
  List<String> downloadedVideoIds = <String>[];  // 로컬에 다운로드된 영상의 ID 리스트
  int localVideosSize = 0;
  int totalNumberOfVideo = 0; // 유튜브에서 있는 모든 영상 수

  // 근육 부위 리스트
  List<List<String>> muscleTypeToExerciseList = [
    m01WristFlexorExerciseList,
    m02WristExtensorExerciseList,
    m03BicepsExerciseList,
    m04TricepsExerciseList,
    m05FrontDeltoidExerciseList,
    m06MiddleDeltoidExerciseList,
    m07BackDeltoidExerciseList,
    m08ExternalRotatorExerciseList,
    m09ExternalRotatorExerciseList,
    m10UpperPectoralisExerciseList,
    m11MiddlePectoralisExerciseList,
    m12LowerPectoralisExerciseList,
    m13SerratusAnteriorExerciseList,
    m14RectusAbdominalExerciseList,
    m15ExternalObliqueAbdominalExerciseList,
    m16UpperTrapeziusExerciseList,
    m17MiddleTrapeziusExerciseList,
    m18LowerTrapeziusExerciseList,
    m19LatissimusDorsiExerciseList,
    m20ErectorSpinaeExerciseList,
    m21GluteusMaximusExerciseList,
    m22GluteusMediusExerciseList,
    m23QuadricepsFemorisExerciseList,
    m24HamstringsExerciseList,
    m25AdductorExerciseList,
    m26TibialisAnteriorExerciseList,
    m27GastrocnemiusExerciseList,
  ];

  // 근육 부위별 운동영상 크기 총합, 단위는 MB
  List<double> muscleTypeVideoSize = [
    2.8,
    4.5,
    5.7,
    4.9,
    5.2,
    4.6,
    5.0,
    4.0,
    3.9,
    4.0,
    6.3,
    3.5,
    4.8,
    4.0,
    5.4,
    3.4,
    5.5,
    4.4,
    9.9,
    3.8,
    4.6,
    1.4,
    6.1,
    4.5,
    1.3,
    4.7,
    2.3
  ];

  //----------------------------------------------------------------------------
  // 유튜브에 있는 총 영상 수
  //----------------------------------------------------------------------------
  int calculateTotalNumberOfVideo() {
    int result = 0;
    for (int index = 0; index < muscleTypeToExerciseList.length; index++) {
      result += muscleTypeToExerciseList[index].length;
    }
    return result;
  }

  //----------------------------------------------------------------------------
  // 로컬에 다운 받은 파일이 제대로 받아졌는지 확인하는 메서드
  // - 파일마다 다운로드 완료시에 실행
  //----------------------------------------------------------------------------
  Future<bool> checkVideoFileValidity({required String videoId}) async {
    // 파라미터로 받은 videoId의 영상 파일 길이를 받아오기
    StreamManifest manifest =
        await yt.videos.streamsClient.getManifest(videoId);

    // 어떤 video quality 의  stream 을 가져올 것인지 설정
    // QualityLabel 3종류 있음. 720p, 360p, 144p(없을 때도 있음)
    VideoStreamInfo streamInfo;
    if (manifest.videoOnly.length >= 2) {
      streamInfo = manifest.videoOnly
          .sortByVideoQuality()[1]; // second quality 는 아마도 360p
    } else {
      streamInfo = manifest.videoOnly.bestQuality; // second quality 는 아마도 360p
    }

    // byte 단위로 표시한 유투브 영상 파일의 길이
    int streamSize = streamInfo.size.totalBytes;

    // 로컬에 파일이 있는지 확인, 있다면 크기를 비교하여 같으면 validity 는 true, 파일이 없거나 용량이 다를 경우 false
    File localVideoFile = File('$videoDirectoryPath/$videoId.mp4');
    if (localVideoFile.existsSync()) {
      int localVideoFileSize = localVideoFile.lengthSync();
      if (streamSize == localVideoFileSize) {
        return true;
      }
      localVideoFile.deleteSync(); // 로컬 파일 크기가 스트림 사이즈와 다를 경우 (다시 받을 수 있도록) 삭제
    }
    return false;
  }

  //----------------------------------------------------------------------------
  // 근육의 타입(muscleTypeIndex)을 입력 받아서 해당 근육의 운동 영상 ID list를 출력하는 메서드
  //----------------------------------------------------------------------------
  List<String> setYoutubeIds({required int muscleTypeIndex}) {
    List<String> result = muscleTypeToExerciseList[muscleTypeIndex - 1];
    return result;
  }

  //----------------------------------------------------------------------------
  // 근육의 타입(muscleTypeIndex)을 입력 받아서 해당 근육의 운동 영상이 모두 있는지 확인하는 메서드
  //----------------------------------------------------------------------------
  bool checkLocalVideoAvailable({required int muscleTypeIndex}) {
    List<String> youtubeIdList =
        gv.youtubeManager.setYoutubeIds(muscleTypeIndex: muscleTypeIndex);
    for (int index = 0; index < youtubeIdList.length; index++) {
      if (!downloadedVideoIds.contains(youtubeIdList[index])) {
        return false; // 입력 받은 근육에 대한 운동 영상이 하나라도 없을 시 false
      }
    }
    return true; // 모든 영상을 가지고 있다면 true
  }

  //----------------------------------------------------------------------------
  // 로컬에 있는 영상 list 를 downloadedVideoIDs 리스트에  입력
  // - 클래스 초기화시
  // - 영상 파일 다운 로드 후
  // - 영상 파일 삭제 후 --> 이 메서드 대신에 downloadedVideoIds.clear() 실행
  //----------------------------------------------------------------------------
  Future<void> updateDownloadedVideoIdList({void onDone()?}) async {
    try {
      Directory videoDirectory = Directory(videoDirectoryPath);
      localVideosSize = 0; // video 디렉토리 파일 용량 총합을 저장하는 변수 초기화
      if(videoDirectory.existsSync()) {
        videoDirectory.list().listen((file) {
          if (file is File) {
            String videoId = file.path
                .split('/')
                .last.split('.').first;
            print('YoutubeManager :: updateDownloadedVideoIdList :: videoId=$videoId');
            if (!downloadedVideoIds.contains(videoId)) {
              downloadedVideoIds.add(videoId);
              localVideosSize = localVideosSize + file.lengthSync();
            }
          }
        }, onDone: onDone);
      }
    } catch (e) {
      return;
    }
  }

  //----------------------------------------------------------------------------
  // 초기화 - 영상 파일 저장 경로 설정
  //----------------------------------------------------------------------------
  void init() async {
    // 파일을 저장할 경로 설정
    Directory appDirectory = Platform.isIOS
        ? await getApplicationSupportDirectory()
        : await getApplicationDocumentsDirectory();
    videoDirectoryPath = '${appDirectory.path}/videos';

    //유튜브에 올려져있는 총 영상 수
    totalNumberOfVideo = calculateTotalNumberOfVideo();

    // 로컬에 있는 영상 list 를 downloadedVideoIDs 리스트에 모두 입력
    updateDownloadedVideoIdList();
  }

  //----------------------------------------------------------------------------
  // 클래스 dispose
  //----------------------------------------------------------------------------
  void dispose() {
    yt.close();
  }

  //----------------------------------------------------------------------------
  // 유투브 영상 다운로드 메서드
  // 로컬 폴더에 동일한 파일이 있는지 확인 후,
  // setYoutubeIds 메서드를 통해 youtubeIds 리스트에 입력된 영상 리스트를 다운로드
  //----------------------------------------------------------------------------
  Future<void> download({required int muscleTypeIndex, void Function()? onDone}) async {
    //현재 근육 타입에 해당하는 유튜브 ID list 가져오기
    List<String> youtubeIdList =
        gv.youtubeManager.setYoutubeIds(muscleTypeIndex: muscleTypeIndex);
    for (int index = 0; index < youtubeIdList.length; index++) {
      String videoId = youtubeIdList[index];
      String videoFilePath = '$videoDirectoryPath/$videoId.mp4';

      // 로컬에 해당 영상 파일이 있는지 체크
      bool existFile = downloadedVideoIds.contains(videoId);
      if (existFile == false) {
        await saveVideoFile(videoId, videoFilePath);  // 입력받은 videoId 영상 파일을 기기에 저장
        await checkVideoFileValidity(videoId: videoId);  // 파일이 제대로 받았는지 확인,(제대로 안받았으면 삭제)
      }
    }
    await updateDownloadedVideoIdList(onDone: onDone);
  }

  //----------------------------------------------------------------------------
  // 입력받은 근육에 대한 운동영상들 중 다운로드 필요한 파일들의 총 용량을 계산하는 메서드
  //----------------------------------------------------------------------------
  Future<int> calculateTotalFileSize({required int muscleTypeIndex}) async {
    int totalBytes = 0; // 파일 용량 총합을 계산할 변수
    List<String> youtubeIdList =
        gv.youtubeManager.setYoutubeIds(muscleTypeIndex: muscleTypeIndex);
    for (int index = 0; index < youtubeIdList.length; index++) {
      String videoId = youtubeIdList[index];

      // 해당 videoId 가 이미 로컬에 다운 받은 파일인지 보고, 없을 경우 다운 받을 파일 용량에 더함
      if (!downloadedVideoIds.contains(videoId)) {
        // 해당 영상에 대한 videoStreamInfo 받기
        VideoStreamInfo streamInfo = await getVideoStreamInfo(videoId: videoId);
        totalBytes += streamInfo.size.totalBytes;
      }
    }
    return totalBytes;
  }

  //----------------------------------------------------------------------------
  // VedeoInfo를 받아오는 메서드 - 360p 영상에 대한 videoInfo 를 받아오도록 작성
  //----------------------------------------------------------------------------
  Future<VideoStreamInfo> getVideoStreamInfo({required String videoId}) async {
    // video 에 대한  메타 데이터 가져오기 (채널명, 영상 시간, 썸네일, Url 등등)
    // Video video = await yt.videos.get(videoId);

    // video manifest 가져오기
    StreamManifest manifest =
        await yt.videos.streamsClient.getManifest(videoId);

    // 어떤 video quality stream 을 가져올 것인지 설정
    // QualityLabel 3종류 있음. 720p, 360p, 144p(없을 때도 있음)
    VideoStreamInfo streamInfo;
    if (manifest.videoOnly.length >= 2) {
      streamInfo = manifest.videoOnly
          .sortByVideoQuality()[1]; // second quality 는 아마도 360p
    } else {
      streamInfo = manifest.videoOnly.bestQuality; // second quality 는 아마도 360p
    }
    return streamInfo;
  }

  //----------------------------------------------------------------------------
  // videoFile 을 local 폴더에 저장하는 메서드
  //----------------------------------------------------------------------------
  Future<void> saveVideoFile(String videoId, String videoFilePath) async {
    // 해당 영상에 대한 videoStreamInfo 받기
    VideoStreamInfo streamInfo = await getVideoStreamInfo(videoId: videoId);

    // 해당 video 를 stream 으로 받기
    Stream<List<int>> videoStream = yt.videos.streamsClient.get(streamInfo);

    // 파일 생성
    File videoFile = await File(videoFilePath).create(recursive: true);

    var videoFileStream = videoFile.openWrite();

    // video stream 을 pipe 를 통해 video file 에 입력
    await videoStream.pipe(videoFileStream);

    // stream 이 완료되면 버퍼를 비우기 위해 호출
    await videoFileStream.flush();

    // stream 으로 file 에 입력 받기 종료
    await videoFileStream.close();

  }

  //----------------------------------------------------------------------------
  // video 폴더에 있는 모든 영상 삭제
  //----------------------------------------------------------------------------
  Future<void> deleteAllVideos() async {
    try {
      Directory videoDirectory = Directory(videoDirectoryPath);
      videoDirectory.list().listen((file) {
        if (file is File) {
          file.deleteSync();
        }
      });
      downloadedVideoIds.clear();
      localVideosSize = 0;
    } catch (e) {
      return;
    }
  }
}

//==============================================================================
// 010 손목굴곡근
//==============================================================================
List<String> m01WristFlexorExerciseList = [
  'NBf_fV9FXnI',
  '6IDtNM7zcII',
  'VhXmsprilak',
  'NC90d80Zgac',
  'amcir6duLrk',
];

//==============================================================================
// 020 손목신전근
//==============================================================================
List<String> m02WristExtensorExerciseList = [
  'y1EeMzM1GCw',
  '0krr0SxqHYo',
  'V5ZvmXIK8E8',
  '-NYp--CobV8',
  '1rLAI2kmhAc',
  '4X42SfpUaSo',
  '8r1b2D4Uyy0'
];

//==============================================================================
// 030 위팔 두갈래근 (이두근)
//==============================================================================
List<String> m03BicepsExerciseList = [
  'RpvOZ3Te44U',
  'k_AVnn1N_e0',
  'lJgSwAeRgb8',
  'YbjNCWI2IPY',
  'cPjgfRnjL_I',
  'lO0j23ojZEM',
  'vmmUlmVIqDw',
  'DFNyZex25Wg',
];
//==============================================================================
// 040 위팔 세갈래근 (삼두근)
//==============================================================================
List<String> m04TricepsExerciseList = [
  'smV6E6Tm5wk',
  '4bNVQzNcOTo',
  't0TBMBGEGqY',
  'fc8mLFLOM3Q',
  '42Xh-4DQGeA',
  'Fa0uRMCabAM',
  'oEWnkzwUkbY',
  '-BWC-Hs4juM',
  'DJ01VSCJbbA',
];

//==============================================================================
// 050 전면삼각근
//==============================================================================
List<String> m05FrontDeltoidExerciseList = [
  'yccpZ7mbsAY',
  'RwqpKYcX58o',
  'QluUSdvCUFU',
  'fgQDYCiccJg',
  'ME_6JN854yI',
  'KropbsgsLhE',
  '_PI11xnfjwQ',
];

//==============================================================================
// 051 측면삼각근
//==============================================================================
List<String> m06MiddleDeltoidExerciseList = [
  'rkL96D04Rrg',
  'P1G8ChxnwrY',
  'K-tHp2tkVwg',
  'd9eNPjtb5y0',
  'pjn4m4KaVDo',
  'NfyPFmAQr2I',
  '4BAeO9OmW94',
];

//==============================================================================
// 052 후면삼각근
//==============================================================================
List<String> m07BackDeltoidExerciseList = [
  'REYffpI0KUw',
  'MucVgKikqGU',
  'l8SuQ53agkc',
  'e98SZfz8J2o',
  '7Ojl-HxSZUI',
  'jWy55_IPQAI',
  'AdHhDmqfdME',
  'QekHOQwTENA',
];

//==============================================================================
// 080 가쪽 어깨돌림근
//==============================================================================
List<String> m08ExternalRotatorExerciseList = [
  'ZgMdrPiXnAc',
  'CqUGgKWSkGQ',
  'x40r2drxemU',
  'plEm0vwDSOQ',
  'mn-B5wTliHQ',
  'AfBfHkzmFz4',
  'jDovHeKQWHI',
  'AQKD6Y_fGqg',
  '4FbSKa9L_w4', //바벨 쿠반 로테이션
];

//==============================================================================
// 090 안쪽 어깨돌림근
//==============================================================================
List<String> m09ExternalRotatorExerciseList = [
  'j6arMfL0KWM',
  'HE85WEKO0GI',
  'MCQY_GsZ24Y',
  'A-Cafzax__g',
];

//==============================================================================
// 100 상부대흉근
//==============================================================================
List<String> m10UpperPectoralisExerciseList = [
  'Rgx4Ca1EDY0',
  'xeyl1cTr-8U',
  'r5FcE4QMs-w',
  've_R-SuHfR8',
  '1LCAoOhk1aQ',
  'pa9DRj8Estk',
  '4E1LR_aLIPM',
  'm4VHyAAapQ8',
];

//==============================================================================
// 101 중부대흉근
//==============================================================================
List<String> m11MiddlePectoralisExerciseList = [
  'Vko-e-OdeZI',
  'XldOC_bfij4',
  'm_3_DpNly94',
  'LLVhOIT1zF0',
  '7jtPlaewfO4',
  'Mpqa0V0hO1E',
  '7WOuXEI5IWw',
  'gjuY3WrM-nE',
  '-Dd0Bj6Uv_k',
  'HVZNwL2Uew8',
];

//==============================================================================
// 102 하부대흉근
//==============================================================================
List<String> m12LowerPectoralisExerciseList = [
  'hREGLCBzZ80',
  'jVjvF5pvBnI',
  'PREmKP-I9kg',
  '4ZZBuC6xOcM',
  '5PyjwQQ1-Hg',
  '4H1bKgx3y7Y',
  '6du0U_hwUG4',
  'FwjqF9sBs9s',
];

//==============================================================================
// 130 앞톱니근
// ==============================================================================
List<String> m13SerratusAnteriorExerciseList = [
  'rEau8zH9YzM',
  'wVPJyrDUAbw',
  'LvLvDq7BdGg',
  'holHxF1qE7g',
  'fZYL_8cdv4A',
  'jneWqk36D2Q',
  '--08N3WEiMA',
  'mp0dVG-HcEg',
];

//==============================================================================
// 140 상 승모근
// ==============================================================================
List<String> m16UpperTrapeziusExerciseList = [
  'y00d3Ub-CBk',
  'jM3rm460Atc',
  'Ar_6kTGn6GY',
  'i1HldHkdLiQ',
  'Pgb797x4fUU',
];

//==============================================================================
// 141 중 승모근
// ==============================================================================
List<String> m17MiddleTrapeziusExerciseList = [
  '935agFUUjuk',
  'Mopzl4jBfbA',
  'igpX6q_Ebrk',
  '_jABaTcYipw',
  'NI5nCunhOog',
  'fcz9KqiLfDA',
  'ylmssEe-9YA',
  'J65fcpSi7DE',
  'fvlhKsOpBys',
];

//==============================================================================
// 142 하 승모근
// ==============================================================================
List<String> m18LowerTrapeziusExerciseList = [
  'jN-wr1pPZR4',
  'Yk2TYqpe5jM',
  'GGpdIEA0kMU',
  'EFtMdesUJ08',
  'vB6RAqQoxx0',
  'LClo-twYVag',
  '-2alGld8yaw',
];

//==============================================================================
// 170 넓은 등근
// ==============================================================================
List<String> m19LatissimusDorsiExerciseList = [
  'M-NINPNuqgE',
  'puYra7qDOGQ',
  'ace_lTGR5Gk',
  'jsboAcROj0c',
  'zRSmdQEAezA',
  'gIH9hPeCk48',
  'HV-horYVg8Q',
  '1y79GYWVJIY',
  'RRUuPoRY37o',
  'YJHCxHbcqYs',
  'Bj_VEtkYYIM',
  'DpVAySNFh60',
];

//==============================================================================
// 180 복직근
// ==============================================================================
List<String> m14RectusAbdominalExerciseList = [
  'cBxqWzqs2-U',
  '_LHnpwYiaZc',
  'oX1MEpP_xrQ',
  'wgLmKIf3sx0',
  'M7Z4k7Mwwbs',
  'VRamVqqMZw0',
  'cOFdJtdWd_s',
  'ogVpOrh7vDU',
  'Z0EUENM-Csc',
];

//==============================================================================
// 190 배 바깥빗근
// ==============================================================================
List<String> m15ExternalObliqueAbdominalExerciseList = [
  'DnFdzSFMrB0',
  'MemrlwJTfmw',
  'ldmz68b8CkU',
  'Z5fYeEp3q78',
  'MkCRWzZhNxA',
  'HIbudAw5M1w',
  '_Zz0M-6Jelk',
  'yifrytEfrqY',
  'KdKTW7hUUUc',
];

//==============================================================================
// 200 척추세움근
// ==============================================================================
List<String> m20ErectorSpinaeExerciseList = [
  'UMS4UM8v600',
  '2dHsJynItcM',
  '4UnLvSu8yIo',
  'CauE7iLjlMk',
  'PxK9vIm_bRc',
  'Gzib6MBxTTU',
  'tZ3vsOuiaUk',
  'sSC2vnmt2PE',
  's5abdMQ2gKk',
];

//==============================================================================
// 210 큰 볼기근
// ==============================================================================
List<String> m21GluteusMaximusExerciseList = [
  'IGdGjAbdp8s',
  'Zo4Nh28DBKc',
  'puorVDOorjA',
  'ByugEW6L_HY',
  'aupXvP-H1FI',
  '1VNWiHufgq4',
  '0vJrhiCkdUg',
  'SMfcJG6mSok',
];

//==============================================================================
// 211 중간 볼기근
// ==============================================================================
List<String> m22GluteusMediusExerciseList = [
  '6LSynMP2tm4',
  'D0XPDKSPL2Q',
  'k8_VmhELPl4',
  '4WheCKi7AZA',
  'XIzEIBJa1_8',
];

//==============================================================================
// 220 대퇴사두근
// ==============================================================================
List<String> m23QuadricepsFemorisExerciseList = [
  'Y0qQ_U-6-xM',
  'RG24UUjJopA',
  'mGVX_bs5Lzk',
  'rh6sG736N8I',
  'tWnAI4I1whw',
  '1-5gWhSaP4U',
  'THk_QlAjeqk',
  '7OL8CKwT-xk',
];

//==============================================================================
// 230 넙다리뒤근
// ==============================================================================
List<String> m24HamstringsExerciseList = [
  'WeviLSk6GKo',
  'klfGd7fNWkc',
  'dMDRnY86tIc',
  'pSdAzsBnmp8',
  'j_pPhVFsMYM',
  'oiQsY2zzxLM',
  'NZOyr8-L_us',
  '6wkYuXzg0KI',
  'kDDX64PS0DM',
];

//==============================================================================
// 240 앞 정강근
// ==============================================================================
List<String> m26TibialisAnteriorExerciseList = [
  '-sawLT22HDs',
  'gDytS6ibe9Y',
  'JwpWWeVkQKA',
  'Crs__84S3C8',
  'NTZAg1aO5QY',
  'Xf0q4EcpFIo',
  'ELEjZ_4F4U8',
  'lky-VWdf9cg',
];

//==============================================================================
// 250 장딴지근
// ==============================================================================
List<String> m27GastrocnemiusExerciseList = [
  'QZpZ0hUQg8U',
  'LGCBZpZZQ_c',
  'QpeRDX-ORPQ',
  'LjHgxQsFUwk',
];

//==============================================================================
// 270 모음근
// ==============================================================================
List<String> m25AdductorExerciseList = [
  'tOmAN2nBTV8',
  '4e664m8n4XE',
  'Z4eaPtdSY1o',
];
