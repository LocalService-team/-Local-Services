class AppNotification {
  final String title;
  final String message;
  final DateTime createdAt;
  bool isRead;

  AppNotification({
    required this.title,
    required this.message,
    required this.createdAt,
    required this.isRead,
  });
}
