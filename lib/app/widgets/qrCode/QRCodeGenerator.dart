import 'dart:async';

import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../utils.dart';

class QRCodeGenerator extends StatefulWidget {
  final String data;
  final int maxChunkSize;
  final bool whiteColor;

  QRCodeGenerator({required this.data, this.maxChunkSize = 4, this.whiteColor = true});

  @override
  State<StatefulWidget> createState() {
    return QRCodeGeneratorState();
  }

}

class QRCodeGeneratorState extends State<QRCodeGenerator> {
  List<String> chunks = [];
  Timer? _timer;

  int currentChunkIdx = 0;
  int chunkDelayTimer = 300;

  @override
  void initState() {
    splitByChunks();
    if (chunks.length > 1) {
      _timer = Timer.periodic(Duration(milliseconds: chunkDelayTimer), (timer) {
        currentChunkIdx++;
        if (currentChunkIdx >= chunks.length) {
          currentChunkIdx = 0;
        }

        setState(() {
        });
      });
    }
    super.initState();
  }

  @override
  void dispose() {
    if (_timer != null) {
      _timer!.cancel();
    }
    super.dispose();
  }

  void splitByChunks() {
    if (widget.maxChunkSize < 1) {
      chunks = [widget.data];
      return;
    }
    chunks = Utils.splitStringByChunk(widget.data, widget.maxChunkSize);
  }

  @override
  Widget build(BuildContext context) {
    String chunkData = chunks[currentChunkIdx];
    return Column(
      children: [
        QrImage(
          data: chunkData,
          foregroundColor: widget.whiteColor?Colors.white:Colors.grey[800],
          version: QrVersions.auto
        ),
        //Text((currentChunkIdx + 1).toString() + '/' + chunks.length.toString(), style: TextStyle(color: Colors.grey[100]))
      ]
    );
  }
}