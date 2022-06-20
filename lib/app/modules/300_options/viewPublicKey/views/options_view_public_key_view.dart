import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:specter_mobile/app/widgets/LightButton.dart';
import 'package:specter_mobile/app/widgets/LightTab.dart';
import 'package:specter_mobile/app/widgets/TopSide.dart';
import 'package:specter_mobile/app/widgets/qrCode/QRCodeGenerator.dart';
import 'package:specter_mobile/services/CServices.dart';
import 'package:specter_mobile/services/cryptoService/providers/CCryptoProvider.dart';

import '../controllers/options_view_public_key_controller.dart';

class OptionsViewPublicKeyView extends GetView<OptionsViewPublicKeyController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getBody(context)
    );
  }

  Widget getBody(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TopSide(
            title: 'Public Keys',
            titleType: TOP_SIDE_TITLE_TYPE.NONE,
            menuType: TOP_SIDE_MENU_TYPE.NONE,
            openMenu: () {
            }
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: getContent(context)
            )
          )
        ]
      )
    );
  }
  
  Widget getContent(BuildContext context) {
    return Obx(() => Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            child: LightTab(
              tabs: [
                LightTabNode('Single Sig (Segwit)', key: PublicKey.SINGLE_SIG.toString()),
                LightTabNode('Multisig Sig (Segwit)', key: PublicKey.MULTI_SIG.toString())
              ],
              tabKey: controller.currentTab.toString(),
              onSelect: (String key) {
                controller.setCurrentTab(key);
              }
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 20),
            child: getTabContent(context)
          )
        ]
      )
    ));
  }

  Widget getTabContent(BuildContext context) {
    String pubKey = controller.getPublicKey();
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          getQRCodePanel(pubKey),
          Container(
            margin: EdgeInsets.only(top: 20),
            child: Text(pubKey)
          ),
          Container(
            margin: EdgeInsets.only(top: 20),
            child: getCopyAddress(context, pubKey)
          )
        ]
      ),
    );
  }

  Widget getQRCodePanel(String pubKey) {
    return Container(
      width: double.infinity,
      child: Center(
        child: Container(
          key: Key('qrCode_' + controller.currentTab.toString()),
          constraints: BoxConstraints(
            maxWidth: 200
          ),
          child: QRCodeGenerator(
            data: pubKey,
            maxChunkSize: 0
          )
        )
      )
    );
  }

  Widget getCopyAddress(BuildContext context, String pubKey) {
    return LightButton(child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(right: 10),
          child: SvgPicture.asset('assets/icons/content_copy.svg', color: Colors.white),
        ),
        Text('COPY', style: TextStyle(color: Colors.white))
      ],
    ), onTap: () {
      copyAddress(context, pubKey);
    });
  }

  void copyAddress(BuildContext context, String pubKey) {
    Clipboard.setData(ClipboardData(text: pubKey));
    CServices.notify.addNotify(context, 'Public key copied');
  }
}
