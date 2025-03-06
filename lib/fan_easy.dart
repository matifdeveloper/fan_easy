library;

import 'package:flutter/material.dart';
import 'package:facebook_audience_network/facebook_audience_network.dart';

class FanEasy {
  static final FanEasy instance = FanEasy._internal();

  bool _isInitLoaded = false;
  bool _isInterstitialLoaded = false;
  bool _isRewardedLoaded = false;

  FanEasy._internal();

  void loadInit({String? testingId}) {
    FacebookAudienceNetwork.init(
      testingId: testingId,
      iOSAdvertiserTrackingEnabled: true,
    );
    _isInitLoaded = true;
  }

  bool get initLoaded => _isInitLoaded;

  void loadInterstitial({required String placementId}) {
    FacebookInterstitialAd.loadInterstitialAd(
      placementId: placementId,
      listener: (result, value) {
        if (result == InterstitialAdResult.LOADED) _isInterstitialLoaded = true;
        if (result == InterstitialAdResult.DISMISSED &&
            value["invalidated"] == true) {
          _isInterstitialLoaded = false;
          loadInterstitial(placementId: placementId);
        }
      },
    );
  }

  void showInterstitial() {
    if (_isInterstitialLoaded) {
      FacebookInterstitialAd.showInterstitialAd();
    } else {
      debugPrint("Interstitial Ad not yet loaded!");
    }
  }

  bool get interstitialLoaded => _isInterstitialLoaded;

  void loadRewarded({required String placementId}) {
    FacebookRewardedVideoAd.loadRewardedVideoAd(
      placementId: placementId,
      listener: (result, value) {
        if (result == RewardedVideoAdResult.LOADED) _isRewardedLoaded = true;
        if (result == RewardedVideoAdResult.VIDEO_CLOSED &&
            (value == true || value["invalidated"] == true)) {
          _isRewardedLoaded = false;
          loadRewarded(placementId: placementId);
        }
      },
    );
  }

  void showRewarded() {
    if (_isRewardedLoaded) {
      FacebookRewardedVideoAd.showRewardedVideoAd();
    } else {
      debugPrint("Rewarded Ad not yet loaded!");
    }
  }

  bool get rewardedLoaded => _isRewardedLoaded;

  Widget bannerAd(
      {required String placementId,
      BannerSize bannerSize = BannerSize.STANDARD}) {
    return FacebookBannerAd(
      placementId: placementId,
      bannerSize: bannerSize,
      listener: (result, value) {
        debugPrint("Banner Ad: $result -->  $value");
      },
    );
  }

  Widget nativeAd(
      {required String placementId,
      double width = double.infinity,
      double height = 300}) {
    return FacebookNativeAd(
      placementId: placementId,
      adType: NativeAdType.NATIVE_AD_VERTICAL,
      width: width,
      height: height,
      backgroundColor: Colors.blue,
      titleColor: Colors.white,
      descriptionColor: Colors.white,
      buttonColor: Colors.deepPurple,
      buttonTitleColor: Colors.white,
      buttonBorderColor: Colors.white,
      listener: (result, value) {
        debugPrint("Native Ad: $result --> $value");
      },
      keepExpandedWhileLoading: true,
      expandAnimationDuraion: 1000,
    );
  }
}
