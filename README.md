# FanEasy

FanEasy is a simple and efficient Flutter package for integrating Facebook Audience Network ads seamlessly. It provides easy-to-use methods for loading and displaying various ad formats.

## Features
- Load and show Interstitial Ads
- Load and show Rewarded Ads
- Display Banner Ads
- Display Native Ads
- Check if ads are loaded

## Installation

Add this to your `pubspec.yaml` file:

```yaml
dependencies:
  fan_easy: any
```

Then run:

```sh
flutter pub get
```

## Usage

### Initialization
Before using any ad feature, initialize the SDK:

```dart
import 'package:fan_easy/fan_easy.dart';

void main() {
  FanEasy.instance.loadInit(testingId: "YOUR_TESTING_ID");
}
```

### Load and Show Interstitial Ads

```dart
FanEasy.instance.loadInterstitial(placementId: "YOUR_INTERSTITIAL_PLACEMENT_ID");

if (FanEasy.instance.interstitialLoaded) {
  FanEasy.instance.showInterstitial();
}
```

### Load and Show Rewarded Ads

```dart
FanEasy.instance.loadRewarded(placementId: "YOUR_REWARDED_PLACEMENT_ID");

if (FanEasy.instance.rewardedLoaded) {
  FanEasy.instance.showRewarded();
}
```

### Display Banner Ads

```dart
FanEasy.instance.bannerAd(placementId: "YOUR_BANNER_PLACEMENT_ID")
```

### Display Native Ads

```dart
FanEasy.instance.nativeAd(placementId: "YOUR_NATIVE_PLACEMENT_ID")
```

## Example

```dart
import 'package:flutter/material.dart';
import 'package:fan_easy/fan_easy.dart';

void main() {
  runApp(MyApp());
  FanEasy.instance.loadInit(testingId: "YOUR_TESTING_ID");
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("FanEasy Example")),
        body: AdExamplePage(),
      ),
    );
  }
}

class AdExamplePage extends StatefulWidget {
  @override
  _AdExamplePageState createState() => _AdExamplePageState();
}

class _AdExamplePageState extends State<AdExamplePage> {
  @override
  void initState() {
    super.initState();
    FanEasy.instance.loadInterstitial(placementId: "YOUR_INTERSTITIAL_PLACEMENT_ID");
    FanEasy.instance.loadRewarded(placementId: "YOUR_REWARDED_PLACEMENT_ID");
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () => FanEasy.instance.showInterstitial(),
            child: Text("Show Interstitial Ad"),
          ),
          ElevatedButton(
            onPressed: () => FanEasy.instance.showRewarded(),
            child: Text("Show Rewarded Ad"),
          ),
          SizedBox(height: 20),
          FanEasy.instance.bannerAd(placementId: "YOUR_BANNER_PLACEMENT_ID"),
          SizedBox(height: 20),
          FanEasy.instance.nativeAd(placementId: "YOUR_NATIVE_PLACEMENT_ID"),
        ],
      ),
    );
  }
}
```

## License

This package is licensed under the MIT License.

