## 0.0.3

* Enhanced error handling for better debugging.
* Improved ad loading logic to reduce failures.
* Optimized banner and native ad rendering performance.

## 0.0.2

* Fixed compatibility issues with WebAssembly (Wasm) by adding platform checks.
* Prevented `dart:io` imports from running on unsupported platforms.
* Improved stability and performance for ad loading and displaying.

## 0.0.1

* Initial release of **FanEasy** 🎉
* Simplified Facebook Audience Network ad integration for Flutter.
* Supports Banner, Native, Interstitial, and Rewarded ads.
* Easy-to-use singleton instance: `FanEasy.instance.loadInit()`, `FanEasy.instance.showInterstitial()`, etc.