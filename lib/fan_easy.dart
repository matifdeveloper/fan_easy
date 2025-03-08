library;

import 'package:flutter/material.dart';
import 'package:easy_audience_network/easy_audience_network.dart';

/// A singleton class to manage Audience Network ads easily.
class FanEasy {
  static final FanEasy instance = FanEasy._internal();

  bool _isInitLoaded = false;
  bool _isInterstitialLoaded = false;
  bool _isRewardedLoaded = false;
  InterstitialAd? _interstitialAd;
  RewardedAd? _rewardedAd;

  FanEasy._internal();

  /// Initializes the Audience Network SDK.
  ///
  /// [testMode] is optional and used for testing purposes.
  Future<void> loadInit({
    String? testingId,
    bool testMode = false,
    bool iOSAdvertiserTrackingEnabled = false,
  }) async {
    await EasyAudienceNetwork.init(
      testingId: testingId,
      testMode: testMode,
      iOSAdvertiserTrackingEnabled: iOSAdvertiserTrackingEnabled,
    );
    _isInitLoaded = true;
  }

  /// Returns `true` if the SDK is initialized.
  bool get initLoaded => _isInitLoaded;

  /// Loads an interstitial ad with the given [placementId].
  void loadInterstitial({required String placementId}) {
    if (placementId.isEmpty) {
      return;
    }
    _interstitialAd = InterstitialAd(placementId);
    _interstitialAd?.listener = InterstitialAdListener(
      onLoaded: () => _isInterstitialLoaded = true,
      onError: (code, message) {
        debugPrint('Interstitial ad error: $code - $message');
      },
      onDismissed: () {
        _isInterstitialLoaded = false;
        _interstitialAd?.destroy();
        loadInterstitial(placementId: placementId);
      },
    );
    _interstitialAd?.load();
  }

  /// Shows the loaded interstitial ad if available.
  void showInterstitial() {
    if (_isInterstitialLoaded) {
      _interstitialAd?.show();
    } else {
      debugPrint("Interstitial Ad not yet loaded!");
    }
  }

  /// Returns `true` if an interstitial ad is loaded.
  bool get interstitialLoaded => _isInterstitialLoaded;

  /// Loads a rewarded video ad with the given [placementId].
  void loadRewarded({required String placementId}) {
    if (placementId.isEmpty) {
      return;
    }
    _rewardedAd = RewardedAd(placementId);
    _rewardedAd?.listener = RewardedAdListener(
      onLoaded: () => _isRewardedLoaded = true,
      onError: (code, message) {
        debugPrint('Rewarded ad error: $code - $message');
      },
      onVideoClosed: () {
        _isRewardedLoaded = false;
        _rewardedAd?.destroy();
        loadRewarded(placementId: placementId);
      },
    );
    _rewardedAd?.load();
  }

  /// Shows the loaded rewarded video ad if available.
  void showRewarded() {
    if (_isRewardedLoaded) {
      _rewardedAd?.show();
    } else {
      debugPrint("Rewarded Ad not yet loaded!");
    }
  }

  /// Returns `true` if a rewarded ad is loaded.
  bool get rewardedLoaded => _isRewardedLoaded;

  /// Returns a banner ad widget with the given [placementId] and [bannerSize].
  Widget bannerAd({
    required String placementId,
    BannerSize bannerSize = BannerSize.STANDARD,
  }) {
    if (placementId.isEmpty) {
      return const SizedBox();
    }
    return BannerAd(
      placementId: placementId,
      bannerSize: bannerSize,
      listener: BannerAdListener(
        onError: (code, message) =>
            debugPrint('Banner Ad Error: $code - $message'),
        onLoaded: () => debugPrint('Banner Ad Loaded'),
      ),
    );
  }

  /// Returns a native ad widget with the given [placementId], [width], and [height].
  Widget nativeAd(
      {required String placementId,
      double width = double.infinity,
      double height = 300}) {
    if (placementId.isEmpty) {
      return const SizedBox();
    }
    return NativeAd(
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
      listener: NativeAdListener(
        onError: (code, message) =>
            debugPrint('Native Ad Error: $code - $message'),
        onLoaded: () => debugPrint('Native Ad Loaded'),
      ),
      keepExpandedWhileLoading: true,
      expandAnimationDuraion: 1000,
    );
  }
}
