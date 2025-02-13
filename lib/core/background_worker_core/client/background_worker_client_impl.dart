import 'dart:async';

import 'package:news_app/core/background_worker_core/background_worker_core.dart';

class BackgroundWorkerClientImpl implements BackgroundWorkerClient {
  Timer? _timer;

  @override
  void startWorker({
    required int secondsInterval,
    required void Function() onBackgroundTask,
  }) {
    _timer ??= Timer.periodic(Duration(seconds: secondsInterval), (_) {
      onBackgroundTask();
    });
  }

  @override
  void cancelWorker() {
    _timer?.cancel();
    _timer = null;
  }
}
