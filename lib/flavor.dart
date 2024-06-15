enum Flavor {
  prod,
  stg,
  dev;
}

class FlavorConfig {
  static Flavor appFlavor = Flavor.dev;
  static String get name => appFlavor.name;
}
