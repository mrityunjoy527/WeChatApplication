import 'package:flutter/foundation.dart' show immutable;

typedef CloseLoadingScreenController = bool Function();
typedef UpdateLoadingScreenController = bool Function(String text);

@immutable
class LoadingScreenController {
  final CloseLoadingScreenController close;
  final UpdateLoadingScreenController update;

  const LoadingScreenController({
    required this.close,
    required this.update,
  });
}
