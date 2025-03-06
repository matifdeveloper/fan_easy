library;

import 'package:flutter/material.dart';
import 'package:facebook_audience_network/facebook_audience_network.dart';

/// A singleton class to manage Facebook Audience Network ads easily.
class FanEasy {
  static final FanEasy instance = FanEasy._internal();

  bool _isInitLoaded = false;
  bool _isInterstitialLoaded = false;
  bool _isRewardedLoaded = false;

  FanEasy._internal();

  /// Initializes the Facebook Audience Network SDK.
  ///
  /// [testingId] is optional and used for testing purposes.
  void loadInit({String? testingId}) {
    FacebookAudienceNetwork.init(
      testingId: testingId,
      iOSAdvertiserTrackingEnabled: true,
    );
    _isInitLoaded = true;
  }

  /// Returns `true` if the SDK is initialized.
  bool get initLoaded => _isInitLoaded;

  /// Loads an interstitial ad with the given [placementId].
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

  /// Shows the loaded interstitial ad if available.
  void showInterstitial() {
    if (_isInterstitialLoaded) {
      FacebookInterstitialAd.showInterstitialAd();
    } else {
      debugPrint("Interstitial Ad not yet loaded!");
    }
  }

  /// Returns `true` if an interstitial ad is loaded.
  bool get interstitialLoaded => _isInterstitialLoaded;

  /// Loads a rewarded video ad with the given [placementId].
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

  /// Shows the loaded rewarded video ad if available.
  void showRewarded() {
    if (_isRewardedLoaded) {
      FacebookRewardedVideoAd.showRewardedVideoAd();
    } else {
      debugPrint("Rewarded Ad not yet loaded!");
    }
  }

  /// Returns `true` if a rewarded ad is loaded.
  bool get rewardedLoaded => _isRewardedLoaded;

  /// Returns a banner ad widget with the given [placementId] and [bannerSize].
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

  /// Returns a native ad widget with the given [placementId], [width], and [height].
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
