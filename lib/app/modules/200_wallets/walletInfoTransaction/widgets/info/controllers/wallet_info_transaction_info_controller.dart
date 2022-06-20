import 'package:get/get.dart';
import 'package:specter_mobile/app/models/CryptoContainerModel.dart';
import 'package:specter_mobile/app/models/TransactionsModels.dart';
import 'package:specter_mobile/app/modules/200_wallets/walletInfoAddress/widgets/details/widgets/WalletInfoAddressDetailsList.dart';

class WalletInfoTransactionInfoController extends GetxController {
  final SWalletModel walletItem;
  final SCryptoTransactionModel transaction;

  WalletInfoTransactionInfoController({required this.walletItem, required this.transaction});

  List<WalletInfoAddressDetailsNode> list = [];

  String transactionID = '???';

  @override
  void onInit() {
    super.onInit();

    list = [
      WalletInfoAddressDetailsNode('Net', '?'),
      WalletInfoAddressDetailsNode('From wallet', walletItem.name),
      WalletInfoAddressDetailsNode('Size', '?'),
      WalletInfoAddressDetailsNode('Mined at block', '?'),
      WalletInfoAddressDetailsNode('Block date', '?'),
      WalletInfoAddressDetailsNode('Block time', '?'),
      WalletInfoAddressDetailsNode('Inputs', transaction.inputs.length.toString()),
      WalletInfoAddressDetailsNode('Outputs', transaction.outputs.length.toString()),
      WalletInfoAddressDetailsNode('Received', '?')
    ];
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}