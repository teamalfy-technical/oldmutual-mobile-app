import 'package:package_info_plus/package_info_plus.dart';

const apiBaseUrlProd = "https://app.oldmutual.com.gh/api";
const apiBaseUrlDev = "https://test-app.oldmutual.com.gh/api";

enum EnvironmentType {
  dev(apiBaseUrlDev),
  prod(apiBaseUrlProd);

  const EnvironmentType(this.apiBaseUrl);
  final String apiBaseUrl;
}

class Environment {
  static EnvironmentType? _current;

  static Future<EnvironmentType> current() async {
    if (_current != null) {
      return _current!;
    }

    final packageInfo = await PackageInfo.fromPlatform();

    switch (packageInfo.packageName) {
      case "com.oldmutual.pensions.app.dev" ||
          "com.oldmutual.pensions.app.devo":
        _current = EnvironmentType.dev;
        break;
      case "com.oldmutual.pensions.app" || "com.oldmutual.pensions.app.prod":
        _current = EnvironmentType.prod;
        break;
      default:
        _current = EnvironmentType.dev;
    }
    return _current!;
  }
}
