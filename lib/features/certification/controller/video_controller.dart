import 'package:get/get.dart';

class VideoController extends GetxController {
  RxBool isControllerReady = false.obs;
  RxString currentVideoTitle = ''.obs;
  int? currentPlayingVideoIndex;
  RxBool isVideoCompleted = false.obs;

  // You can add any other state you need here

  void setCurrentVideoTitle(String title) {
    currentVideoTitle.value = title;
  }

  void setControllerReady(bool value) {
    isControllerReady.value = value;
  }

  void setVideoCompleted(bool value) {
    isVideoCompleted.value = value;
  }

  void setCurrentPlayingVideoIndex(int index) {
    currentPlayingVideoIndex = index;
  }
}
