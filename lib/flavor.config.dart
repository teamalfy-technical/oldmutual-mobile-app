import 'package:package_info_plus/package_info_plus.dart';

// const apiBaseUrlProd = "https://app.oldmutual.com.gh/api";
const apiBaseUrlProd = "https://old-mutual-api-production.up.railway.app/api";
const apiBaseUrlDev = "https://old-mutual-api-production.up.railway.app/api";

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
      case "com.oldmutual.pensions.app.dev":
        _current = EnvironmentType.dev;
        break;
      default:
        _current = EnvironmentType.prod;
    }
    return _current!;
  }
}
