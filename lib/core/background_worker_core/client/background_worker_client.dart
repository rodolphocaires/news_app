abstract class BackgroundWorkerClient {
  void startWorker({
    required int secondsInterval,
    required void Function() onBackgroundTask,
  });

  void cancelWorker();
}
