import '/F0_BASIC/common_import.dart';
import 'package:audioplayers/audioplayers.dart'; // 오디오 플레이어

// enum EmaSoundType {
//   warning,
//   targetSuccess,
//   btConnect,
//   btDisconnect,
//   saveSuccess,
//   update1Rm,
//   measureStart,
//   measureEnd,
// }

class AudioManager {
  // 최대 5중첩 플레이를 위해 5개 생성
  final List<AudioPlayer> audioPlayer =
      List.generate(GvDef.audioPlayerNum, (index) => AudioPlayer());
  Rx<double> volume = 0.5.obs;
  int audioPlayerIndex = 0;


  late List<String> fileNames;
  bool flagFirst = true;

  //iOS 에서 ear speaker 로 사운드가 플레이되는 문제를 해결하기 위해 default speaker 를 설정
  final AudioContext audioContext = AudioContext(
      android: AudioContextAndroid(
          isSpeakerphoneOn: true,
          stayAwake: true,
          contentType: AndroidContentType.sonification,
          usageType: AndroidUsageType.assistanceSonification,
          audioFocus: AndroidAudioFocus.gainTransient),
      iOS: AudioContextIOS(
          defaultToSpeaker: true,
          category: AVAudioSessionCategory.playAndRecord,
          options: [
            AVAudioSessionOptions.defaultToSpeaker,
            AVAudioSessionOptions.mixWithOthers
          ]));
  late final AudioCache myAudioCache;

  init() async {
    // 오디오 플레이어 초기화
    fileNames = [
      '경고음(띠릭).mp3',
      '목표성공(버블톡).mp3',
      '블루투스 연결(띠리리링).mp3',
      '블루투스 해제(로그아웃).mp3',
      '저장성공(퀘스트보상).mp3',
      '최대근력 갱신(두둥).mp3',
      '측정시작(전자음).mp3',
      '측정종료(전자음).mp3'
    ]; //공통
    myAudioCache = audioPlayer[0].audioCache;
    myAudioCache.prefix = 'assets/sounds/';
    // await loadAllAssets();
    await myAudioCache.loadAll(fileNames);
    volume.value = gv.spMemory.read('volume')??0.5;
    AudioPlayer.global.setGlobalAudioContext(audioContext);

    // Android 에서는 play 가 끝나면 stop() 하도록 코딩 하면 error message 가 종종 떠서, 다음 play 하기 전에 stop 실행
    // iOS는 background 에서 foreground 로 전환될 때 자동으로 play 되는 문제가 있어, play 끝나면 항상 stop 수행하도록함
    if (gv.system.isIos) {
      for (int n = 0; n < GvDef.audioPlayerNum; n++) {
        audioPlayer[n].onPlayerComplete.listen((event) {
          if (audioPlayer[n].state == PlayerState.playing) {
            gv.audioManager.stop();
          }
        });
      }
    }

    // audioPlayer.setPlayerMode(PlayerMode.lowLatency);

    // audioPlayer 의 설명에는 낮은 지연을 위해서 PlayerMode.lowLatency 가 적합하다고 되어있지만 사용하면,
    // log 창에 많은 메세지를 출력하게 됨. 그래서 사용안하고 주석처리
    // 참고 자료: https://github.com/bluefireteam/audioplayers/issues/335
    // audioPlayer.setPlayerMode(PlayerMode
    //     .lowLatency); // Ideal for short audio files, since it reduces the impacts on visuals or UI performance.
  }

  // 오디오 캐시의 메소드로 포워딩 할 메소드 정의

  // 오디오 플레이어 메소드로 포워딩 할 메소드 정의
  void play({required EmaSoundType type}) async {
    // if( gv.system.isAndroid == true ) {
    //   if(audioPlayer.state == PlayerState.playing) {
    //     await gv.audioManager.stop();
    //   }
    // }

    late Source source;
    if (type == EmaSoundType.warning) {
      source = UrlSource('${myAudioCache.loadedFiles['경고음(띠릭).mp3']}');
    } else if (type == EmaSoundType.targetSuccess) {
      source = UrlSource('${myAudioCache.loadedFiles['목표성공(버블톡).mp3']}');
    } else if (type == EmaSoundType.btConnect) {
      source = UrlSource('${myAudioCache.loadedFiles['블루투스 연결(띠리리링).mp3']}');
    } else if (type == EmaSoundType.btDisconnect) {
      source = UrlSource('${myAudioCache.loadedFiles['블루투스 해제(로그아웃).mp3']}');
    } else if (type == EmaSoundType.saveSuccess) {
      source = UrlSource('${myAudioCache.loadedFiles['저장성공(퀘스트보상).mp3']}');
    } else if (type == EmaSoundType.update1Rm) {
      source = UrlSource('${myAudioCache.loadedFiles['최대근력 갱신(두둥).mp3']}');
    } else if (type == EmaSoundType.measureStart) {
      source = UrlSource('${myAudioCache.loadedFiles['측정시작(전자음).mp3']}');
    } else if (type == EmaSoundType.measureEnd) {
      source = UrlSource('${myAudioCache.loadedFiles['측정종료(전자음).mp3']}');
    } else {
      source = UrlSource('${myAudioCache.loadedFiles['경고음(띠릭).mp3']}');
    }

    // 매번 AutioPlayer 변수를 새로 만들면 중첩 플레이 가능
    // AudioPlayer audioPlayerTmp = AudioPlayer();
    // audioPlayerTmp.play(source);

    // audioPlayerTmp;
    //----------------------------------------------
    // 최대 5중첩 플레이를 위해 리스트 형식으로 생성
    audioPlayer[audioPlayerIndex].play(source, volume: volume.value);
    audioPlayerIndex++;
    audioPlayerIndex %= GvDef.audioPlayerNum;
    // print('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>$audioPlayerIndex');

    // if (flagFirst == true) {
    //   if (audioPlayer.state != PlayerState.playing) {
    //     await audioPlayer.play(source, ctx: audioContext);
    //     flagFirst == false;
    //   }
    // } else {
    //   if (audioPlayer.state != PlayerState.playing) {
    //     await audioPlayer.play(source);
    //   }
    // }
  }

  Future<void> stop() async {
    for (int n = 0; n < GvDef.audioPlayerNum; n++) {
      await audioPlayer[n].stop();
    }
  }

  // void resume() async {
  //   for (int n=0;n<GvDef.audioPlayerNum;n++) {
  //     await audioPlayer[n].resume();
  //   }
  // }

  void setVolume({required double volume}) async {
    this.volume.value = volume;
    for (int n = 0; n < GvDef.audioPlayerNum; n++) {
      await audioPlayer[n].setVolume(volume);
    }
    gv.spMemory.write('volume', volume);
  }

// Future<void> loadAllAssets() async {
//   await myAudioCache.loadAll(fileNames);
// }

// String get state => audioPlayer[0].state.toString();
}
