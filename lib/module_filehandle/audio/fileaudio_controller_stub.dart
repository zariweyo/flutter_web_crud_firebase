

import 'fileaudio_controller_abs.dart';

class FileAudioController implements FileAudioControllerBase{

  FileAudioController(String src);

  @override
  destroy() {
    throw UnimplementedError();
  }

  @override
  getSeconds() {
    throw UnimplementedError();
  }

  @override
  Future<bool> onLoaded() {
    throw UnimplementedError();
  }

  @override
  pause() {
    throw UnimplementedError();
  }

  @override
  play() {
    throw UnimplementedError();
  }

}