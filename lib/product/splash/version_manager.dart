import 'package:news_app/product/utilities/exceptions/version_exception.dart';

class VersionManager {
  VersionManager({required this.deviceVersion, required this.databaseVersion});

  final String deviceVersion;
  final String databaseVersion;
  bool isNeedTpUpdate() {
    final deviceVersionSplitted = deviceVersion.split('.').join();
    final databaseVersionSplitted = databaseVersion.split('.').join();

    final deviceNumber = int.tryParse(deviceVersionSplitted);
    final databaseNumber = int.tryParse(databaseVersionSplitted);

    // ignore: unnecessary_null_comparison
    if (deviceVersion == null || databaseVersion == null) {
      throw VersionException(
        '$databaseVersion or $deviceVersion is null. Please check. -M',
      );
    }
    return deviceNumber! < databaseNumber!;
  }
}
