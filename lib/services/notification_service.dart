import 'package:flutter/foundation.dart';
import '../models/notification_model.dart';

class NotificationService extends ChangeNotifier {
  static final NotificationService instance = NotificationService._internal();
  NotificationService._internal();

  final List<NotificationModel> _notifications = [
    NotificationModel(
      id: 'n1',
      title: 'Pesanan Sedang Dikirim! 🛵',
      message: 'Donat lezatmu (2x Rasa Coklat) sedang dalam perjalanan menuju alamat rumahmu.',
      timestamp: DateTime.now().subtract(const Duration(minutes: 15)),
      isRead: false,
      type: NotificationType.order,
    ),
    NotificationModel(
      id: 'n2',
      title: 'Promo Spesial Buatmu! 🍩',
      message: 'Gunakan kupon SWEET10K untuk nikmati paket donat lezat cuma 10k!',
      timestamp: DateTime.now().subtract(const Duration(hours: 2)),
      isRead: false,
      type: NotificationType.promo,
    ),
  ];

  List<NotificationModel> get notifications => List.unmodifiable(_notifications);

  int get unreadCount => _notifications.where((n) => !n.isRead).length;

  void addNotification({
    required String title,
    required String message,
    NotificationType type = NotificationType.order,
  }) {
    _notifications.insert(
      0,
      NotificationModel(
        id: 'n_${DateTime.now().millisecondsSinceEpoch}',
        title: title,
        message: message,
        timestamp: DateTime.now(),
        isRead: false,
        type: type,
      ),
    );
    notifyListeners();
  }

  void markAsRead(String id) {
    final index = _notifications.indexWhere((n) => n.id == id);
    if (index != -1 && !_notifications[index].isRead) {
      _notifications[index] = _notifications[index].copyWith(isRead: true);
      notifyListeners();
    }
  }

  void markAllAsRead() {
    bool changed = false;
    for (int i = 0; i < _notifications.length; i++) {
      if (!_notifications[i].isRead) {
        _notifications[i] = _notifications[i].copyWith(isRead: true);
        changed = true;
      }
    }
    if (changed) {
      notifyListeners();
    }
  }

  String formatRelativeTime(DateTime dateTime) {
    final diff = DateTime.now().difference(dateTime);
    if (diff.inMinutes < 1) {
      return 'Baru saja';
    } else if (diff.inMinutes < 60) {
      return '${diff.inMinutes} mnt lalu';
    } else if (diff.inHours < 24) {
      return '${diff.inHours} jam lalu';
    } else {
      return '${diff.inDays} hari lalu';
    }
  }
}
