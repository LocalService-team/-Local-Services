import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/app_notification.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  int firebaseNotificationCount = 0;
  List<AppNotification> notifications = [];

  int get unreadCount {
    return notifications.where((n) => !n.isRead).length;
  }

  void listenToNotifications() {
    FirebaseFirestore.instance.collection('notifications').snapshots().listen((
      snapshot,
    ) {
      notifications.clear();

      for (final doc in snapshot.docs) {
        final data = doc.data();

        notifications.add(
          AppNotification(
            id: doc.id,
            title: data['title'],
            message: data['message'],
            isRead: data['isRead'],
            createdAt: data['createdAt'].toDate(),
          ),
        );
      }

      setState(() {
        firebaseNotificationCount = snapshot.docs.length;
      });
    });
  }

  Future<void> markAsRead(AppNotification notification) async {
    await FirebaseFirestore.instance
        .collection('notifications')
        .doc(notification.id)
        .update({'isRead': true});
  }

  String getTimeAgo(DateTime dateTime) {
    final difference = DateTime.now().difference(dateTime);

    if (difference.inMinutes < 1) {
      return 'Just now';
    }

    if (difference.inMinutes < 60) {
      return '${difference.inMinutes} min ago';
    }

    if (difference.inHours < 24) {
      return '${difference.inHours} hours ago';
    }

    if (difference.inDays == 1) {
      return 'Yesterday';
    }

    return '${difference.inDays} days ago';
  }

  Future<void> testFirestore() async {
    notifications.clear();

    final snapshot = await FirebaseFirestore.instance
        .collection('notifications')
        .get();

    setState(() {
      firebaseNotificationCount = snapshot.docs.length;
    });

    print('Documents found: ${snapshot.docs.length}');

    for (final doc in snapshot.docs) {
      final data = doc.data();

      notifications.add(
        AppNotification(
          id: doc.id,
          title: data['title'],
          message: data['message'],
          isRead: data['isRead'],
          createdAt: data['createdAt'].toDate(),
        ),
      );
    }

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    listenToNotifications();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Notifications ($firebaseNotificationCount)')),
      body: Builder(
        builder: (context) {
          if (notifications.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.notifications_off, size: 80, color: Colors.grey),
                  SizedBox(height: 12),
                  Text(
                    'No notifications yet',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 6),
                  Text(
                    'We’ll notify you when something happens',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            itemCount: notifications.length,
            itemBuilder: (context, index) {
              final notification = notifications[index];

              return Dismissible(
                key: ValueKey(
                  notification.title + notification.createdAt.toString(),
                ),
                direction: DismissDirection.endToStart,
                onDismissed: (direction) {
                  setState(() {
                    notifications.removeAt(index);
                  });
                },
                background: Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  padding: const EdgeInsets.only(right: 20),
                  alignment: Alignment.centerRight,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.delete, color: Colors.white),
                ),
                child: GestureDetector(
                  onTap: () async {
                    if (!notification.isRead) {
                      await markAsRead(notification);
                    }
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: notification.isRead
                          ? Colors.grey.shade100
                          : Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: const [
                        BoxShadow(
                          blurRadius: 4,
                          color: Colors.black12,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CircleAvatar(child: Icon(Icons.notifications)),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  if (!notification.isRead)
                                    Container(
                                      width: 10,
                                      height: 10,
                                      margin: const EdgeInsets.only(right: 8),
                                      decoration: const BoxDecoration(
                                        color: Colors.red,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                  Expanded(
                                    child: Text(
                                      notification.title,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Text(notification.message),
                              const SizedBox(height: 6),
                              Text(
                                getTimeAgo(notification.createdAt),
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
