import 'package:specter_mobile/app/models/CryptoContainerModel.dart';
import 'package:specter_mobile/app/widgets/qrCode/QRCodeScanner.dart';

import '../CServices.dart';
import 'providers/CCryptoProvider.dart';

class CControlWalletsService {
  CControlWalletsService(CCryptoProvider cryptoProvider);

  Future<bool> addNewWallet({required String walletName}) async {
    SMnemonicRootKey mnemonicRootKey = CServices.crypto.cryptoContainerAuth.getCurrentMnemonicRootKey();

    SWalletDescriptor walletDescriptor;
    try {
      walletDescriptor = CServices.crypto.cryptoProvider.getDefaultDescriptor(mnemonicRootKey, CServices.crypto.getCurrentNetwork());
    } catch(e) {
      print(e);
      return false;
    }

    //
    if (!(await CServices.crypto.privateCryptoContainer.addNewWallet(
        walletName: walletName,
        walletDescriptor: walletDescriptor
    ))) {
      return false;
    }
    return true;
  }

  Future<bool> addExistWallet({
    required String walletName,
    required String descriptor
  }) async {
    SMnemonicRootKey mnemonicRootKey = CServices.crypto.cryptoContainerAuth.getCurrentMnemonicRootKey();

    SWalletDescriptor walletDescriptor;
    try {
      walletDescriptor = CServices.crypto.cryptoProvider.getParsedDescriptor(mnemonicRootKey, descriptor, CServices.crypto.getCurrentNetwork());
    } catch(e) {
      print(e);
      return false;
    }

    //
    if (!(await CServices.crypto.privateCryptoContainer.addNewWallet(
        walletName: walletName,
        walletDescriptor: walletDescriptor
    ))) {
      return false;
    }
    return true;
  }

  SWalletModel getWalletByKey(String key) {
    return CServices.crypto.privateCryptoContainer.getWalletByKey(key);
  }

  String getPublicKey(PublicKey publicKey) {
    SMnemonicRootKey mnemonicRootKey = CServices.crypto.cryptoContainerAuth.getCurrentMnemonicRootKey();
    WalletNetwork net = CServices.crypto.getCurrentNetwork();

    String path = "m/84'/0'/0'";
    /*TODO: if (net != WalletNetwork.BITCOIN) {
      path = "m/84'/1'/0'";
    }*/

    switch(publicKey) {
      case PublicKey.SINGLE_SIG:
        path = 'm/84h/1h/0h';
        break;
      case PublicKey.MULTI_SIG:
        path = 'm/48h/1h/0h/2h';
        break;
    }

    String pubKey = CServices.crypto.cryptoProvider.getPublicKey(mnemonicRootKey, path, net);
    return pubKey;
  }
}