class NotificationController {
  static final NotificationController _instance =
      NotificationController._intern();

  NotificationController._intern();

  factory NotificationController() => _instance;
}
