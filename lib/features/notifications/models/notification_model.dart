class NotificationModel {
  final String title;
  final String message;
  final DateTime time;
  final bool isRead;
  final String avatarUrl;

  NotificationModel({
    required this.title,
    required this.message,
    required this.time,
    this.isRead = false,
    required this.avatarUrl,
  });

  static List<NotificationModel> sampleData = [
    NotificationModel(
      title: "Welcome to Singly!",
      message: "Thank you for joining. Let’s get you started.",
      time: DateTime.now().subtract(const Duration(minutes: 10)),
      avatarUrl: "https://i.pravatar.cc/150?img=1",
    ),
    NotificationModel(
      title: "Profile Update",
      message: "Your profile was updated successfully.",
      time: DateTime.now().subtract(const Duration(hours: 1)),
      isRead: true,
      avatarUrl: "https://i.pravatar.cc/150?img=2",
    ),
    NotificationModel(
      title: "New Match!",
      message: "You’ve got a new match, say hi!",
      time: DateTime.now().subtract(const Duration(days: 1)),
      avatarUrl: "https://i.pravatar.cc/150?img=3",
    ),
  ];
}
