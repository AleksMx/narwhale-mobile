import 'package:get/get.dart';
import 'package:specter_mobile/services/CServices.dart';
import 'package:specter_mobile/services/cryptoService/providers/CCryptoProvider.dart';

class OptionsViewPublicKeyController extends GetxController {
  var currentTab = PublicKey.SINGLE_SIG.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  void setCurrentTab(String key) {
    var val = getTabKey(key);
    currentTab.value = val!;
  }

  PublicKey? getTabKey(String key) {
    switch(key) {
      case 'PublicKey.SINGLE_SIG': return PublicKey.SINGLE_SIG;
      case 'PublicKey.MULTI_SIG': return PublicKey.MULTI_SIG;
    }
  }

  String getPublicKey() {
    return CServices.crypto.controlWalletsService.getPublicKey(currentTab.value);
  }
}
