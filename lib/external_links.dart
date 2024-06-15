import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher_sample/flavor.dart';

/// 外部リンク
enum ExternalLinks {
  /// Qiitaへの接続で、[mode]はアプリ **外** ブラウザで開く
  qiita._(LaunchMode.externalApplication),

  /// Zennへの接続で、[mode]はアプリ **内** ブラウザで開く
  zenn._(LaunchMode.inAppBrowserView),

  /// Flavorによって接続先が変わり、[mode]はWebViewで開く
  changeLink._(LaunchMode.inAppWebView);

  const ExternalLinks._(this.mode);

  /// [LaunchMode]はurl_luncherに定義されたenumで、URLを起動するモードを指定する
  /// enumのフィールドはコンストな値（変更不可能な値）のみを持つことができる。
  final LaunchMode mode;
}

/// 動的な値を持たせたい場合は、extensionを使ってメソッドを追加する。
extension ExternalLinksExtension on ExternalLinks {
  /// 接続先のurlを返す
  String get url {
    switch (this) {
      case ExternalLinks.qiita:
        return 'https://qiita.com/';
      case ExternalLinks.zenn:
        return 'https://zenn.dev/';
        // ここに直接switch文を書けない
        // メソッド化して、その結果を受け取る
      case ExternalLinks.changeLink:
        return _getChangeLinksUrl();
    }
  }

  /// Flavorによって変わるurlを返却する
  String _getChangeLinksUrl() {
    switch (FlavorConfig.appFlavor) {
      case Flavor.dev:
        return 'https://www.apple.com/jp/';
      case Flavor.stg:
        return 'https://developer.android.com/?hl=ja';
      case Flavor.prod:
        return 'https://www.microsoft.com/ja-jp/';
    }
  }
}
