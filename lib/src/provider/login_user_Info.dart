// ignore_for_file: file_names

import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:tencent_cloud_chat_demo/src/avatar_select_page.dart';
import 'package:tencent_cloud_chat_uikit/tencent_cloud_chat_uikit.dart';

class LoginUserInfo with ChangeNotifier {
  V2TimUserFullInfo _loginUserInfo = V2TimUserFullInfo();
  final CoreServicesImpl _coreServices = TIMUIKitCore.getInstance();
  V2TimUserFullInfo get loginUserInfo {
    return _loginUserInfo;
  }

  setLoginUserInfo(V2TimUserFullInfo info) {
    _loginUserInfo = info;
    if (_loginUserInfo.faceUrl == null || _loginUserInfo.faceUrl!.isEmpty) {
      setRandomAvatar();
    }
    notifyListeners();
  }

  setRandomAvatar() async {
    int index = Random().nextInt(AvatarSelectPage.avatarFaceCount);
    String faceUrl =
        AvatarSelectPage.avatarFaceUrl.replaceAll("%s", (index + 1).toString());
    await _coreServices.setSelfInfo(
        userFullInfo: V2TimUserFullInfo.fromJson({
      "faceUrl": faceUrl,
    }));
    _loginUserInfo.faceUrl = faceUrl;
    notifyListeners();
  }
}
