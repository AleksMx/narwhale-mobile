import 'package:flutter/material.dart';

import '../../../../../utils.dart';
import 'AccountWalletItem.dart';

class AccountItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: Utils.hexToColor('#202A40'),
            borderRadius: BorderRadius.all(Radius.circular(5))
        ),
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: getTopPanel(context)
            ),
            Container(
              width: double.infinity,
              child: getBottomPanel()
            )
          ],
        )
    );
  }

  Widget getTopPanel(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          child: Text('ACCOUNT #1', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Theme.of(context).accentColor)),
        ),
        Container(
          child: Text('Primary', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Theme.of(context).accentColor)),
        )
      ]
    );
  }

  Widget getBottomPanel() {
    List<Widget> rows = [];
    for (int i = 0; i < 2; i++) {
      rows.add(Container(
          width: double.infinity,
          decoration: BoxDecoration(
              border: Border(
                  top: BorderSide(color: Colors.grey[400]!)
              )
          ),
          margin: EdgeInsets.only(top: 15),
          child: AccountWalletItem()
      ));
    }
    return Column(
        children: rows
    );
  }
}

