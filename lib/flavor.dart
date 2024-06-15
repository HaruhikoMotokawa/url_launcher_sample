// ignore_for_file: public_member_api_docs
/// 今回はFlavorをちゃんと設定していないのでmain関数は通常通りにrunする
enum Flavor {
  prod,
  stg,
  dev;
}

/// フレーバーの設定オブジェクト
class FlavorConfig {
  /// デフォルトのフレーバーはdev
  static Flavor appFlavor = Flavor.dev;

  /// 現在のフレーバー名を返す
  static String get name => appFlavor.name;
}
