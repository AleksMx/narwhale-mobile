import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:specter_mobile/app/modules/200_wallets/walletInfo/views/wallet_info_view.dart';
import 'package:specter_mobile/app/routes/app_pages.dart';
import 'package:specter_mobile/services/cryptoService/providers/CCryptoProvider.dart';

import '../../../../../utils.dart';

class AccountItem extends StatelessWidget {
  final String walletKey;
  final int keyIndex;

  AccountItem({
    required this.walletKey,
    required this.keyIndex
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 15, bottom: 5),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              child: getOperationsList(context),
            )
          ]
        ),
      ),
    );
  }

  Widget getOperationsList(BuildContext context) {
    List<Widget> rows = [];
    for (int i = 0; i < 3; i++) {
      rows.add(Container(
        width: double.infinity,
        margin: EdgeInsets.only(top: rows.isEmpty?5:1),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Dec, 12, 2020', style: TextStyle(fontSize: 14, color: Theme.of(context).accentColor)),
            Text('send 0.01, change 0.100', style: TextStyle(fontSize: 14, color: Theme.of(context).accentColor)),
          ]
        )
      ));
    }
    return Column(
      children: rows
    );
  }
}