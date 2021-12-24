import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EnterSeedListController extends GetxController {
  Map<int, FocusNode> focusNodes = HashMap();
  Map<int, TextEditingController> controllers = HashMap();

  final int seedSize = 24;

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

  List<String> getSeedList() {
    List<String> list = [];
    bool haveData = false;
    controllers.forEach((key, ctx) {
      String val = ctx.text;
      if (val.isNotEmpty) {
        haveData = true;
      }
      list.add(val);
    });
    if (!haveData) {
      return [];
    }
    return list;
  }
}