import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:specter_mobile/services/CServices.dart';
import 'package:specter_mobile/services/cryptoService/CRecoverySeedService.dart';

import 'enter_seed_list_controller.dart';

class EnterSeedController extends GetxController {
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

  void doneAction(BuildContext context) async {
    FocusScope.of(context).unfocus();

    //
    final EnterSeedListController enterSeedListController = Get.find<EnterSeedListController>();
    List<String> recoveryPhrases = enterSeedListController.getSeedList();
    if (recoveryPhrases.isEmpty) {
      await CServices.gNotificationService.addMessage(
          context, 'Oops!!', 'Please enter recovery phrase.',
          actionTitle: 'Try Again'
      );
      return;
    }

    //
    RecoverySeedResult? recoverySeedResult = await CServices.gCryptoService.recoverySeedService.verifyRecoveryPhrase(recoveryPhrases);
    if (recoverySeedResult == null) {
      await CServices.gNotificationService.addMessage(
          context, 'Oops!!', 'Please enter correct recovery phrase.',
          actionTitle: 'Try Again'
      );
      return;
    }

    String seedKey = recoverySeedResult.seedKey;
    if (!(await CServices.gCryptoContainer.addSeed(seedKey))) {
      await CServices.gNotificationService.addMessage(
          context, 'Oops!!', 'Please try again.',
          actionTitle: 'Try Again'
      );
      return;
    }

    await Get.offAllNamed('/onboarding');
  }
}
