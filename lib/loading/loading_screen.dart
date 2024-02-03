import 'dart:async';
import 'package:flutter/material.dart';
import 'package:we_chat/loading/loading_screen_controller.dart';

class LoadingScreen {
  factory LoadingScreen() => _shared;
  static final _shared = LoadingScreen._sharedInstance();

  LoadingScreen._sharedInstance();

  LoadingScreenController? controller;

  void show({
    required BuildContext context,
    required String text,
  }) {
    if(controller?.update(text) ?? false) {
      return;
    }
    controller = showOverlay(context: context, text: text);
  }

  void hide() {
    controller?.close();
    controller = null;
  }

  LoadingScreenController showOverlay({
    required BuildContext context,
    required String text,
  }) {
    final textStreamController = StreamController<String>();
    textStreamController.add(text);

    final state = Overlay.of(context);
    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;

    final overlay = OverlayEntry(
      builder: (context) {
        return Material(
          color: Colors.black.withAlpha(150),
          child: Center(
            child: Container(
              constraints: BoxConstraints(
                minWidth: size.width * 0.5,
                maxWidth: size.width * 0.8,
                maxHeight: size.height * 0.8,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
              ),
              padding: const EdgeInsets.all(16),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    const CircularProgressIndicator(),
                    const SizedBox(
                      height: 20,
                    ),
                    StreamBuilder(
                      stream: textStreamController.stream,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Text(
                            snapshot.data as String,
                            textAlign: TextAlign.center,
                          );
                        }
                        return Container();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
    state.insert(overlay);
    return LoadingScreenController(
      close: () {
        textStreamController.close();
        overlay.remove();
        return true;
      },
      update: (text) {
        textStreamController.add(text);
        return true;
      },
    );
  }
}
