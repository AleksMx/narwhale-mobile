import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:specter_mobile/app/models/CryptoContainerModel.dart';
import 'package:specter_mobile/app/widgets/qrCode/QRCodeScanner.dart';
import 'package:specter_mobile/services/cryptoContainer/private/storages/DiskStorageJSON.dart';
import 'package:specter_mobile/services/cryptoService/providers/CCryptoProvider.dart';
import 'package:specter_mobile/utils.dart';

import '../CServices.dart';

class SCryptoTransactionPoint {
  final String address;
  final double value;
  final String walletKey;

  SCryptoTransactionPoint({
    required this.address,
    required this.value,
    required this.walletKey
  });

  Map<String, dynamic> toJSON() {
    return {
      'address': address,
      'value': value,
      'wallet': walletKey
    };
  }

  @override
  String toString() {
    return jsonEncode(toJSON());
  }
}

class SCryptoTransactionModel {
  final double fee;
  final List<SCryptoTransactionPoint> inputs;
  final List<SCryptoTransactionPoint> outputs;

  late int addTime;
  late String key;
  
  SCryptoTransactionModel({
    required this.fee,
    required this.inputs,
    required this.outputs
  }) {
    addTime = Utils.getTimeMs();
    key = getTxKey();
  }

  String getTxKey() {
    String str = '';
    str += 'inputs:';
    inputs.forEach((el) {
      str += el.address + '>' + el.value.toString() + ';';
    });
    str += 'outputs:';
    outputs.forEach((el) {
      str += el.address + '>' + el.value.toString() + ';';
    });
    str += 'fee:' + fee.toString() + ';';

    //
    return sha256.convert(utf8.encode(str)).toString().toUpperCase();
  }

  Map<String, dynamic> toJSON() {
    List<dynamic> inputsJson = [];
    List<dynamic> outputsJson = [];

    inputs.forEach((el) {
      inputsJson.add(el.toJSON());
    });
    outputs.forEach((el) {
      outputsJson.add(el.toJSON());
    });

    return {
      'key': key,
      'addTime': addTime,
      'fee': fee,
      'inputs': inputsJson,
      'output': outputsJson
    };
  }

  @override
  String toString() {
    return jsonEncode(toJSON());
  }
}

class CControlTransactionsService {
  late final CCryptoProvider _cryptoProvider;

  CControlTransactionsService(CCryptoProvider cryptoProvider): _cryptoProvider = cryptoProvider;

  SCryptoTransactionModel parseTransaction(QRCodeScannerResultParseTransaction transaction) {
    SMnemonicRootKey mnemonicRootKey = CServices.crypto.cryptoContainerAuth.getCurrentMnemonicRootKey();
    List<SWalletModel> wallets = CServices.crypto.privateCryptoContainer.getWallets();
    return CServices.crypto.cryptoProvider.parseTransaction(mnemonicRootKey, transaction, wallets, CServices.crypto.getCurrentNetwork());
  }

  void saveTransaction(SCryptoTransactionModel transaction) {
    DiskStorageJSON storageJSON = CServices.crypto.privateCryptoContainer.getTransactionsStorage();
    var obj = storageJSON.readData();
    obj ??= {
        'transactions': []
      };

    List<dynamic> transactions = obj['transactions'];
    transactions.forEach((tx) {
      if (tx['key'] == transaction.key) {
        throw 'Already exists';
      }
    });

    transactions.add(transaction.toJSON());

    print(obj.toString());

    storageJSON.saveData(obj);
  }
}