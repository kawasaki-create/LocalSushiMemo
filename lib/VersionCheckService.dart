import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/services.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:sushi_memo_sns/VersionCheckService.dart';
import 'package:version/version.dart';

import 'main.dart';

/*
class VersionCheckService {
  static const String DEV_VERSION_CONFIG = "dev_app_version";
  static const String CONFIG_VERSION = "force_update_app_version";

  /// バージョンチェック関数
  Future<bool> versionCheck() async {
    // versionCode(buildNumber)取得
    final PackageInfo info = await PackageInfo.fromPlatform();
    int currentVersion = int.parse(info.buildNumber);
    // releaseビルドかどうかで取得するconfig名を変更
    final configName = bool.fromEnvironment('dart.vm.product')
        ? CONFIG_VERSION
        : DEV_VERSION_CONFIG;

    // remote config
    final FirebaseRemoteConfig remoteConfig = await RemoteConfig.instance;

    try {
      // 常にサーバーから取得するようにするため期限を最小限にセット
      await remoteConfig.setConfigSettings(RemoteConfigSettings(
        fetchTimeout: const Duration(seconds: 10),
        minimumFetchInterval: Duration.zero,
      ));
      await remoteConfig.fetchAndActivate();
      int newVersion = remoteConfig.getInt(configName);
      if (newVersion > currentVersion) {
        return true;
      }
    } on PlatformException catch (exception) {
      // Fetch throttled.
      print(exception);
    } catch (exception) {
      print('Unable to fetch remote config. Cached or default values will be '
          'used');
    }
    return false;
  }
}

/// 強制アップデートダイアログを出す為のダミーに近いStatefulWidget
class Updater extends StatefulWidget {
  Updater({Key? key}) : super(key: key);
  @override
  State<Updater> createState() => _UpdaterState();
}

class _UpdaterState extends State<Updater> {
  @override
  void initState() {
    final checker = locator<VersionCheckService>();
    checker.versionCheck().then((needUpdate) => _showUpdateDialog(needUpdate));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 1,
    );
  }

  // FIXME ストアにアプリを登録したらurlが入れられる
  static const APP_STORE_URL =
      'https://apps.apple.com/jp/app/id[アプリのApple ID]?mt=8';

  // FIXME ストアにアプリを登録したらurlが入れられる
  static const PLAY_STORE_URL =
      'https://play.google.com/store/apps/details?id=[アプリのパッケージ名]';

  /// 更新版案内ダイアログを表示
  void _showUpdateDialog(bool needUpdate) {
    if (!needUpdate) return;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        final title = "バージョン更新のお知らせ";
        final message = "新しいバージョンのアプリが利用可能です。ストアより更新版を入手して、ご利用下さい。";
        final btnLabel = "今すぐ更新";
        return Platform.isIOS
            ? new CupertinoAlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            FlatButton(
              child: Text(
                btnLabel,
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () => _launchURL(APP_STORE_URL),
            ),
          ],
        )
            : new AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            FlatButton(
              child: Text(
                btnLabel,
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () => _launchURL(PLAY_STORE_URL),
            ),
          ],
        );
      },
    );
  }
}

/// 指定のURLを起動する. App Store or Play Storeのリンク
void _launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

 */

///新しいやつ
/// 強制アップデートダイアログを出す為のダミーに近いStatefulWidget
class Updater extends StatefulWidget {
  Updater({Key? key, required this.appStoreUrl, required this.playStoreUrl}) : super(key: key);
  final String appStoreUrl;
  final String playStoreUrl;
  @override
  State<Updater> createState() => _UpdaterState(playStoreUrl: '', appStoreUrl: '');
}

  class _UpdaterState extends State<Updater> {
  _UpdaterState({required this.appStoreUrl, required this.playStoreUrl});
  final String appStoreUrl;
  final String playStoreUrl;

  @override
  void initState() {
    _shouldUpdate().then((needUpdate) => _showUpdateDialog(needUpdate));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 1,
    );
  }


  /// 更新版案内ダイアログを表示
  void _showUpdateDialog(bool needUpdate) {
    if (!needUpdate) return;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        final title = "バージョン更新のお知らせ";
        final message = "新しいバージョンのアプリが利用可能です。ストアより更新版を入手して、ご利用下さい。";
        final btnLabel = "今すぐ更新";
        return Platform.isIOS
            ? new CupertinoAlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            FlatButton(
              child: Text(
                btnLabel,
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () => _launchURL(appStoreUrl),
            ),
          ],
        )
            : new AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            FlatButton(
              child: Text(
                btnLabel,
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () => _launchURL(playStoreUrl),
            ),
          ],
        );
      },
    );
  }

  /// 指定のURLを起動する. App Store or Play Storeのリンク
  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<bool> _shouldUpdate() async {
    final packageInfo = await PackageInfo.fromPlatform();
    final appVersionStr = packageInfo.version;
    final appVersion = Version.parse(appVersionStr); // 現在のアプリのバージョン

    // remoteConfigの初期化
    final RemoteConfig remoteConfig = await RemoteConfig.instance;

    // 何らかの事情でRemoteConfigから最新の値を取ってこれなかった場合のフォールバック
    final defaultValues = <String, dynamic>{
      'android_required_semver': appVersionStr,
      'ios_required_semver': appVersionStr
    };
    await remoteConfig.setDefaults(defaultValues);

    await remoteConfig.fetch(); // デフォルトで12時間キャッシュされる
    await remoteConfig.fetchAndActivate();

    final remoteConfigAppVersionKey = Platform.isIOS
        ? 'ios_required_semver'
        : 'android_required_semver'; // iOSとAndroid以外のデバイスが存在しない世界線での実装
    final requiredVersion =
    Version.parse(remoteConfig.getString(remoteConfigAppVersionKey));
    return appVersion.compareTo(requiredVersion).isNegative;
  }
}