import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';

class DeviceInfo {
  static Future<dynamic> getInfo(dynamic screenInfo) async {
    DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

    if (Platform.isAndroid) {
      return _readAndroidBuildData(await deviceInfoPlugin.androidInfo, screenInfo);
    } else if (Platform.isIOS) {
      return _readIosDeviceInfo(await deviceInfoPlugin.iosInfo, screenInfo);
    }
    return {};
  }

  static dynamic _readAndroidBuildData(AndroidDeviceInfo build, dynamic screenInfo) {
    return {
      "version.securityPatch": build.version.securityPatch,
      "version.sdkInt": build.version.sdkInt,
      "version.release": build.version.release,
      "version.previewSdkInt": build.version.previewSdkInt,
      "version.incremental": build.version.incremental,
      "version.codename": build.version.codename,
      "version.baseOS": build.version.baseOS,
      "board": build.board,
      "bootloader": build.bootloader,
      "brand": build.brand,
      "device": build.device,
      "display": build.display,
      "fingerprint": build.fingerprint,
      "hardware": build.hardware,
      "host": build.host,
      "id": build.id,
      "manufacturer": build.manufacturer,
      "model": build.model,
      "product": build.product,
      "supported32BitAbis": build.supported32BitAbis,
      "supported64BitAbis": build.supported64BitAbis,
      "supportedAbis": build.supportedAbis,
      "tags": build.tags,
      "type": build.type,
      "isPhysicalDevice": build.isPhysicalDevice,
      "androidId": build.androidId,
      "systemFeatures": build.systemFeatures,
      "screen.width": screenInfo["width"],
      "screen.height": screenInfo["height"],
      "screen.devicePixelRatio": screenInfo["devicePixelRatio"],
    };
  }

  static dynamic _readIosDeviceInfo(IosDeviceInfo data, dynamic screenInfo) {
    return {
      "name": data.name,
      "systemName": data.systemName,
      "systemVersion": data.systemVersion,
      "model": data.model,
      "localizedModel": data.localizedModel,
      "identifierForVendor": data.identifierForVendor,
      "isPhysicalDevice": data.isPhysicalDevice,
      "utsname.sysname:": data.utsname.sysname,
      "utsname.nodename:": data.utsname.nodename,
      "utsname.release:": data.utsname.release,
      "utsname.version:": data.utsname.version,
      "utsname.machine:": data.utsname.machine,
      "screen.width": screenInfo["width"],
      "screen.height": screenInfo["height"],
      "screen.devicePixelRatio": screenInfo["devicePixelRatio"],
    };
  }
}
